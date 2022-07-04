import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_12/controllers/module_controller.dart';
import 'package:smart_home_12/services/Authentification.dart';
import 'package:smart_home_12/services/ampio_smarthome_API.dart';
import 'package:smart_home_12/utils/theme.dart';
import 'package:smart_home_12/widgets/buttons.dart';
import '../utils/AppAssets.dart';
import '../utils/AppSpaces.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

// //**AMPIO-API
// void setRGBColorAPI({required Color coleur}) {
//   //setColors param 1: RED, param2: GREEN, param3: BLUE, param4: WHITE
//   // (all range from 0 to 255)
//   // (ex: admin:admin@192.168.1.1:8060/api/set/1/setColors/R0/G0/B0/W0)
//   int R = coleur.red;
//   int G = coleur.green;
//   int B = coleur.blue;
//   int W = coleur.alpha;
//   Map<String, String> header = {
//     'accept': 'application/json',
//     'authorization': 'Basic YWRtaW46YW1waW8=',
//   };
//   final url =
//       'http://admin:admin@192.168.1.1:8060/api/set/1/setColors/$R/$G/$B/$W';
//   Http.get(Uri.parse(url), headers: header);
// }
//
// Future getStateOfDevice(String id) async {
//   Map<String, String> header = {
//     'accept': 'application/json',
//     'authorization': 'Basic YWRtaW46YW1waW8='
//   };
//   //final String url = 'http://admin:ampio@192.168.1.210:8060/api/json/device/$id/state';
//   const String url = 'http://demo.ampio.pl:8060/api/json/device/id_dev/state';
//   // const urlOn = 'http://admin:ampio@192.168.1.210:8060/api/set/200/turnOnn';
//   var object = await Http.get(Uri.parse(url), headers: header);
//   if (object.statusCode == 200) {
//     Map res = jsonDecode(object.body);
//     return res['Results']['state'];
//   } else {
//     throw Exception('Connexion Error ! ');
//   }
// }
//
// Future FetchJson() async {
//   final url = 'http://demo.ampio.pl:8060/api/xml/devices';
//   //  final url = 'http://admin:ampio@192.168.1.210:8060/api/200/state';
//   Map<String, String> Header = {
//     'accept': 'application/json',
//     'authorization': 'Basic YWRtaW46YW1waW8='
//   };
//   var res = await Http.get(Uri.parse(url), headers: Header);
//   if (res.statusCode == 200) {
//     var obj = json.decode(res.body);
//     return obj;
//   } else {
//     throw Exception("Json Error !");
//   }
// }
//
// Future<dynamic> LightSet(String State) async {
//   //turnOff
//   //turnOn
//   var header = {
//     'accept': 'application/json',
//     'authorization': 'Basic YWRtaW46YW1waW8=',
//   };
//   final url = 'http://admin:ampio@192.168.1.210:8060/api/set/200/$State';
//   var res = await Http.get(Uri.parse(url), headers: header);
//   var obj = json.decode(res.body);
//   if (res.statusCode == 200) {
//     return obj['Response'];
//   } else {
//     throw Exception('Error');
//   }
// }
//
// Future<dynamic> RollerSet(String State) async {
//   //open
//   //stop
//   //close
//   var header = {
//     'accept': 'application/json',
//     'authorization': 'Basic YWRtaW46YW1waW8=',
//   };
//   final url = 'http://admin:ampio@192.168.1.210:8060/api/set/111/$State';
//   //final url2 = 'http://admin:ampio@192.168.1.210:8060/api/set/111/stop';
//   var res = await Http.get(Uri.parse(url), headers: header);
//   var obj = json.decode(res.body);
//   if (res.statusCode == 200) {
//     return obj['Response'];
//   } else {
//     throw Exception('Error');
//   }
// }

/**-------------------------- */

// RGB DEVICE------
class RGBlightbutton extends StatefulWidget {
  int id;
  String title;
  int index;
  RGBlightbutton(this.id, this.title, this.index, {Key? key}) : super(key: key);

  @override
  State<RGBlightbutton> createState() => _RGBlightbuttonState();
}

