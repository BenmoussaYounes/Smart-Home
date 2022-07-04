import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smart_home_12/controllers/module_controller.dart';
import 'package:smart_home_12/model/module.dart';
import 'package:smart_home_12/screens/module/add_module_page.dart';
import 'package:smart_home_12/screens/module/moduleButtons.dart';

import 'package:smart_home_12/utils/AppAssets.dart';
import '../../utils/theme.dart';

class Module_Page extends StatefulWidget {
  final String title;
  final int id;
  const Module_Page(this.id, this.title, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _moduleState();
}

class _moduleState extends State<Module_Page> {
  moduleController _List = moduleController();
  late final String title;
  late final int _id_chambre;
  @override
  void initState() {
    title = widget.title;
    _id_chambre = widget.id;
    print('id chambre : $_id_chambre');
    // _List.addmodule(
    //     id: 6, title: 'Lampe test', type: 'led', id_chambre: _id_chambre);
    // _List.addmodule(
    //     id: 16,
    //     title: 'Vollet cuisine',
    //     type: 'roller',
    //     id_chambre: _id_chambre);
    // _List.addmodule(
    //     id: 15, title: 'lampe sallon', type: 'led', id_chambre: _id_chambre);
    // _List.addmodule(
    //     id: 5, title: 'lampe Cuisine', type: 'rgb', id_chambre: _id_chambre);
    _List.getModulesList(id_chambre: _id_chambre);
    super.initState();
  }

  AppBar _Appbar() => AppBar(
        title: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            "Binevenu - $title",
            textAlign: TextAlign.start,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Get.isDarkMode ? kPrimaryLightColor : kPrimaryColor,
            size: 24,
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
      );
  @override
  Widget build(BuildContext context) {
    // double heightScreen = (MediaQuery.of(context).size.height -
    //     MediaQuery.of(context).padding.top -
    //     _Appbar.preferredSize.height);
    return Scaffold(
        appBar: _Appbar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Get.to(Add_module_Page(_id_chambre));
            _List.getModulesList(id_chambre: _id_chambre);
          },
          child: Icon(Icons.add_circle_outline_outlined),
        ),
        body: SafeArea(
          child: Obx(() {
            if (_List.deviceLists.isEmpty == false) {
              return RefreshIndicator(
                onRefresh: _onRefrech,
                child: ListView.builder(
                    itemCount: _List.deviceLists.length,
                    itemBuilder: (BuildContext context, int index) {
                      module device = _List.deviceLists[index];
                      return moduleButton(device, index);
                    }),
              );
            } else {
              return _emptylistWidget();
            }
          }),
        ));
  }

  Widget _emptylistWidget() {
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
                        AppAssets.module,
                        color: Get.isDarkMode ? Colors.white : kPrimaryColor,
                        height: 200,
                        semanticsLabel: 'module',
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          'Vous n avez pas de module ! \n Clicke sur le boutton pour Ajoute de nouveau module a votre chambre ',
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

  Future _onRefrech() async {
    _List.getModulesList(id_chambre: _id_chambre);
  }
}
