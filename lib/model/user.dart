class user {
  //Identifiant d’utilisateur
  int? id_user;
  //Nom d’utilisateur
  String? nom_utilisateur;
  //adresse locale d’etulisateur
  String? adresse_ip;
  //Email utilisateur
  String? email;
  //Mode de passe etulisateur
  String? mot_de_passe;
  user({
    this.id_user,
    required this.nom_utilisateur,
    required this.adresse_ip,
    required this.mot_de_passe,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'id_user': id_user,
      'nom_utilisateur': nom_utilisateur,
      'adresse_ip': adresse_ip,
      'email': email,
      'mot_de_passe': mot_de_passe,
    };
  }

  user.fromJson(Map<String, dynamic> json) {
    id_user = json['id_user']?.toInt();
    nom_utilisateur = json['nom_utilisateur'];
    adresse_ip = json['adresse_ip'] ?? '';
    email = json['email'] ?? '';
    mot_de_passe = json['mot_de_passe'] ?? '';
  }
}
