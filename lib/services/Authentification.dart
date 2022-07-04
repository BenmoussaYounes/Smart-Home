import 'package:get_storage/get_storage.dart';
import 'package:smart_home_12/db/db_home.dart';

class signup {
  final GetStorage _box = GetStorage();
  final _key = 'have_access';

  bool _load_access_fromBox() => _box.read<bool>(_key) ?? false;

  _savechangetobox(bool _access) => _box.write(_key, _access);

  getaccess() {
    return _load_access_fromBox();
  }

  updateaccess(bool _access) {
    _savechangetobox(_access);
  }
}

class user_info {
  final GetStorage _box = GetStorage();
  final _key = 'id_user';
  final _key_ip = 'ip_user';
  dynamic _load_id_fromBox() => _box.read(_key) ?? false;

  _save_id_changetobox(String _id_user) => _box.write(_key, _id_user);

  get_user_id() {
    return _load_id_fromBox();
  }

  update_user_id({required String email, required String mdp}) async {
    await DB_Home.get_id_user(email: email, mdp: mdp);
  }

// Ip info ---
  dynamic _load_ip_fromBox() => _box.read(_key_ip) ?? false;

  _save_ip_changetobox(String _ip_user) => _box.write(_key, _ip_user);

  get_user_ip() {
    return _load_ip_fromBox();
  }

  update_user_ip({required String email, required String mdp}) async {
    await DB_Home.get_db_ip(email: email, mdp: mdp);
  }
}
