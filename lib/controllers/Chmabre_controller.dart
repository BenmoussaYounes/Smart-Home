import 'package:get/get.dart';
import 'package:smart_home_12/db/db_home.dart';
import 'package:smart_home_12/model/Chambre.dart';

class ChambreController extends GetxController {
  RxList<chambre> chambre_list = <chambre>[].obs;

  Future<void> getChambre({required String id_user}) async {
    List<chambre> temp_list = <chambre>[];
    // Get Data from Data Base and Update it into the app ( rxList)
    List<Map<String, dynamic>> _list_chambres =
        await DB_Home.get_db_Chambre(id_user: id_user);

    if (_list_chambres != []) {
      print('i made it here');
      _list_chambres.forEach((element) {
        temp_list.add(chambre(
            title: element['title'],
            id_user: id_user,
            id_chambre: element['id_chambre']));
      });
      chambre_list.assignAll(temp_list);
    } else {
      _list_chambres = [];
    }
    print(chambre_list.length);
    print(chambre_list.isEmpty);
  }

  Future addChambre({required chambre Chambre}) async {
    return await DB_Home.add_db_chambre(
        chambre_name: Chambre.title, id_user: Chambre.id_user);
  }

  Future delete_Chambre({required chambre Chambre}) async {
    return await DB_Home.delete_db_chambre(chambre_id: Chambre.id_chambre!);
  }
}
