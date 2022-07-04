import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_home_12/screens/auth/Login_Page.dart';
import 'package:smart_home_12/services/Authentification.dart';
import 'package:smart_home_12/services/home_settings.dart';
import 'package:smart_home_12/services/theme_services.dart';
import 'package:smart_home_12/utils/theme.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  TextEditingController newCitynameController = TextEditingController();
  @override
  void initState() {
    _radiovalue = ThemeServices().getTheme() ? 2 : 1;
    _remembermeSheck();
    newCitynameController.text = CityInfo().load_location_fromBox();
    super.initState();
  }

  bool _rememberMe = false;
  late int _radiovalue;
  TextStyle _titlestyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  TextStyle _subtiltestyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(8),
          child: ListView(children: [
            ExpansionTile(
                collapsedTextColor:
                    Get.isDarkMode ? Colors.white : Colors.black,
                collapsedIconColor:
                    Get.isDarkMode ? Colors.white : Colors.black,
                textColor: Get.isDarkMode
                    ? Colors.grey
                    : Theme.of(context).primaryColor,
                iconColor: Get.isDarkMode
                    ? Colors.grey
                    : Theme.of(context).primaryColor,
                leading: Icon(Icons.miscellaneous_services_outlined),
                title: Text('Personalisation', style: _titlestyle),
                children: [
                  ExpansionTile(
                    collapsedTextColor:
                        Get.isDarkMode ? Colors.white : Colors.black,
                    collapsedIconColor:
                        Get.isDarkMode ? Colors.white : Colors.black,
                    textColor: Get.isDarkMode
                        ? Colors.brown
                        : Theme.of(context).primaryColor,
                    iconColor: Get.isDarkMode
                        ? Colors.brown
                        : Theme.of(context).primaryColor,
                    leading: Icon(Icons.change_circle_outlined),
                    title: Text('Themes', style: _subtiltestyle),
                    children: [
                      Divider(color: Colors.grey),
                      ListTile(
                        trailing: Radio(
                          activeColor: Colors.amber,
                          value: 1,
                          groupValue: _radiovalue,
                          onChanged: (_value) {
                            setState(() {
                              ThemeServices().select_savetheme(ThemeMode.light);
                              _radiovalue = _value as int;
                            });
                          },
                        ),
                        leading: Icon(
                          Icons.light_mode,
                          color: Colors.amber,
                        ),
                        title: Text(
                          'Light Theme',
                          style: bodystyle,
                        ),
                        onTap: () {
                          if (_radiovalue == 2) {
                            setState(() {
                              _radiovalue = 1;
                              ThemeServices().select_savetheme(ThemeMode.light);
                            });
                          }
                        },
                      ),
                      Divider(color: Colors.grey),
                      ListTile(
                        leading: Icon(
                          Icons.dark_mode,
                          color: Colors.black87,
                        ),
                        trailing: Radio(
                          activeColor: Colors.black,
                          value: 2,
                          groupValue: _radiovalue,
                          onChanged: (_value) {
                            setState(() {
                              _radiovalue = _value as int;
                              ThemeServices().select_savetheme(ThemeMode.dark);
                            });
                          },
                        ),
                        title: Text(
                          'Mode nuit',
                          style: bodystyle,
                        ),
                        onTap: () {
                          if (_radiovalue == 1) {
                            setState(() {
                              _radiovalue = 2;
                              ThemeServices().select_savetheme(ThemeMode.dark);
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text('Tableau de Bord', style: _subtiltestyle),
                    collapsedTextColor:
                        Get.isDarkMode ? Colors.white : Colors.black,
                    collapsedIconColor:
                        Get.isDarkMode ? Colors.white : Colors.black,
                    textColor: Get.isDarkMode
                        ? Colors.brown
                        : Theme.of(context).primaryColor,
                    iconColor: Get.isDarkMode
                        ? Colors.brown
                        : Theme.of(context).primaryColor,
                    leading: Icon(Icons.home),
                    children: [
                      Divider(color: Colors.grey),
                      ListTile(
                        title: Text('ville', style: bodystyle),
                        subtitle: Text(
                          'Changed de ville ?',
                        ),
                        leading: Icon(Icons.location_city_outlined),
                        trailing: Icon(
                          Icons.arrow_right,
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                        ),
                        onTap: () {
                          _CityDialogue();
                        },
                      )
                    ],
                  )
                ]),
            Divider(color: Colors.black),
            ExpansionTile(
              collapsedTextColor: Get.isDarkMode ? Colors.white : Colors.black,
              collapsedIconColor: Get.isDarkMode ? Colors.white : Colors.black,
              textColor:
                  Get.isDarkMode ? Colors.grey : Theme.of(context).primaryColor,
              iconColor:
                  Get.isDarkMode ? Colors.grey : Theme.of(context).primaryColor,
              leading: Icon(Icons.account_circle_outlined),
              title: Text('Compte', style: _titlestyle),
              children: [
                Divider(color: Colors.black),
                ListTile(
                  leading: Icon(Icons.info_outline_rounded),
                  title: Text(
                    'se souvenir de moi ?',
                    style: _subtiltestyle,
                  ),
                  trailing: Checkbox(
                    activeColor: Colors.transparent,
                    checkColor: Get.isDarkMode
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColor,
                    onChanged: (_value) {
                      setState(() {
                        _rememberMe = _value as bool;
                      });
                      if (_value == true) {
                        signup().updateaccess(_value!);
                      } else {
                        signup().updateaccess(_value!);
                      }
                    },
                    value: _rememberMe,
                  ),
                ),
                Divider(color: Colors.black),
                ListTile(
                    title: Text('Se déconnecter ou change de profil',
                        style: _subtiltestyle),
                    leading: Icon(Icons.exit_to_app_outlined),
                    trailing: Icon(
                      Icons.arrow_right,
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                    ),
                    onTap: () {
                      signup().updateaccess(false);
                      Navigator.of(context)
                          .pushReplacement(MaterialPageRoute(builder: (_) {
                        return Login_Page();
                      }));
                    }
                    // signup().updateaccess(false);
                    )
              ],
            )
          ]),
        ),
      ),
    ));
  }

  void _remembermeSheck() async {
    _rememberMe = signup().getaccess();
    if (_rememberMe == false) {
      _rememberMe = false;
    } else {
      _rememberMe = true;
    }
  }

  _CityDialogue() {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        title: Text('Modifications'),
        content: Container(
          height: 100,
          child: Column(
            //shrinkWrap: true,
            children: [
              Divider(
                  color: Get.isDarkMode
                      ? Colors.white
                      : Theme.of(context).primaryColor),
              TextFormField(
                controller: newCitynameController,
                decoration: InputDecoration(
                  hintText: 'nom de la ville',
                  hintStyle: subtitlestyle,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Get.isDarkMode
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                          width: 1)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: context.theme.backgroundColor, width: 0)),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'annulé',
                style: TextStyle(color: Colors.redAccent),
              )),
          TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () {
                if (newCitynameController.text.isEmpty == false) {
                  CityInfo()
                      .save_location_change_to_box(newCitynameController.text);
                  Get.snackbar('Modifications', 'Changement effectué ',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor:
                          Get.isDarkMode ? Colors.black : Colors.white,
                      colorText: Colors.greenAccent,
                      icon: const Icon(Icons.done, color: Colors.greenAccent));

                  Navigator.of(context).pop(newCitynameController.text);
                } else {
                  Navigator.pop(context);
                }
              },
              child: Text(
                'Validé',
                style: TextStyle(color: Colors.blueAccent),
              ))
        ],
      ),
    );
  }
}
