import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smart_home_12/db/db_home.dart';
import 'package:smart_home_12/screens/auth/Login_Page.dart';
import 'package:smart_home_12/services/Authentification.dart';
import 'package:smart_home_12/services/theme_services.dart';
import 'package:smart_home_12/utils/theme.dart';
import 'screens/home/BottomNavigationScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
  ));
  await DB_Home.init_user_db();
  await GetStorage.init();
  runApp(MyApp());
}

//(Autorisation == null) ?
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final bool Autorisation = signup().getaccess();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Smart-Home-1.0',
        darkTheme: Themes.dark,
        themeMode: ThemeServices().theme,
        theme: Themes.younes,
        home:
            Autorisation == false ? Login_Page() : BottomNavigationScreen() //,
        );
  }
}