class _RGBlightbuttonState extends State<RGBlightbutton> {
  bool isOn = false; //deviceState(getStateOfDevice('118'));
  Color currentColor = Color.fromRGBO(0, 0, 0, 99); //Colors.redAccent;
  Color onColor = Color(0xFF81B1FA);
  late int _id;
  late String _title;
  late int _index;
  @override
  void initState() {
    _id = widget.id;
    _title = widget.title;
    _index = widget.index;
    super.initState();
  }

// RGB BUTTON
  Widget RGBbutton(BuildContext context) {
    void changeColor(Color color) => setState(() {
          currentColor = color;
          //setRGBColorAPI(coleur: color);
          //admin:admin@192.168.1.1:8060/api/set/1/setColors/0/0/0/0)
        });

    return ElevatedButton(
      style: ButtonStyle(
        // foregroundColor: MaterialStateProperty.all(currentColor),
        backgroundColor: MaterialStateProperty.all(currentColor),
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                titlePadding: const EdgeInsets.all(0.0),
                contentPadding: const EdgeInsets.all(0.0),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      SlidePicker(
                        labelTypes: const [],
                        pickerColor: currentColor,
                        onColorChanged: changeColor,
                        enableAlpha: false,
                        displayThumbColor: true,
                      ),
                      OutlinedButton(
                          onPressed: () {
                            //  setRGBColorAPI(coleur: currentColor);
                            isOn = true;
                            onColor = currentColor;
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Choisi une couleur ',
                            style: Theme.of(context).textTheme.headline4,
                          )),
                      AppSpaces.vertical15
                    ],
                  ),
                ));
          },
        );
      },
      child: Text(
        'Color Picker',
        style: TextStyle(
            color: useWhiteForeground(currentColor)
                ? const Color(0xffffffff)
                : const Color(0xff000000),
            fontWeight: FontWeight.bold,
            fontSize: 15),
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return AnimationConfiguration.staggeredList(
      position: _index,
      duration: const Duration(milliseconds: 1150),
      child: SlideAnimation(
        child: FadeInAnimation(
          child: Container(
            height: 170,
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade100,
                border: Border.all(width: 2)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          _title,
                          style: Theme.of(context).textTheme.headline2,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () => setState(() {
                            isOn = !isOn;
                            if (isOn == true) {
                              currentColor = Color.fromRGBO(0, 0, 99, 99);
                              // setRGBColorAPI(coleur:Color.fromRGBO(0, 0, 99,99))
                            } else {
                              // setRGBColorAPI(coleur: Color.fromRGBO(0, 0, 0, 99));
                              currentColor = Color.fromRGBO(0, 0, 0, 99);
                            }
                          }),
                          child: Image.asset(
                            AppAssets.bulb,
                            color: currentColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                RGBbutton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*** LED - BUTTON */
class LEDlightButton extends StatefulWidget {
  int id;
  String title;
  int index;
  LEDlightButton(this.id, this.title, this.index, {Key? key}) : super(key: key);

  @override
  _LEDlightButtonState createState() => _LEDlightButtonState();
}

class _LEDlightButtonState extends State<LEDlightButton> {
  moduleController _controller = moduleController();
  Color LightColor = Colors.redAccent;
  late int _id_led;
  var isOn;
  var ledValue;
  late String _title;
  late int _index;
  @override
  void initState() {
    _title = widget.title;
    _id_led = widget.id;
    _index = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _showFontSizePickerDialog() async {
      // <-- note the async keyword here

      // this will contain the result from Navigator.pop(context, result)
      final selectedFontSize = await showDialog<double>(
        context: context,
        builder: (context) => FontSizePickerDialog(
          SliderintValue: double.parse(ledValue),
          activeSliderColor: LightColor,
          id: _id_led,
        ),
      );
      // execution of this code continues when the dialog was closed (popped)
      // note that the result can also be null, so check it
      // (back button or pressed outside of the dialog)
      if (selectedFontSize != null) {
        setState(() {
          if (selectedFontSize == 0) {
            LightColor = Colors.redAccent;
          }
        });
      }
    }

    return AnimationConfiguration.staggeredList(
      position: _index,
      duration: const Duration(milliseconds: 1150),
      child: SlideAnimation(
        child: FadeInAnimation(
          child: GestureDetector(
            //  onLongPress: ,
            child: Container(
              margin: EdgeInsets.all(15),
              height: 170,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade100,
                  border: Border.all(width: 2)),
              child: FutureBuilder(
                  future: ampio_api.GetvalueOfDeviceLED(id: _id_led),
                  builder: (ctx, Snapshot) {
                    if (Snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      bool sheck = Snapshot.hasError;
                      print(sheck);
                      print('hello ');
                      print('test 1 : ${Snapshot.data}');
                      ledValue = Snapshot.data;
                      if (ledValue == '0') {
                        LightColor = Colors.redAccent;
                        isOn = false;
                      } else {
                        isOn = true;
                        LightColor = Colors.orangeAccent;
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(_title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2),
                                    (Snapshot.data != false &&
                                            Snapshot.data != true)
                                        ? (ledValue == null)
                                            ? Text('')
                                            : Text('${ledValue}%',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2)
                                        : Text('')
                                  ],
                                ),
                                GestureDetector(
                                  onLongPress: () async {
                                    bool sheck = await yes_no_dialog();

                                    if (sheck == true) {
                                      _delete_module(id: _id_led);
                                    } else {}
                                  },
                                  onTap: (Snapshot.hasData == true &&
                                          Snapshot.hasError == false)
                                      ? () async {
                                          print(
                                              'isOn value after here  :$isOn');
                                          isOn = !isOn;
                                          print('isOn After Changed : $isOn');

                                          if (isOn == true) {
                                            await ampio_api.SetledLightvalue(
                                                value: 230, Id: _id_led);
                                            setState(() {
                                              LightColor = Colors.orangeAccent;
                                              showToast('Lampe Allumé ',
                                                  context: context,
                                                  animation:
                                                      StyledToastAnimation
                                                          .scale,
                                                  reverseAnimation:
                                                      StyledToastAnimation.fade,
                                                  position: StyledToastPosition
                                                      .center,
                                                  animDuration:
                                                      Duration(seconds: 1),
                                                  duration:
                                                      Duration(seconds: 2),
                                                  curve: Curves.elasticOut,
                                                  reverseCurve: Curves.linear,
                                                  backgroundColor:
                                                      Colors.greenAccent);
                                            });
                                          } else {
                                            print(
                                                'im here 2 isOn value :$isOn');
                                            await ampio_api.SetledLightvalue(
                                                value: 0, Id: _id_led);
                                            setState(() {
                                              LightColor = Colors.redAccent;

                                              showToast('lampe éteinte ',
                                                  context: context,
                                                  animation:
                                                      StyledToastAnimation
                                                          .scale,
                                                  reverseAnimation:
                                                      StyledToastAnimation.fade,
                                                  position: StyledToastPosition
                                                      .center,
                                                  animDuration:
                                                      Duration(seconds: 1),
                                                  duration:
                                                      Duration(seconds: 2),
                                                  curve: Curves.elasticOut,
                                                  reverseCurve: Curves.linear,
                                                  backgroundColor:
                                                      Colors.redAccent);
                                            });
                                          }
                                        }
                                      : () {
                                          setState(() {
                                            ///Set both animation and reverse animation,
                                            ///combination different animation and reverse animation to achieve amazing effect.
                                            showToast(
                                              'Vous dever vous Connecter au réseau de la maison Ksbahnet ',
                                              context: context,
                                              animation:
                                                  StyledToastAnimation.scale,
                                              reverseAnimation:
                                                  StyledToastAnimation.fade,
                                              position:
                                                  StyledToastPosition.center,
                                              animDuration:
                                                  Duration(seconds: 1),
                                              duration: Duration(seconds: 4),
                                              curve: Curves.elasticOut,
                                              reverseCurve: Curves.linear,
                                            );
                                          });
                                        },
                                  // if (isOn == true) {
                                  // Provider.of<MyDeviceprovider>(context, listen: false)
                                  //     .sheckLedvalue();
                                  //  LightSet('turnOn');
                                  //  print(getStateOfDevice(id: ''));
                                  //  showToast(
                                  //           'Vous dever vous Connecter au réseau de la maison Ksbahnet ${Snapshot.error}',
                                  //           context: context,
                                  //           animation: StyledToastAnimation.scale,
                                  //           reverseAnimation: StyledToastAnimation.fade,
                                  //           position: StyledToastPosition.center,
                                  //           animDuration: Duration(seconds: 1),
                                  //           duration: Duration(seconds: 4),
                                  //           curve: Curves.elasticOut,
                                  //           reverseCurve: Curves.linear,
                                  //         );
                                  //   LightColor = Color(0xFF81B1FA);
                                  //} else {
                                  //  LightSet('turnOff');
                                  // LightColor = Colors.redAccent;
                                  // print(Snapshot.data);
                                  // }
                                  child: Snapshot.connectionState ==
                                          ConnectionState.done
                                      ? Image.asset(
                                          AppAssets.led,
                                          color: LightColor,
                                        )
                                      : CircularProgressIndicator(),
                                ),
                              ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              LightColor)),
                                  onPressed: () => _showFontSizePickerDialog(),
                                  child: Text(
                                    'light intensity',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  )),
                            ],
                          )
                        ],
                      );
                    }
                  }),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> yes_no_dialog() {
    return showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('Modification', style: headingstyle),
            content: Container(
                child: Text('Shoutez vous vraiment suprimmer la $_title ?',
                    style: bodystyle)),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('Annulé',
                      style: titlestyle.copyWith(color: Colors.redAccent))),
              TextButton(
                child: Text(
                  'Validé',
                  style: titlestyle.copyWith(color: Colors.greenAccent),
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              )
            ],
          );
        });
  }

  _delete_module({required int id}) {
    _controller.deletemodule(id_module: _id_led);
    Get.snackbar(
        'Modification éffectue', 'Le module numéro $id est supprimer ');
  }
}

