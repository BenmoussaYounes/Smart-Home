import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/provider_login.dart';
import 'components/body.dart';

class Login_Page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Login_Page_State();
}

class _Login_Page_State extends State<Login_Page> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Myprovider>(
      create: (_) => Myprovider(),
      child: SafeArea(
        child: Scaffold(
          body: Body(),
        ),
      ),
    );
  }
}
