import 'package:flutter/material.dart';
import 'package:smart_home_12/db/db_home.dart';
import 'package:smart_home_12/model/user.dart';
import 'package:smart_home_12/screens/auth/Login_Page.dart';

import 'package:smart_home_12/utils/theme.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _ipcontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _mdpcontroller = TextEditingController();
  TextEditingController _mdp2controller = TextEditingController();

  late String _nom_utilisateur;
  late String _adresse_ip;
  late String _email;
  late String _mot_de_passe;
  bool name_error = false;
  bool ip_error = false;
  bool email_error = false;
  bool mdp_error = false;
  bool mdp2_error = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Login_Page()));
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 24,
                color: kPrimaryColor,
              )),
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text('Nouveau compte',
              style: headingstyle.copyWith(color: kPrimaryColor)),
          bottom: PreferredSize(
              child: Container(
                color: kPrimaryLightColor,
                height: 4.0,
              ),
              preferredSize: Size.fromHeight(4.0)),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(18),
            child: Column(
              children: [
                SizedBox(height: 20),
                _textfieled(
                  label: 'nom',
                  hint: 'Entrer votre pseudo ici',
                  controller: _namecontroller,
                  icon: Icons.account_circle_outlined,
                  maxlength: 10,
                  type: TextInputType.name,
                  errormsg: _geterrormsg('nom'),
                ),
                _textfieled(
                    label: 'IP',
                    hint: 'exampl : 192.168.1.210',
                    controller: _ipcontroller,
                    icon: Icons.home_outlined,
                    maxlength: 13,
                    type: TextInputType.number,
                    errormsg: _geterrormsg('IP')),
                _textfieled(
                    label: 'email ',
                    hint: 'Name@exampl.com',
                    controller: _emailcontroller,
                    icon: Icons.email_outlined,
                    maxlength: null,
                    type: TextInputType.emailAddress,
                    errormsg: _geterrormsg('email')),
                _textfieled(
                    label: 'mot_de_passe',
                    hint: 'entrer votre mot_de_passe ici',
                    controller: _mdpcontroller,
                    icon: Icons.vpn_key_outlined,
                    maxlength: null,
                    type: TextInputType.visiblePassword,
                    errormsg: _geterrormsg('mdp')),
                _textfieled(
                    label: 'mot_de_passe (Confirmation)',
                    hint: 'entrer votre mot_de_passe ici',
                    controller: _mdp2controller,
                    icon: Icons.vpn_key_outlined,
                    maxlength: null,
                    type: TextInputType.visiblePassword,
                    errormsg: _geterrormsg('mdp2')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [_saveButton(context)],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector _saveButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _sheckvalidate();
        });
        if (ip_error == false &&
            email_error == false &&
            mdp_error == false &&
            mdp2_error == false) {
          _savevalues();
          DB_Home.insert_db_user(user(
              nom_utilisateur: _nom_utilisateur,
              adresse_ip: _adresse_ip,
              mot_de_passe: _mot_de_passe,
              email: _email));
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Login_Page()));
        }
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10,
            ),
            color: kPrimaryColor),
        width: 100,
        height: 45,
        child: Text(
          'Enregistrez \n vous',
          style: const TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Container _textfieled({
    required String label,
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    required int? maxlength,
    required TextInputType type,
    required String? errormsg,
  }) {
    return Container(
      padding: EdgeInsets.only(bottom: 25),
      child: TextFormField(
        style: subtitlestyle.copyWith(color: Colors.black),
        enabled: true,
        autofocus: false,
        obscureText: false,
        cursorColor: Colors.black87,
        controller: controller,
        keyboardType: type,
        onEditingComplete: () {},
        maxLength: maxlength,
        onTap: _sheckvalidate,
        decoration: InputDecoration(
          suffixIcon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          errorText: errormsg,
          errorStyle: subtitlestyle.copyWith(color: Colors.redAccent),
          label: Text(label, style: titlestyle.copyWith(color: kPrimaryColor)),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          hintText: hint,
          labelStyle: subtitlestyle,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              )),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2.0, color: kPrimaryLightColor),
          ),
        ),
      ),
    );
  }

  String? _geterrormsg(String name) {
    switch (name) {
      case 'nom':
        {
          if (name_error == true) {
            return 'Vous devez remplir ce champ';
          } else {
            return null;
          }
        }
      case 'IP':
        {
          if (ip_error == true) {
            return 'Vous devez remplir ce champ';
          } else {
            return null;
          }
        }
      case 'email':
        {
          if (email_error == true) {
            if (_ipcontroller.text.isEmpty == true) {
              return "vous devez remplir Ce champ";
            } else if (_emailcontroller.text.contains('@') == false) {
              return 'Votre email n est pas valide ';
            } else {
              return 'adresse email deja utilise';
            }
          } else {
            return null;
          }
        }
      case 'mdp':
        {
          if (mdp_error == true) {
            if (_mdp2controller.text.isEmpty) {
              return "vous devez remplir Ce champ ";
            } else {
              return 'les deux mot de passe ne sont pas identique';
            }
          } else {
            return null;
          }
        }
      case 'mdp2':
        {
          if (mdp2_error == true) {
            if (_mdp2controller.text.isEmpty) {
              return "vous devez remplir Ce champ ";
            } else if (_mdp2controller.text != _mdpcontroller.text) {
              return "votre mode de passe n est pas identique";
            }
          } else {
            return null;
          }
        }
    }
  }

  void _sheckvalidate() {
    if (_namecontroller.text.isEmpty)
      name_error = true;
    else {
      name_error = false;
    }
    if (_ipcontroller.text.isEmpty) {
      ip_error = true;
    } else {
      ip_error = false;
    }
    if (_emailcontroller.text.isEmpty) {
      email_error = true;
    } else {
      email_error = false;
    }
    if (_emailcontroller.text.contains('@') == false) {
      email_error = true;
    }
    if (_mdpcontroller.text.isEmpty) {
      mdp_error = true;
    } else {
      mdp_error = false;
    }
    if (_mdp2controller.text.isEmpty) {
      mdp2_error = true;
    } else {
      if (_mdp2controller.text == _mdpcontroller.text) {
        mdp2_error = false;
      }
    }
  }

  void _savevalues() {
    _nom_utilisateur = _namecontroller.text;
    _adresse_ip = _ipcontroller.text;
    _email = _emailcontroller.text;
    _mot_de_passe = _mdpcontroller.text;
  }
}
