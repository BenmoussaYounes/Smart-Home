import 'package:get_storage/get_storage.dart';

class CityInfo {
  final GetStorage _box = GetStorage();
  final _key = 'location';

  dynamic load_location_fromBox() => _box.read(_key) ?? '';

  save_location_change_to_box(String _place) => _box.write(_key, _place);
}
