// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_home_12/model/scenario.dart';
import 'package:smart_home_12/services/Authentification.dart';
import '../../controllers/Scénario_controller.dart';
import '../../utils/theme.dart';
import '../../widgets/buttons.dart';
import '../../widgets/input_field.dart';

class AddScenarioPage extends StatefulWidget {
  @override
  State<AddScenarioPage> createState() => _AddScenarioPageState();
}

class _AddScenarioPageState extends State<AddScenarioPage> {
  final ScenarioController _scenarioController = Get.put(ScenarioController());
  //final TextEditingController _titleController = TextEditingController();

  String _SelectedScene = 'None';
  List<String> SceneList = [
    'Simulation de precense',
    'On-All',
    'Of-All',
    'On_All_Light',
    'Of_All_Light',
    'open_All_rollers_at_50',
    'open_All_rollers',
    'close_All_rollers',
  ];
  int _SelectedColor = 0;
  late int Id_provider;
  @override
  void initState() {
    Id_provider = user_info().get_user_id();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _Appbar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
          Text('Ajouté Scéne ', style: headingstyle),
          InputField(
            title: 'Liste des Scénes',
            hint: _SelectedScene,
            widget: Row(children: [
              DropdownButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  underline: Container(height: 0),
                  style: subtitlestyle,
                  elevation: 4,
                  iconSize: 32,
                  dropdownColor: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10),
                  onChanged: (String? newvalue) {
                    setState(() {
                      _SelectedScene = newvalue!;
                    });
                  },
                  items: SceneList.map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            '$value',
                            style: const TextStyle(color: Colors.white),
                          ))).toList()),
              const SizedBox(
                width: 6,
              ),
            ]),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _Colorpalllet(),
              MyButton(
                  label: 'Creé Scéne',
                  onTap: () {
                    if (_SelectedScene != 'None') {
                      _scenarioController.addScene(
                          scenario: Scenario(
                              id_provider: Id_provider,
                              title: _SelectedScene,
                              color: _SelectedColor));
                      Get.back();
                    } else {}
                  })
            ],
          )
        ])),
      ),
    );
  }

  AppBar _Appbar() => AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios, size: 24, color: primaryClr),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
      );

  Column _Colorpalllet() {
    return Column(
      children: [
        Text(
          'Coleur',
          style: titlestyle,
        ),
        const SizedBox(
          height: 8,
        ),
        Wrap(
          children: List.generate(
              4,
              (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _SelectedColor = index;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: CircleAvatar(
                        child: _SelectedColor == index
                            ? const Icon(
                                Icons.done,
                                size: 16,
                                color: Colors.white,
                              )
                            : null,
                        backgroundColor: index == 0
                            ? Colors.grey[200]
                            : index == 1
                                ? kPrimaryLightColor
                                : index == 2
                                    ? Colors.pink[200]
                                    : Colors.deepPurple[200],
                        radius: 14,
                      ),
                    ),
                  )),
        )
      ],
    );
  }
}
