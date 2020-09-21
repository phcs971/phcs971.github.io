import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:firebase_core/firebase_core.dart';

import 'src/app.dart';
import 'src/locators.dart';
import 'src/utils/logger.dart';

void main() async {
  log.v("<Main> Start");

  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      name: 'portifolio',
      options: FirebaseOptions(
        apiKey: "AIzaSyDgwEVl6_gD2LnZe6h1oB6djfraGI_LYdQ",
        authDomain: "portifolio-phcs971.firebaseapp.com",
        databaseURL: "https://portifolio-phcs971.firebaseio.com",
        projectId: "portifolio-phcs971",
        storageBucket: "portifolio-phcs971.appspot.com",
        messagingSenderId: "531371008619",
        appId: kIsWeb
            ? "1:531371008619:web:39f071ad280c772968c72e"
            : "1:531371008619:android:b25356a7f27528f168c72e",
        measurementId: "G-HJ407G0GMC",
      ),
    );
  } catch (_) {}

  log.v("<Main> Locator Setup - Start");
  await locatorSetup();
  log.v("<Main> Locator Setup - Finish");

  log.v("<Main> Run App");

  runApp(PortfolioApp());
}

//TODOZAO
//21 Seg ->
//22 Ter -> Criar Função P/ Adcionar
//23 Qua -> Popular Projetos
//24 Qui -> Popular Projetos
//25 Sex -> Popular Conquistas
//26 Sab -> Popular Conquistas
//27 Dom ->
//28 Seg -> Gravar video
