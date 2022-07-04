import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_home_12/model/Chambre.dart';

import '../../controllers/Chmabre_controller.dart';
import '../../services/Authentification.dart';
import '../../utils/theme.dart';
import '../../widgets/buttons.dart';
import '../../widgets/input_field.dart';

class add_new_chambre extends StatefulWidget {
  add_new_chambre({Key? key}) : super(key: key);

  @override
  State<add_new_chambre> createState() => _add_new_chambreState();
}

class _add_new_chambreState extends State<add_new_chambre> {
  late ChambreController _List = ChambreController();
  List<String> ChambreList = [
    'studio',
    'Salle de bain',
    'Cuisine',
    'Sallon',
    'Chambre',
    'Salle de lavage'
  ];
  String _SelectedChambre = 'None';
  late final String Id;
  @override
  void initState() {
    Id = user_info().get_user_id().toString();
    print('id : $Id');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.backgroundColor,
        appBar: _Appbar(),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
              child: Column(children: <Widget>[
            Text('Ajouté Chambre ', style: headingstyle),
            InputField(
              title: 'Liste des Chambre',
              hint: _SelectedChambre,
              widget: Row(children: [
                DropdownButton(
                  items: ChambreList.map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            '$value',
                            style: subtitlestyle,
                          ))).toList(),
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
                  onChanged: (String? newval) {
                    setState(() {
                      _SelectedChambre = newval!;
                    });
                  },
                ),
                const SizedBox(
                  width: 6,
                ),
              ]),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(
                    label: 'Creé Chambre',
                    onTap: () {
                      if (_SelectedChambre != 'None') {
                        _List.addChambre(
                            Chambre:
                                chambre(id_user: Id, title: _SelectedChambre));
                        Get.back();
                      }
                    })
              ],
            )
          ])),
        ),
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
}
