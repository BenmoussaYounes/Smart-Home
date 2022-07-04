import 'package:get_storage/get_storage.dart';
import 'package:sqflite/sqflite.dart';
import '../model/user.dart';

class DB_Home {
  static Database? _db;
  static const int _version = 1;
  static const String _utilisateur_table = 'utilisateur';
  static const String _chambre_table = 'chambre';
  static const String _scenario_table = 'scenario';
  static const String _module_table = 'module';
  // -- Init Db + Table Creation --
  static Future<void> init_user_db() async {
    if (_db != null) {
      print('not null db');
      return;
    } else {
      try {
        String _path = await getDatabasesPath() + 'smarthome.db';
        print('indatabase path');
        _db = await openDatabase(_path, version: _version,
            onCreate: (Database db, int version) async {
          //Whene creating the db create the table
          print('table - user');
          await db.execute(
              'CREATE TABLE $_utilisateur_table(id_user INTEGER PRIMARY KEY AUTOINCREMENT, nom_utilisateur TEXT, adresse_ip TEXT, email TEXT, mot_de_passe TEXT)');
          print('table -Chambre ');
          await db.execute(
              'CREATE TABLE $_chambre_table(id_chambre INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, id_provider INTEGER)');
          // FOREIGN KEY(id_provider) REFERENCES utilisateur(id_user)
          print('table-Scenario');
          await db.execute(
              'CREATE TABLE $_scenario_table(id_scenario INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, color INTEGER, id_provider INTEGER)');
          print('table_module');
          await db.execute(
              'CREATE TABLE $_module_table(id_module INTEGER PRIMARY KEY, title TEXT, type TEXT, id_chambre INTEGER)');
        });
        print('--Tables Created--');
      } catch (e) {
        print(e);
      }
    }
  }

  // User db  Methods --
  static Future<int> insert_db_user(user _user) async {
    print('Insert into db');
    String sql =
        'INSERT INTO $_utilisateur_table( nom_utilisateur, adresse_ip, email, mot_de_passe) VALUES("${_user.nom_utilisateur}", "${_user.adresse_ip}", "${_user.email}", "${_user.mot_de_passe}")  ';
    int id = await _db!.rawInsert(sql);
    print(id);
    return id;
    // 'INSERT INTO Test(name, value, num) VALUES("some name", 1234, 456.789)');
  }

  static Future<List<Map<String, dynamic>>> get_db_emails() async {
    print('Query');
    String sql = "SELECT email FROM utilisateur ";
    return await _db!.rawQuery(sql);
  }

  static Future<List<Map<String, dynamic>>> get_db_mdp() async {
    print('Query');
    String sql = "SELECT mot_de_passe FROM utilisateur ";
    return await _db!.rawQuery(sql);
  }

  static get_id_user({required String email, required String mdp}) async {
    final GetStorage _box = GetStorage();
    final _key = 'id_user';
    var b = _box.read(_key) ?? false;
    print(b);
    print('geting new loged in id user');
    String sql =
        'SELECT id_user FROM utilisateur WHERE (email = "$email" AND mot_de_passe = "$mdp")';
    var user = await _db!.rawQuery(sql);
    _box.write(_key, user[0]['id_user']);
    var a = _box.read(_key) ?? false;
    print('id_user : $a');
  }

  static get_db_ip({required String email, required String mdp}) async {
    final GetStorage _box = GetStorage();
    final _key = 'ip_user';
    print('Query-Getting Ip');
    String sql =
        "SELECT adresse_ip FROM utilisateur  WHERE (email = '$email' AND mot_de_passe = '$mdp')";
    var user = await _db!.rawQuery(sql);
    _box.write(_key, user[0]['adresse_ip']);
    var a = _box.read(_key) ?? false;
    print('Ip : $a');
  }

// Chambres db Methods ---
  static Future<List<Map<String, dynamic>>> get_db_Chambre(
      {required String id_user}) async {
    print('Query-Getting chambres');
    String sql =
        "SELECT title, id_chambre FROM $_chambre_table WHERE id_provider = '$id_user'";
    return await _db!.rawQuery(sql);
  }

  static Future<int> add_db_chambre(
      {required String chambre_name, required String id_user}) async {
    print('Insert into db');
    String sql =
        'INSERT INTO $_chambre_table( title, id_provider) VALUES( "$chambre_name", "$id_user")';
    int id = await _db!.rawInsert(sql);
    print('id');
    return id;
    // 'INSERT INTO Test(name, value, num) VALUES("some name", 1234, 456.789)');
  }

// Test
  static Future delete_db_chambre({required int chambre_id}) async {
    print('Delete from  db');
    String sql1 = 'DELETE FROM $_module_table WHERE id_chambre = $chambre_id';
    String sql2 = 'DELETE FROM $_chambre_table WHERE  id_chambre = $chambre_id';
    await _db!.rawDelete(sql1);
    return await _db!.rawDelete(sql2);
  }

  // Scenario methods

  static Future<int> add_db_scenario(
      {required String scenario_name,
      required int color,
      required int id_scenario}) async {
    print('Insert Scenario');
    String sql =
        'INSERT INTO $_scenario_table( title, color, id_provider) VALUES( "$scenario_name", $color, $id_scenario)';
    int id = await _db!.rawInsert(sql);
    print('id : $id');
    return id;
  }

  static Future<List<Map<String, dynamic>>> get_db_scenario(
      {required int id_user}) async {
    print('Query-Getting Scenarios db ');
    String sql =
        "SELECT id_scenario, title, color  FROM $_scenario_table WHERE id_provider = $id_user";
    return await _db!.rawQuery(sql);
  }

  static Future delete_db_scenario({required int scenario_id}) async {
    print('Delete from  db');
    String sql =
        'DELETE FROM $_scenario_table WHERE  id_scenario = $scenario_id';
    return await _db!.rawDelete(sql);
  }

  // module methods
  static Future add_db_module(
      {required int id,
      required String title,
      required String type,
      required int id_chambre}) async {
    print('adding to db ');
    String sql =
        'INSERT INTO $_module_table( id_module, title, type, id_chambre) VALUES( $id, "$title", "$type", $id_chambre)';
    return await _db!.rawInsert(sql);
  }

  static Future<List<Map<String, dynamic>>> get_devices_lists(
      {required int id_chambre}) async {
    print('Query-Getting devices db ');
    String sql =
        "SELECT  id_module, title, type FROM $_module_table WHERE id_chambre = $id_chambre";
    var a = await _db!.rawQuery(sql);
    print('a : $a');
    return a;
  }

  static Future delete_device({required int id_module}) async {
    print('delete device from db');
    String sql = 'DELETE FROM $_module_table WHERE id_module = $id_module';
    var a = await _db!.rawDelete(sql);
    return a;
  }
}
