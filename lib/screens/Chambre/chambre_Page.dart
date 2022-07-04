import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:smart_home_12/controllers/Chmabre_controller.dart';

import 'package:smart_home_12/model/Chambre.dart';
import 'package:smart_home_12/screens/Chambre/AddChambre_Page.dart';
import 'package:smart_home_12/screens/Chambre/ChambreButton.dart';
import 'package:smart_home_12/services/Authentification.dart';
import 'package:smart_home_12/utils/AppAssets.dart';
import 'package:smart_home_12/utils/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Chambre_Page extends StatefulWidget {
  Chambre_Page({Key? key}) : super(key: key);

  @override
  State<Chambre_Page> createState() => _Chambre_PageState();
}

class _Chambre_PageState extends State<Chambre_Page> {
  late ChambreController _List = ChambreController();
  late final String _Id;

  @override
  void initState() {
    _Id = user_info().get_user_id().toString();
    _List.getChambre(id_user: _Id);
    // _List.addChambre(Chambre: chambre(id_user: _Id,title: 'Custom Name'));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight) / 3;
    final double itemWidth = size.width / 2;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_box_outlined),
          onPressed: () async {
            await Get.to(add_new_chambre());
            _List.getChambre(id_user: _Id);
          },
        ),
        body: Obx(() {
          if (_List.chambre_list.isEmpty) {
            return _Empty_list_widget();
          } else {
            return Container(
              margin: EdgeInsets.all(15),
              child: RefreshIndicator(
                color: kPrimaryColor,
                onRefresh: _onRefrech,
                child: GridView.builder(
                    itemCount: _List.chambre_list.length,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: (itemWidth / itemHeight),
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20),
                    itemBuilder: (context, int index) {
                      chambre _chambre = _List.chambre_list[index];
                      return ChambreButton(_chambre, index);
                    }),
              ),
            );
          }
        }));
  }

  _Empty_list_widget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(seconds: 2),
              curve: Curves.fastOutSlowIn,
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        AppAssets.no_room,
                        color: Get.isDarkMode ? Colors.white : kPrimaryColor,
                        height: 200,
                        semanticsLabel: 'Task',
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'Vous n avez pas de chambre ! \n Clicke sur le boutton pour Ajoute de nouveau chambre ',
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

  Future<void> _onRefrech() async {
    _List.getChambre(id_user: _Id);
  }
}
