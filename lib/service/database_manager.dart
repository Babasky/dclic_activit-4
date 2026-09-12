import 'package:activite1/modele/redacteur.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  DatabaseManager._interne();
  static final DatabaseManager instance = DatabaseManager._interne();

  Database? _database;
  static const String tableRedacteur = 'redacteur';

  // Recupération de la base de données
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // intialisation de la base de données
  Future<Database> _initDatabase() async {
    final chemin = join(await getDatabasesPath(), 'redacteurs.db');
    return openDatabase(
      chemin,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $tableRedacteur(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nom TEXT NOT NULL,
            prenom TEXT NOT NULL,
            email TEXT NOT NULL UNIQUE
          )
        ''');
      },
    );
  }

  // Requête de recupération de tous les rédacteurs
  Future<List<Redacteur>> getAllRedacteur() async {
    final db = await database;
    final lignes = await db.query(tableRedacteur, orderBy: 'nom');
    return lignes.map((ligne) => Redacteur.fromMap(ligne)).toList();
  }

  // Requête d'insertion de rédacteur
  Future<int> insertRedacteur(Redacteur redacteur) async {
    final db = await database;
    return db.insert(tableRedacteur, redacteur.toMap());
  }

  // Requête de modification d'un rédacteur
  Future<int> updateRedacteur(Redacteur redacteur) async {
    final db = await database;
    return db.update(
      tableRedacteur,
      redacteur.toMap(),
      where: 'id = ?',
      whereArgs: [redacteur.id],
    );
  }

  // Requête de suppression d'un rédacteur
  Future<int> deleteRedacteur(int id) async {
    final db = await database;
    return db.delete(tableRedacteur, where: 'id = ?', whereArgs: [id]);
  }

  // Recherche par nom ou prénom
  Future<List<Redacteur>> searchRedacteurs(String query) async {
    final db = await database;
    final lignes = await db.query(
      tableRedacteur,
      where: 'nom LIKE ? OR prenom LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
      orderBy: 'nom',
    );
    return lignes.map((ligne) => Redacteur.fromMap(ligne)).toList();
  }
}