// ROLLER DEVICE ----------------
class Roller extends StatefulWidget {
  String title;
  int id;
  int index;
  Roller(this.id, this.title, this.index, {Key? key}) : super(key: key);

  @override
  _RollerState createState() => _RollerState();
}

class _RollerState extends State<Roller> {
  double _value = 0;
  bool isOn = false;
  Color RollerColor = Colors.redAccent;
  late String _title;
  late int _id;
  late int _index;
  moduleController _controller = moduleController();
  @override
  void initState() {
    _title = widget.title;
    _id = widget.id;
    _index = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: _index,
      duration: const Duration(milliseconds: 1150),
      child: SlideAnimation(
        child: FadeInAnimation(
          child: GestureDetector(
            child: Container(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade100,
                    border: Border.all(width: 2)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FutureBuilder(
                              future: ampio_api.GetStateOfDevice(id: _id),
                              builder: (ctx, Snapshot1) => GestureDetector(
                                    onTap: () => setState(() {
                                      //isOn=deviceState(Snapshot1.data);
                                      isOn = !isOn;
                                      if (isOn == true) {
                                        ampio_api.RollerSet('open', _id);
                                        RollerColor = Color(0xFF81B1FA);
                                      } else {
                                        ampio_api.RollerSet('close', _id);
                                        _value = 0;
                                        RollerColor = Colors.redAccent;
                                      }
                                    }),
                                    child: Image.asset(
                                      AppAssets.window,
                                      color: RollerColor,
                                    ),
                                  )),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                            fit: BoxFit.cover,
                            child: Text(
                                (isOn == true)
                                    ? 'Volets a : ${(_value).round()}'
                                    : ' Le Volet est Ferme ',
                                style: titlestyle.copyWith(
                                    color: Get.isDarkMode
                                        ? Colors.black
                                        : Colors.white)),
                          ),
                          Slider(
                              max: (isOn == false) ? 0 : 50,
                              min: 0,
                              divisions: 10,
                              value: _value,
                              label: 'Valeur',
                              activeColor: RollerColor,
                              onChanged: (val) => setState(() {
                                    _value = val;
                                    ampio_api.SetRollerPos(_value.round(), _id);
                                  })),
                        ],
                      ),
                    ])),
          ),
        ),
      ),
    );
  }

  _onlongpress({required int id}) {
    _controller.deletemodule(id_module: id);
    Get.snackbar('Modification', 'Le module numéro $id est supprimé',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.isDarkMode ? Colors.black : Colors.white,
        colorText: Colors.greenAccent,
        icon: const Icon(Icons.done, color: Colors.greenAccent));
  }
}

