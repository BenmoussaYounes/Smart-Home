import 'package:get/get.dart';
import 'package:smart_home_12/db/db_home.dart';
import 'package:smart_home_12/model/module.dart';

class moduleController extends GetxController {


  final RxList<module> deviceLists = <module>[
    // module(id: 25, type: 'rgb', name: 'RGB '),
    // module(id: 25, type: 'light', name: 'Led_Light'),
    // module(id: 25, type: 'led', name: 'Light Kids'),
    // module(id: 25, type: 'roller', name: 'Vollet'),
  ].obs;
  Future getModulesList({required int id_chambre}) async {
    List<module> _swap_list = [];
    List _temp_list = await DB_Home.get_devices_lists(id_chambre: id_chambre);
    _temp_list.forEach((element) {
      _swap_list.add(module(
          id: element['id_module'],
          name: element['title'],
          type: element['type']));
    });
    deviceLists.assignAll(_swap_list);
  }

  addmodule(
      {required int id,
      required String title,
      required String type,
      required int id_chambre}) {

    DB_Home.add_db_module(
        id: id, title: title, type: type, id_chambre: id_chambre);       
  }

  deletemodule({required int id_module}) {
    DB_Home.delete_device(id_module: id_module);
  }
}
