import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:smart_home_12/model/scenario.dart';
import 'package:smart_home_12/services/ampio_smarthome_API.dart';

import '../../controllers/Scénario_controller.dart';
import '../../utils/theme.dart';

class ScenarioButton extends StatefulWidget {
  const ScenarioButton(this.Position, this.scene, {Key? key}) : super(key: key);
  final int Position;
  final Scenario scene;
  @override
  State<ScenarioButton> createState() => ScenarioButtonState();
}

class ScenarioButtonState extends State<ScenarioButton> {
  ScenarioController _scenarioController = ScenarioController();
  late Scenario _scene;
  late int index;
  bool start_scene = true;
  bool stop_scene = true;
  bool delete_scene = true;
  Color start_icon_color = Colors.green;
  Color stop_icon_color = Colors.green;
  Color delete_icon_color = Colors.red;
  @override
  void initState() {
    _scene = widget.scene;
    index = widget.Position;
    print(' id scene : ${_scene.id_scenario}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 1150),
      child: SlideAnimation(
        horizontalOffset: 300,
        child: FadeInAnimation(
          child: Column(
            children: [
              Container(
                  height: 155,
                  width: MediaQuery.of(context).size.width * 0.95,
                  margin: EdgeInsets.only(
                    left: 8,
                    right: 8,
                    top: 20,
                  ),
                  padding: EdgeInsets.only(bottom: 8, top: 8),
                  decoration: BoxDecoration(
                    color: _getBGClr(_scene.color),
                    border: Border.all(width: 3, color: Colors.black),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(children: [
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  _scene.title,
                                  style: headingstyle,
                                )
                              ],
                            ),
                          ),
                          Divider(color: Colors.black),
                          Container(
                            margin: EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          width: 2, color: Colors.black)),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.play_arrow_sharp,
                                      color: start_icon_color,
                                    ),
                                    onPressed: () {
                                      print('Icon Color Changed');
                                      print(start_scene);
                                      start_scene = !start_scene;
                                      if (start_scene == false) {
                                        setState(() {
                                          _start_scenario(_scene.title);

                                          // Get.snackbar('Modifications',
                                          //     'Scenario :"  ${_scene.title}" en cours ',
                                          //     snackPosition: SnackPosition.TOP,
                                          //     backgroundColor: Get.isDarkMode
                                          //         ? Colors.black
                                          //         : Colors.white,
                                          //     colorText: Colors.greenAccent,
                                          //     icon: const Icon(Icons.done,
                                          //         color: Colors.greenAccent));
                                          start_icon_color = Colors.red;
                                        });
                                      }
                                      if (start_scene == true) {
                                        setState(() {
                                          // Get.snackbar('Modifications',
                                          //     'Scenario :"  ${_scene.title}" en cours ',
                                          //     snackPosition: SnackPosition.TOP,
                                          //     backgroundColor: Get.isDarkMode
                                          //         ? Colors.black
                                          //         : Colors.white,
                                          //     colorText: Colors.greenAccent,
                                          //     icon: const Icon(Icons.done,
                                          //         color: Colors.greenAccent));
                                          start_icon_color = Colors.green;
                                        });
                                        _start_scenario(_scene.title);
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          width: 2, color: Colors.black)),
                                  child: IconButton(
                                      icon: Icon(Icons.delete,
                                          color: delete_icon_color),
                                      onPressed: () {
                                        _scenarioController.deleteScenario(
                                            scenario_id: _scene.id_scenario!);

                                        print('Delete Scene');
                                        // Get.snackbar('Modifications',
                                        //     'Scenario  Supprimer:"  ${_scene.title}"',
                                        //     snackPosition: SnackPosition.TOP,
                                        //     backgroundColor: Get.isDarkMode
                                        //         ? Colors.black
                                        //         : Colors.white,
                                        //     colorText: Colors.redAccent,
                                        //     icon: const Icon(Icons.done,
                                        //         color: Colors.redAccent));
                                      }),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    VerticalDivider(
                      color: Colors.black,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          'SCENARIO',
                          style: titlestyle,
                        ),
                      ),
                    )
                  ])),
            ],
          ),
        ),
      ),
    );
  }

  _getBGClr(int? color) {
    switch (color) {
      case 0:
        {
          return Colors.grey[200];
        }
      case 1:
        {
          return kPrimaryLightColor;
        }
      case 2:
        {
          return Colors.pink[200];
        }
      case 3:
        {
          return Colors.deepPurple[200];
        }
      default:
        {
          return bluishClr;
        }
    }
  }

  void _start_scenario(String scenario_name) async {
    String type = '';
    String id;
    switch (scenario_name) {
      case 'Simulation de precense':
        {
          ampio_api.Simulation_de_precense();
          break;
        }
      case 'On-All':
        {
          ampio_api.OnAll();
          break;
        }
      case 'Of-All':
        {
          ampio_api.OffAll();
          break;
        }
      case 'On_All_Light':
        {
          ampio_api.onAll_light();
          break;
        }
      case 'Of_All_Light':
        {
          ampio_api.offAll_light();
          break;
        }
      case 'open_All_rollers_at_50':
        {
          ampio_api.open_All_rollers_at_50();
          break;
        }
      case 'open_All_rollers':
        {
          ampio_api.open_All_rollers();
          break;
        }
      case 'close_All_rollers':
        {
          ampio_api.close_All_rollers();
          break;
        }
      default:
        {
          break;
        }
    }
  }
}
