import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kPrimaryColor = Color(0xFF6F35A5);
const Color kPrimaryLightColor = Color(0xFFF1E6FF);
const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const Color primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final light = ThemeData(
    backgroundColor: Colors.white,
    primaryColor: bluishClr,
    primarySwatch: Colors.grey,
    brightness: Brightness.light,
  );
  static final dark = ThemeData(
    backgroundColor: darkHeaderClr,
    primaryColor: darkGreyClr,
    primarySwatch: Colors.grey,
    brightness: Brightness.dark,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
      foregroundColor: darkHeaderClr,
    ),
    appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: darkHeaderClr,
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white)),
    textTheme: const TextTheme(
        //GoogleFonts.openSansTextTheme(),
        headline2: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        headline3: TextStyle(
            color: Colors.black,
            fontSize: 45,
            fontWeight: FontWeight.bold,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(1, 1),
                color: Colors.black38,
              )
            ]),
        headline5: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 25, color: Colors.lightBlue),
        headline4: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.lightBlue)),
    //
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
  static final younes = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.grey, //Colors.blue,
    primaryColor: kPrimaryColor, //Color(0xff867cef),
    backgroundColor: Colors.white, //Color(0xfff0f0f0),
    disabledColor: Color(0xffededed),
    colorScheme: ColorScheme.fromSwatch(accentColor: Color(0xffaf92ea)),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: kPrimaryColor,
      foregroundColor: Colors.white,
    ),

    appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 25, color: kPrimaryColor)),
    textTheme: const TextTheme(
        //GoogleFonts.openSansTextTheme(),
        headline2: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        headline3: TextStyle(
            color: Colors.black,
            fontSize: 45,
            fontWeight: FontWeight.bold,
            shadows: <Shadow>[
              Shadow(
                offset: Offset(1, 1),
                color: Colors.black38,
              )
            ]),
        headline5: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 25, color: Colors.lightBlue),
        headline4: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.lightBlue)),
    //
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

TextStyle get headingstyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.white : Colors.black));
}

TextStyle get subheadingstyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.white : Colors.black));
}

TextStyle get titlestyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.white : Colors.black));
}

TextStyle get subtitlestyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode ? Colors.white : Colors.black));
}

TextStyle get bodystyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode ? Colors.white : Colors.black));
}

TextStyle get body2style {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode ? Colors.grey[200] : Colors.black));
}
// TextTheme(
//         //GoogleFonts.openSansTextTheme(),
//         headline2: TextStyle(
//             color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
//         headline3: TextStyle(
//             color: Colors.black,
//             fontSize: 45,
//             fontWeight: FontWeight.bold,
//             shadows: <Shadow>[
//               Shadow(
//                 offset: Offset(1, 1),
//                 color: Colors.black38,
//               )
//             ]),
//         headline5: TextStyle(
//             fontWeight: FontWeight.bold, fontSize: 25, color: Colors.lightBlue),
//         headline4: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 15,
//             color: Colors.lightBlue))