import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_home_12/controllers/module_controller.dart';
import 'package:smart_home_12/services/ampio_smarthome_API.dart';
import '../../utils/theme.dart';
import '../../widgets/buttons.dart';

class Add_module_Page extends StatefulWidget {
  final int id_chambre;
  Add_module_Page(this.id_chambre, {Key? key}) : super(key: key);

  @override
  State<Add_module_Page> createState() => _Add_module_PageState();
}

class _Add_module_PageState extends State<Add_module_Page> {
  late final int _id_chambre;
  final bool _erreur_id = false;
  final bool _erreur_device_name = false;
  TextEditingController _id_controller = TextEditingController();
  TextEditingController _device_name_controller = TextEditingController();
  TextEditingController _device_real_name_controller = TextEditingController();
  String _type = '';
  late int _id;
  List _Devices_List = [];
  @override
  void initState() {
    _id_chambre = widget.id_chambre;
    inidevice();
    super.initState();
  }

  inidevice() async {
    print('ime here ');
    _Devices_List = await ampio_api.getdevicesList();
    print('i got this $_Devices_List');
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
                Text('Ajouté Module ', style: headingstyle),
                SizedBox(height: 20),
                TextFormField(
                  style: subtitlestyle.copyWith(color: Colors.black),
                  enabled: true,
                  autofocus: false,
                  obscureText: false,
                  cursorColor: Colors.black87,
                  controller: _id_controller,
                  keyboardType: TextInputType.number,
                  onChanged: (Text) {
                    bool found = false;
                    print(_id_controller.text);
                    print('start');
                    _Devices_List.forEach((element) {
                      if (element['id'].toString() == Text) {
                        print('found');
                        setState(() {
                          _device_real_name_controller.text =
                              element['opis_menu'];
                        });
                        print(element['opis_rozwiniety']);
                        _type = element['typ_komponentu'];
                        _id = element['id'];
                        found = true;
                      }
                    });
                    if (found == false) {
                      setState(() {
                        _device_real_name_controller.text = 'not found ';
                      });
                    }
                  },
                  maxLength: 4,
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.vpn_key_outlined,
                      color: Get.isDarkMode ? Colors.white : kPrimaryColor,
                    ),
                    errorStyle: subtitlestyle.copyWith(color: Colors.redAccent),
                    label: Text('id',
                        style: titlestyle.copyWith(
                            color:
                                Get.isDarkMode ? Colors.white : kPrimaryColor)),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    hintText: 'Example : 210 ',
                    labelStyle: subtitlestyle,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Get.isDarkMode ? Colors.white : kPrimaryColor,
                          width: 1,
                        )),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2.0,
                          color: Get.isDarkMode ? Colors.white : kPrimaryColor),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  style: subtitlestyle.copyWith(color: Colors.black),
                  enabled: true,
                  autofocus: false,
                  obscureText: false,
                  cursorColor: Colors.black87,
                  controller: _device_name_controller,
                  keyboardType: TextInputType.name,
                  maxLength: 20,
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.text_fields_outlined,
                      color: Get.isDarkMode ? Colors.white : kPrimaryColor,
                    ),
                    errorStyle: subtitlestyle.copyWith(color: Colors.redAccent),
                    label: Text('name',
                        style: titlestyle.copyWith(
                            color:
                                Get.isDarkMode ? Colors.white : kPrimaryColor)),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    hintText: 'Example : lampe sallon 1',
                    labelStyle: subtitlestyle,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Get.isDarkMode ? Colors.white : kPrimaryColor,
                          width: 1,
                        )),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2.0,
                          color: Get.isDarkMode ? Colors.white : kPrimaryColor),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  readOnly: true,
                  style: subtitlestyle.copyWith(color: Colors.black),
                  enabled: false,
                  obscureText: false,
                  textAlign: TextAlign.center,
                  cursorColor: Colors.black87,
                  controller: _device_real_name_controller,
                  keyboardType: TextInputType.name,
                  onTap: () {},
                  decoration: InputDecoration(
                    errorStyle: subtitlestyle.copyWith(color: Colors.redAccent),
                    label: Text('nom du module selcionné',
                        style: titlestyle.copyWith(
                            color:
                                Get.isDarkMode ? Colors.white : kPrimaryColor)),
                    labelStyle: subtitlestyle,
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Get.isDarkMode ? Colors.white : kPrimaryColor,
                          width: 1.0),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MyButton(
                        label: 'Ajouté le Module',
                        onTap: () {
                          moduleController().addmodule(
                              id: _id,
                              title: _device_name_controller.text,
                              type: _type,
                              id_chambre: _id_chambre);
                          Get.back();
                        })
                  ],
                ),
              ]),
            ),
          )),
    );
  }

  AppBar _Appbar() => AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios,
              size: 24, color: Get.isDarkMode ? Colors.white : kPrimaryColor),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
      );

  _temp() {}

  _search_this_device() {
    print('start');
    _Devices_List.forEach((element) {
      if (element['id'] == _id_controller) {
        print('found');
        setState(() {
          _device_real_name_controller.text = element['opis_rozwiniety'];
          _type = element['typ_komponentu'];
          _id = element['id'];
        });
      } else {
        setState(() {
          _device_real_name_controller.text = 'Not found yet ';
        });
      }
    });
  }
}
