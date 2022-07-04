import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_home_12/screens/Scences/Sc%C3%A9nario_Page.dart';
import 'package:smart_home_12/screens/Setting/Settings.dart';
import 'package:smart_home_12/screens/Chambre/chambre_Page.dart';

import 'Home.dart';

class BottomNavigationScreen extends StatefulWidget {
  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _SelectedPageIndex = 0;
  BottomNavigationBar BottomBar(BuildContext context) {
    List<BottomNavigationBarItem> Myitems = [
      BottomNavigationBarItem(
        icon: const Icon(
          Icons.home,
        ),
        label: 'Home',
        backgroundColor:
            Theme.of(context).backgroundColor, // Colors.grey.shade100,
      ),
      BottomNavigationBarItem(
        icon: const Icon(
          Icons.backup_table,
        ),
        label: 'Chambres',
        backgroundColor:
            Theme.of(context).backgroundColor, // Colors.grey.shade100,
      ),
      BottomNavigationBarItem(
        label: 'Scénario',
        backgroundColor:
            Theme.of(context).backgroundColor, //Colors.grey.shade100,
        icon: Icon(Icons.graphic_eq),
      ),
      BottomNavigationBarItem(
          icon: const Icon(
            Icons.account_circle_outlined,
          ),
          label: 'Compte',
          backgroundColor:
              Theme.of(context).backgroundColor //Colors.grey.shade100,
          ),
    ];

    return BottomNavigationBar(
      currentIndex: _SelectedPageIndex,
      onTap: (index) => setState(() {
        _SelectedPageIndex = index;
      }),
      selectedLabelStyle: TextStyle(fontSize: 1),
      selectedItemColor: Theme.of(context).primaryColor, //kPrimaryColor,
      unselectedItemColor: Get.isDarkMode ? Colors.white : Color(0xff867cef),
      items: Myitems,
    );
  }

  Widget ScreensSelecter() {
    switch (_SelectedPageIndex) {
      case 0:
        {
          return Homepage();
        }
      case 1:
        {
          return Chambre_Page();
        }
      case 2:
        {
          return const ScenarioPage();
        }
      case 3:
        {
          return Settings();
        }
      default:
        {
          return Container();
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
          body: ScreensSelecter(),
          bottomNavigationBar: BottomBar(context),
        ),
      ),
    );
  }
}
