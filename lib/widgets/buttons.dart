import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_home_12/utils/theme.dart';
import '../services/ampio_smarthome_API.dart';
import '../utils/AppAssets.dart';
import '../utils/AppSpaces.dart';
import '../utils/Others.dart';

class TopSelectButton extends StatelessWidget {
  const TopSelectButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      items: [
        DropdownMenuItem<String>(
          child: Text('Living Room'),
          value: 'Living Room',
        ),
        DropdownMenuItem<String>(
          child: Text('All Rooms'),
          value: 'All Rooms',
        ),
        DropdownMenuItem<String>(
          child: Text('Sallon'),
          value: 'Sallon',
        )
      ],
      hint: Text(
        'Tous les Chambres',
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
      ),
      style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black),
      icon: Padding(
          padding: EdgeInsets.only(left: 5),
          child: Icon(CupertinoIcons.chevron_down)),
      iconSize: 20,
      iconEnabledColor: Colors.black,
      underline: SizedBox.shrink(),
      onChanged: (value) {},
    );
  }
}

class HomeButton extends StatelessWidget {
  const HomeButton({
    Key? key,
    required this.image,
    required this.text,
    required this.onTap,
    this.fontSize = 18,
  }) : super(key: key);
  final String image;
  final String text;
  final VoidCallback onTap;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Get.theme.backgroundColor,
          ),
          child: Column(children: [
            AppSpaces.vertical15,
            Expanded(
              child: Center(
                child: Container(
                  width: Get.width / 5,
                  height: Get.height / 10,
                  child: Image.asset(
                    image,
                  ),
                ),
              ),
            ),
            AppSpaces.vertical15,
            Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
            AppSpaces.vertical15,
          ]),
        ),
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  const CircleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: appGradient,
        ),
        padding: EdgeInsets.all(9.0),
        child: Image.asset(
          AppAssets.onOff,
          width: 25,
          height: 25,
          color: Colors.white,
        ),
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: appGradient,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 45, vertical: 10),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w200,
            ),
          ),
        ),
      ),
    );
  }
}

class FontSizePickerDialog extends StatefulWidget {
  /// initial selection for the slider
  final double SliderintValue;
  final Color activeSliderColor;
  final int id;
  const FontSizePickerDialog(
      {Key? key,
      required this.SliderintValue,
      required this.activeSliderColor,
      required this.id})
      : super(key: key);

  @override
  _FontSizePickerDialogState createState() => _FontSizePickerDialogState();
}

class _FontSizePickerDialogState extends State<FontSizePickerDialog> {
  /// current selection of the slider
  late double _value;
  late Color _activeColor;
  late int _id;
  @override
  void initState() {
    super.initState();
    _value = widget.SliderintValue;
    _activeColor = widget.activeSliderColor;
    _id = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      title: Text(
        "Selecteur d'intensité LED ",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      content: Container(
        height: size.height * 0.2,
        child: Column(
          children: [
            Divider(color: Colors.black),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  (_activeColor == Colors.redAccent)
                      ? 'lumiére LED Off '
                      : 'LED a ${_value.round()} %',
                  style: TextStyle(
                      color: _activeColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            AppSpaces.vertical15,
            SliderTheme(
              data: SliderThemeData(
                  trackHeight: 16,
                  valueIndicatorColor: kPrimaryLightColor,
                  activeTickMarkColor: Colors.transparent,
                  inactiveTickMarkColor: Colors.transparent,
                  activeTrackColor: _activeColor,
                  inactiveTrackColor: kPrimaryLightColor,
                  thumbColor: _activeColor),
              child: SizedBox(
                width: size.width * 0.5,
                child: Slider(
                    value: _value,
                    min: 0,
                    max: 255,
                    divisions: 255,
                    label: '${_value.round()} %',
                    onChanged: (val) {
                      ampio_api.SetledLightvalue(
                          value: _value.toInt(), Id: _id);

                      setState(() {
                        if (val != 0) {
                          _activeColor = Colors.orangeAccent;
                        }
                        _value = val;
                      });
                    }),
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            // SetledLightvalue(value:_value.round(), Id: '');
            // Use the second argument of Navigator.pop(...) to pass
            // back a result to the page that opened the dialog
            Navigator.pop(context, _value);
            if (_activeColor != Colors.redAccent) {
              ampio_api.SetledLightvalue(value: _value.round(), Id: _id);
            }
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(_activeColor),
          ),
          child: Text(
              (_activeColor == Colors.redAccent) ? 'Retour' : 'Choisire',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        )
      ],
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({Key? key, required this.label, required this.onTap})
      : super(key: key);
  final String label;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10,
            ),
            color: Theme.of(context).primaryColor),
        width: 100,
        height: 45,
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