//**
class lightButton extends StatefulWidget {
  String title;
  int id;
  int index;
  lightButton(this.id, this.title, this.index, {Key? key}) : super(key: key);

  @override
  _lightButtonState createState() => _lightButtonState();
}

class _lightButtonState extends State<lightButton> {
  moduleController _controller = moduleController();
  late String _title;
  late int _id;
  late int _index;
  @override
  void initState() {
    _title = widget.title;
    _id = widget.id;
    _index = widget.index;
    // TODO: implement initState
    super.initState();
  }

  var isOn;
  Color lightColor = Colors.redAccent;
  Future<dynamic> yes_no_dialog() {
    return showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('Modification', style: headingstyle),
            content: Container(
                child: Text('Shoutez vous vraiment suprimmer la $_title ?',
                    style: bodystyle)),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('Annulé',
                      style: titlestyle.copyWith(color: Colors.redAccent))),
              TextButton(
                child: Text(
                  'Validé',
                  style: titlestyle.copyWith(color: Colors.greenAccent),
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              )
            ],
          );
        });
  }

  _delete_module({required int id}) {
    _controller.deletemodule(id_module: _id);
    Get.snackbar(
        'Modification éffectue', 'Le module numéro $id est supprimer ');
  }

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: _index,
      duration: const Duration(milliseconds: 1150),
      child: SlideAnimation(
        child: FadeInAnimation(
          child: Container(
            height: 170,
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade100,
                border: Border.all(width: 2)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_title, style: Theme.of(context).textTheme.headline2),
                FutureBuilder(
                  future: ampio_api.GetStateOfDevice(id: _id),
                  builder: (ctx, Snapshot) {
                    print('isOn value :$isOn');
                    if (isOn == null) {
                      if (Snapshot.hasData) {
                        isOn = Snapshot.data;
                        if (isOn == true) {
                          lightColor = Color(0xFF81B1FA);
                        } else {
                          lightColor = Colors.redAccent;
                        }
                        print('SnapshotData (isOn): $Snapshot.data');
                      }
                      if (Snapshot.connectionState == ConnectionState.done &&
                          Snapshot.hasError == true) {
                        isOn = false;
                        lightColor = Colors.redAccent;
                      }
                    }
                    return GestureDetector(
                        onLongPress: () async {
                          bool sheck = await yes_no_dialog();

                          if (sheck == true) {
                            _delete_module(id: _id);
                          } else {}
                        },
                        onTap: (Snapshot.hasData == true &&
                                Snapshot.hasError == false)
                            ? () {
                                isOn = !isOn;
                                print('isOn After Changed : $isOn');
                                if (isOn == true) {
                                  print('isOn==true Passed');
                                  ampio_api.LightSet(State: 'turnOn', Id: _id);
                                  setState(() {
                                    lightColor = Color(0xFF81B1FA);
                                    showToast('Lampe Allumé ',
                                        context: context,
                                        animation: StyledToastAnimation.scale,
                                        reverseAnimation:
                                            StyledToastAnimation.fade,
                                        position: StyledToastPosition.center,
                                        animDuration: Duration(seconds: 1),
                                        duration: Duration(seconds: 2),
                                        curve: Curves.elasticOut,
                                        reverseCurve: Curves.linear,
                                        backgroundColor: Colors.greenAccent);
                                  });
                                } else {
                                  print('isOn==false Passed');
                                  ampio_api.LightSet(State: 'turnOff', Id: _id);
                                  lightColor = Colors.redAccent;
                                  setState(() {
                                    showToast('lampe éteinte ',
                                        context: context,
                                        animation: StyledToastAnimation.scale,
                                        reverseAnimation:
                                            StyledToastAnimation.fade,
                                        position: StyledToastPosition.center,
                                        animDuration: Duration(seconds: 1),
                                        duration: Duration(seconds: 2),
                                        curve: Curves.elasticOut,
                                        reverseCurve: Curves.linear,
                                        backgroundColor: Colors.redAccent);
                                  });
                                }
                              }
                            : () {
                                setState(() {
                                  ///Set both animation and reverse animation,
                                  ///combination different animation and reverse animation to achieve amazing effect.
                                  showToast(
                                    'Vous dever vous Connecter au réseau de la maison Ksbahnet ',
                                    context: context,
                                    animation: StyledToastAnimation.scale,
                                    reverseAnimation: StyledToastAnimation.fade,
                                    position: StyledToastPosition.center,
                                    animDuration: Duration(seconds: 1),
                                    duration: Duration(seconds: 4),
                                    curve: Curves.elasticOut,
                                    reverseCurve: Curves.linear,
                                  );
                                });
                              },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Snapshot.connectionState == ConnectionState.done
                                ? Image.asset(
                                    AppAssets.led,
                                    color: lightColor,
                                  )
                                : CircularProgressIndicator(),
                          ],
                        ));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _longpress({required id}) {
    Get.snackbar(
        'Modification effectué', 'Le module numéro $id est bien supprimé ! ',
        colorText: Colors.red);
  }
}
