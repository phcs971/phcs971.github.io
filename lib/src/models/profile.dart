class Profile {
  final String? id;
  final String? email;
  final bool? admin;

  Profile.create(this.id, this.email) : admin = false;

  Profile.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        email = map['email'],
        admin = map['admin'];

  Map<String, dynamic> toMap() => {'id': id, 'email': email, 'admin': admin};
}
