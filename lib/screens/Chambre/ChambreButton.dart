import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:smart_home_12/controllers/Chmabre_controller.dart';
import 'package:smart_home_12/screens/module/module_Page.dart';
import 'package:smart_home_12/utils/AppAssets.dart';
import '../../model/Chambre.dart';
import '../../utils/theme.dart';

class ChambreButton extends StatelessWidget {
  const ChambreButton(this._chambre, this._position, {Key? key})
      : super(key: key);

  final chambre _chambre;
  final _position;

  @override
  Widget build(BuildContext context) {
    Future<dynamic> yes_no_dialog() {
      return showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: Text('Modification', style: headingstyle),
              content: Container(
                  child: Text(
                      'Shoutez vous vraiment suprimmer la ${_chambre.title} ?',
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

    return AnimationConfiguration.staggeredGrid(
      duration: const Duration(milliseconds: 1150),
      position: _position,
      columnCount: 2,
      child: SlideAnimation(
        horizontalOffset: 300,
        // verticalOffset: 300,
        child: FadeInAnimation(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) =>
                      Module_Page(_chambre.id_chambre!, _chambre.title)));
            },
            onLongPress: () async {
              bool sheck = await yes_no_dialog();
              if (sheck == true) {
                // Get.snackbar(
                //     'Modifications', "Chambre  Supprimer: '${_chambre.title}' ",
                //     snackPosition: SnackPosition.BOTTOM,
                //     backgroundColor: Colors.white,
                //     colorText: Colors.redAccent,
                //     icon: const Icon(Icons.done, color: Colors.redAccent));
                ChambreController().delete_Chambre(Chambre: this._chambre);
              } else {}
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Get.theme.backgroundColor,
              ),
              child: Column(children: [
                SizedBox(height: 25),
                Expanded(
                  child: Image.asset(
                    _getImage(title: _chambre.title),
                    width: Get.width / 5,
                    height: Get.height / 10,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  _chambre.title,
                  style: subtitlestyle,
                ),
                SizedBox(height: 15)
              ]),
            ),
          ),
        ),
      ),
    );
  }

  String _getImage({required String title}) {
    if (title == 'Cuisine') {
      return AppAssets.kitchen;
    }
    if (title == 'studio') {
      return AppAssets.studio;
    }
    if (title == 'Salle de bain') {
      return AppAssets.bathroom;
    }
    if (title == 'Sallon') {
      return AppAssets.livingroom;
    }
    if (title == 'Chambre') {
      return AppAssets.bedroom;
    }
    if (title == 'Salle de lavage') {
      return AppAssets.washingroom;
    }
    return AppAssets.bedroom;
  }
}
