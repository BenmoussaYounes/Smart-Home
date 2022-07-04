import 'package:flutter/material.dart';
import 'package:smart_home_12/utils/theme.dart';
import '../../../db/db_home.dart';
import '../../../services/Authentification.dart';
import '../../home/BottomNavigationScreen.dart';
import '../../sign_up/signup.dart';
import 'background.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool visible = true;
  bool _rememberMe = false;
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _mdpcontroller = TextEditingController();
  bool _email_error = false;
  bool _mdp_error = false;
  String? _mdp_error_msg = null;
  String? _email_error_msg = null;
  // --- db var
  List<String> _emails_list = [''];
  List<String> _mdp_list = [''];
  void _db_getmails() async {
    List<Map<String, dynamic>> temp = await DB_Home.get_db_emails();
    _emails_list = List<String>.filled(temp.length, '');
    int i = 0;
    temp.forEach((element) {
      _emails_list[i] = element['email'];
      i++;
    });
  }

  void _db_getmdp() async {
    List<Map<String, dynamic>> temp = await DB_Home.get_db_mdp();
    _mdp_list = List<String>.filled(temp.length, '');
    int i = 0;
    temp.forEach((element) {
      _mdp_list[i] = element['mot_de_passe'];
      i++;
    });
  }

  @override
  void initState() {
    _db_getmails();
    _db_getmdp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.all(15),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("The  New  House",
                    style: headingstyle.copyWith(
                        color:
                            kPrimaryColor)), //Theme.of(context).textTheme.headline2),
                SizedBox(height: size.height * 0.03),
                _emailButton(context),
                SizedBox(height: size.height * 0.02),
                _passwordButton(context),
                SizedBox(height: size.height * 0.01),
                _Login_remeberme_Button(context),
                _DoneButton(context),
                SizedBox(height: size.height * 0.01),
                _SigneupButton(context),
              ]),
        ),
      ),
    );
  }

  void _geterrormsg() {
    if (_email_error == true) {
      if (_emailcontroller.text.isEmpty) {
        _email_error_msg = 'vous devez remplir Ce champ';
      }
    } else {
      _email_error_msg = null;
    }
    if (_mdp_error == true) {
      if (_mdpcontroller.text.isEmpty) {
        _mdp_error_msg = 'vous devez remplir Ce champ ';
      }
    } else {
      _mdp_error_msg = null;
    }
  }

  void _sheckvalidate() {
    if (_emailcontroller.text.isEmpty) {
      _email_error = true;
    } else {
      _email_error = false;
    }
    if (_mdpcontroller.text.isEmpty) {
      _mdp_error = true;
    } else {
      _mdp_error = false;
    }
  }

  Widget _emailButton(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      child: TextFormField(
        controller: _emailcontroller,
        style: bodystyle.copyWith(color: Colors.black),
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: kPrimaryColor),
              borderRadius: BorderRadius.circular(20),
            ),
            errorText: _email_error_msg,
            errorStyle: subtitlestyle.copyWith(color: Colors.redAccent),
            labelText: "Email",
            labelStyle: titlestyle.copyWith(color: Colors.black),
            hintText: "Name@exampl.com",
            hintStyle: subtitlestyle.copyWith(color: Colors.black),
            hoverColor: Colors.black,
            prefixIcon: Icon(
              Icons.email,
              color: kPrimaryColor,
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1.0, color: kPrimaryLightColor),
                borderRadius: BorderRadius.circular(20))),
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        cursorColor: Colors.black,
        textInputAction: TextInputAction.done,
      ),
    );
  }

  _passwordButton(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      child: TextFormField(
        style: bodystyle.copyWith(color: Colors.black),
        controller: _mdpcontroller,
        decoration: InputDecoration(
            hintText: 'Entrer Votre mode de passe ici',
            hintStyle: subtitlestyle.copyWith(color: Colors.black),
            errorText: _mdp_error_msg,
            errorStyle: subtitlestyle.copyWith(color: Colors.redAccent),
            label: Text('Mot de passe',
                style: titlestyle.copyWith(color: Colors.black)),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: kPrimaryColor, width: 2),
            ),
            prefixIcon: Icon(
              Icons.lock,
              color: kPrimaryColor,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                  (visible == false) ? Icons.visibility : Icons.visibility_off),
              color: kPrimaryColor,
              onPressed: () {
                setState(() {
                  visible = !visible;
                });
              },
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1.0, color: kPrimaryLightColor),
                borderRadius: BorderRadius.circular(20))),
        maxLines: 1,
        keyboardType: TextInputType.visiblePassword,
        obscureText: visible,
        cursorColor: Colors.black,
        textInputAction: TextInputAction.done,
      ),
    );
  }

  _Login_remeberme_Button(BuildContext context) {
    return Container(
      //  margin: EdgeInsets.only(right: 25),
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Text(
          'Se souvenir de moi ?',
          style: subtitlestyle.copyWith(color: kPrimaryColor),
        ),
        Checkbox(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
          side: MaterialStateBorderSide.resolveWith(
            (states) => BorderSide(width: 1.0, color: Colors.black),
          ),
          fillColor: MaterialStateProperty.all(Colors.transparent),
          checkColor: kPrimaryColor,
          onChanged: (_value) {
            setState(() {
              _rememberMe = _value as bool;
            });
          },
          value: _rememberMe,
        ),
      ]),
    );
  }

  _SigneupButton(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      //  margin: EdgeInsets.only(top: 10),
      width: size.width * 0.8,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => sign_up()));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('Creé un compte',
                style: subtitlestyle.copyWith(color: kPrimaryColor))
          ],
        ),
      ),
    );
  }

  _DoneButton(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      width: size.width * 0.8,
      child: OutlinedButton(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Connexion',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ))
        ]),
        onPressed: () {
          _sheckvalidate();
          if (_mdp_error == false && _email_error == false) {
            for (int i = 0; i < _emails_list.length; i++) {
              if (_emailcontroller.text == _emails_list[i] &&
                  _mdpcontroller.text == _mdp_list[i]) {
                if (_rememberMe == true) {
                  signup().updateaccess(true);
                }
                user_info().update_user_id(
                    email: _emailcontroller.text, mdp: _mdpcontroller.text);
                user_info().update_user_ip(
                    email: _emailcontroller.text, mdp: _mdpcontroller.text);
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (_) {
                  return BottomNavigationScreen();
                }));
              }
            }
            setState(() {
              _email_error_msg = 'mode passe ou email invalide';
              _mdp_error_msg = 'mode passe ou email invalide ';
            });
          } else {
            setState(() {
              _geterrormsg();
            });
          }
        },
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide())),
            backgroundColor: MaterialStateProperty.all(kPrimaryLightColor),
            side: MaterialStateProperty.all(
                BorderSide(width: 1.0, style: BorderStyle.solid))),
      ),
    );
  }
}
