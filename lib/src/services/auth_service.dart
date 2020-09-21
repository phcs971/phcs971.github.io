import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../locators.dart';
import '../utils/utils.dart';
import '../models/profile.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final FirestoreService _firestoreService = locator<FirestoreService>();

  Profile _currentUser;
  Profile get currentUser => _currentUser;

  Future login() async {
    try {
      log.v("<Auth> Login via Google Start");
      var acc = await _googleSignIn.signIn();
      final auth = await acc.authentication;
      log.v("<Auth> Login via Google Credentials / ${auth.accessToken}");
      var res = await _firebaseAuth.signInWithCredential(GoogleAuthProvider.credential(
        accessToken: auth.accessToken,
        idToken: auth.idToken,
      ));
      await _firestoreService.createUser(Profile.create(res.user.uid, res.user.email));
      await _populateCurrentUser(res.user);
      log.i("<Auth> Login via Google Success / UID = ${res?.user?.uid}");
      return res.user != null;
    } catch (e) {
      String mes;
      try {
        mes = e.message;
      } catch (_) {
        mes = e.toString();
      }
      log.e("<Auth> Login via Google Failed / $mes");
      return mes;
    }
  }

  Future<bool> hasUser() async {
    var user = _firebaseAuth.currentUser;
    log.v("<Auth> Verifying current user");
    await _populateCurrentUser(user);
    return _firebaseAuth.currentUser != null;
  }

  Future _populateCurrentUser(User user) async {
    log.v("<Auth> Populating current user");
    if (user != null) _currentUser = await _firestoreService.getUser(user.uid);
  }

  Future logOut() async {
    log.i("<Auth> Logging out");
    _currentUser = null;
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }
}
