class Redacteur {
  final int? id;
  final String nom;
  final String prenom;
  final String email;
  // Construteur avec id
  Redacteur({required this.id, required this.nom, required this.prenom, required this.email});

  // Construteur sans id
  Redacteur.sansId({required this.nom, required this.prenom, required this.email}):id=null;

  Map<String, dynamic> toMap(){
    final map = <String, dynamic>{
      'nom' : nom,
      'prenom' : prenom,
      'email' : email
    };
    if(id!=null){
      map['id'] = id;
    }
    return map;
  }

  factory Redacteur.fromMap(Map<String, dynamic>map){
    return Redacteur(
        id: map['id'] as int?,
        nom: map['nom'] as String,
        prenom: map['prenom'] as String,
        email: map['email'] as String
    );
  }
}