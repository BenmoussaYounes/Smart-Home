// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:http/http.dart' as Http;

import '../utils/AppSpaces.dart';

class ColorController extends StatefulWidget {
  const ColorController({Key? key}) : super(key: key);

//setColors param 1: RED, param2: GREEN, param3: BLUE, param4: WHITE
// (all range from 0 to 255)
// (ex: admin:admin@192.168.1.1:8060/api/set/1/setColors/R0/G0/B0/W0)

  @override
  _ColorControllerState createState() => _ColorControllerState();
}

class _ColorControllerState extends State<ColorController> {
  static Color currentColor = Colors.amber;

  void setRGBColorAPI({required Color coleur}) {
    int R = coleur.red;
    int G = coleur.green;
    int B = coleur.blue;
    int W = coleur.alpha;
    Map<String, String> header = {
      'accept': 'application/json',
      'authorization': 'Basic YWRtaW46YW1waW8=',
    };
    final url =
        'http://admin:admin@192.168.1.1:8060/api/set/1/setColors/$R/$G/$B/$W';
    Http.get(Uri.parse(url), headers: header);
  }

  void changeColor(Color color) => setState(() {
        currentColor = color;
        //setRGBColorAPI(coleur: color);
        // admin:admin@192.168.1.1:8060/api/set/1/setColors/0/0/0/0)
      });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
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
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(
                              'Select',
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
      ),
    );
  }
}
