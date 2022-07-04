import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:smart_home_12/controllers/Sc%C3%A9nario_controller.dart';
import 'package:smart_home_12/screens/Scences/ScenarioButton.dart';
import 'package:smart_home_12/screens/Scences/add_Scenario_page.dart';
import 'package:smart_home_12/services/Authentification.dart';
import '../../model/scenario.dart';
import '../../utils/AppAssets.dart';
import '../../utils/theme.dart';

class ScenarioPage extends StatefulWidget {
  const ScenarioPage({Key? key}) : super(key: key);

  @override
  State<ScenarioPage> createState() => _ScenarioPageState();
}

class _ScenarioPageState extends State<ScenarioPage> {
  late int Id;
  ScenarioController _scenarioList = ScenarioController();
  @override
  void initState() {
    Id = user_info().get_user_id();
    super.initState();
    _scenarioList.getScenario(id_provider: Id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Get.to(AddScenarioPage());
            _scenarioList.getScenario(id_provider: Id);
          },
          child: Icon(Icons.add_task_outlined),
        ),
        body: _ShowScenes(),
      ),
    );
  }

  Future<void> _onRefresh() async {
    _scenarioList.getScenario(id_provider: Id);
  }

  Widget _ShowScenes() {
    return Obx(() {
      if (_scenarioList.ScenesLists.isEmpty) {
        return _no_scenario_widget();
      } else {
        return _senarios_list();
      }
    });
  }

  Widget _senarios_list() {
    return RefreshIndicator(
      color: Get.isDarkMode ? Colors.white : kPrimaryColor,
      onRefresh: _onRefresh,
      child: ListView.builder(
          itemCount: _scenarioList.ScenesLists.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext contex, int index) {
            Scenario _scene = _scenarioList.ScenesLists[index];
            return ScenarioButton(index, _scene);
          }),
    );
  }

  //physics: AlwaysScrollableScrollPhysics(),
  //physics: NeverScrollableScrollPhysics(),
  Widget _no_scenario_widget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 2000),
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                color: Get.isDarkMode ? Colors.white : kPrimaryColor,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppAssets.no_scenario,
                        color: Get.isDarkMode ? Colors.white : kPrimaryColor,
                        height: 200,
                        semanticsLabel: 'Task',
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'Vous n avez pas de Scénario ! \n Clicke sur le boutton pour Ajoute de nouveau scénario ',
                          style: titlestyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
