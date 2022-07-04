import 'package:get/get.dart';
import 'package:smart_home_12/db/db_home.dart';
import 'package:smart_home_12/model/scenario.dart';

class ScenarioController extends GetxController {
  final RxList<Scenario> ScenesLists = <Scenario>[].obs;
  Future<int> addScene({required Scenario scenario}) {
    return DB_Home.add_db_scenario(
        scenario_name: scenario.title,
        color: scenario.color,
        id_scenario: scenario.id_provider);
  }

  Future<void> getScenario({required int id_provider}) async {
    List<Scenario> swap_list = <Scenario>[];
    // Get Data from Data Base and Update it into the app ( rxList)
    List<Map<String, dynamic>> _temp =
        await DB_Home.get_db_scenario(id_user: id_provider);
    _temp.forEach((element) {
      swap_list.add(Scenario(
          id_provider: id_provider,
          id_scenario: element['id_scenario'],
          title: element['title'],
          color: element['color']));
    });
    ScenesLists.assignAll(swap_list);
  }

  void deleteScenario({required int scenario_id}) async {
    await DB_Home.delete_db_scenario(scenario_id: scenario_id);
  }
}
