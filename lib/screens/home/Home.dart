import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:smart_home_12/utils/AppAssets.dart';
import 'package:smart_home_12/utils/theme.dart';
import 'package:weather/weather.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../services/home_settings.dart';

class Homepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Homepagestate();
}

class Homepagestate extends State<Homepage> with TickerProviderStateMixin {
  late DateFormat todayFormat;
  late DateFormat dateFormat;
  late DateFormat timeFormat;

  @override
  void initState() {
    initializeDateFormatting();
    dateFormat = new DateFormat.yMMMMd('fr');
    todayFormat = new DateFormat.EEEE('fr');
    _cityname = CityInfo().load_location_fromBox();
    super.initState();
  }

  bool isOn = false;
  late String _cityname;
  String _weather = '';
  String _Sunrise = '';
  String _Sunset = '';
  String _temp_min = '';
  String _temp_max = '';
  String _temp = '';
  String _winds = '';

  //String today = DateFormat.EEEE().format(DateTime.now());
  //
  // String _time = DateFormat.yMMMMd().format(DateTime.now()).toString();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text('TABLEAU DE BORD'),
            ),
            body: Container(
              margin: EdgeInsets.all(5),
              child: SingleChildScrollView(
                  child: Column(children: [
                _topscreenday(),
                _Clock(),
                SizedBox(
                  height: 10,
                ),
                Divider(color: Colors.brown),
                SizedBox(
                  height: 10,
                ),
                _Weather()
              ])),
            )));
  }

  Widget _topscreenday() {
    String _today = todayFormat.format(DateTime.now());
    String _Date = dateFormat.format(DateTime.now());
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
        Text(_Date,
            style: TextStyle(
                color: Colors.brown[100],
                fontWeight: FontWeight.bold,
                fontSize: 18)),
        SizedBox(width: 10),
        Text(_today,
            style: TextStyle(
                color: Colors.brown[100],
                fontWeight: FontWeight.bold,
                fontSize: 18)),
      ]),
    );
  }

  Widget _Clock() {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DigitalClock(
          areaWidth: size.width * 0.95,
          areaHeight: size.height * 0.13,
          digitAnimationStyle: Curves.easeInOut,
          // Curves.easeInOut
          is24HourTimeFormat: true,
          areaDecoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
          ),
          hourMinuteDigitDecoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.circular(5)),
          secondDigitDecoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.circular(5)),
          hourMinuteDigitTextStyle: TextStyle(
            color:
                Get.isDarkMode ? Colors.white : Theme.of(context).primaryColor,
            fontSize: 80,
          ),
          amPmDigitTextStyle: TextStyle(
              color: Get.isDarkMode
                  ? Colors.white
                  : Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  _Get_weatherInfo({required String cityname}) async {
    WeatherFactory wf = new WeatherFactory("d981766d7a86dd608c164e8f7a6ad564",
        language: Language.FRENCH);
    Weather w = await wf.currentWeatherByCityName(cityname);
    setState(() {
      _weather = w.weatherDescription.toString();
      _Sunset = w.sunset.toString();
      _Sunrise = w.sunrise.toString();
      _temp_max = w.tempMax!.celsius!.toStringAsFixed(2);
      _temp_min = w.tempMin!.celsius!.floor().toStringAsFixed(2);
      // print('temp min : ${w.tempMin} tempmax ${w.tempMax}')
      _winds = w.windSpeed.toString();
      _temp = w.temperature!.celsius!.toStringAsFixed(2);
    });
  }

  Widget _Weather() {
    return FutureBuilder(
        future: _Get_weatherInfo(cityname: _cityname),
        builder: (context, SnapShot) {
          return GestureDetector(
            onTap: () {
              ShowcitynamepickerDialogue();
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                  color: Get.isDarkMode ? Colors.grey : Colors.white70,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                      width: 2.0,
                      color: Get.isDarkMode
                          ? const Color(0xFFFFFFFF)
                          : Theme.of(context).primaryColor)),
              child: Column(children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      fit: BoxFit.cover,
                      child: Text(
                        (_cityname == '') ? 'Alger' : _cityname,
                        style: headingstyle,
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.black,
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                    child:
                                        Text('$_weather', style: titlestyle)),
                                // Icon(
                                //   WeatherIcons.day_cloudy_windy,
                                //   color: Theme.of(context).primaryColor,
                                // ),
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              children: [
                                Text(
                                  _temp,
                                  style: headingstyle,
                                ),
                                Icon(
                                  WeatherIcons.celsius,
                                  color: Theme.of(context).primaryColor,
                                  size: 30,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'min : ${_temp_min}',
                                  style: titlestyle.copyWith(fontSize: 15),
                                ),
                                Text(
                                  'max : ${_temp_max}',
                                  style: titlestyle.copyWith(fontSize: 15),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              Get.isDarkMode
                                  ? AppAssets.weather_dark
                                  : AppAssets.weather,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  _winds,
                                  style: titlestyle,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'm/s',
                                  style: titlestyle.copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ]),
            ),
          );
        });
  }

  CityDialogue({required String city}) {
    TextEditingController newCitynameController = TextEditingController();
    return AlertDialog(
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
                CityInfo().save_location_change_to_box(city);
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
    );
  }

  void ShowcitynamepickerDialogue() async {
    final Cityname = await showDialog<String>(
        context: context,
        builder: (BuildContext ctx) {
          return CityDialogue(city: _cityname);
        });
    if (Cityname != null) {
      setState(() {
        _cityname = Cityname;
        _Get_weatherInfo(cityname: Cityname);
      });
    }
  }
}
