import 'package:flutter/material.dart';
import 'package:smart_home_12/model/module.dart';
import 'package:smart_home_12/services/ampio_smarthome_API.dart';
import 'package:smart_home_12/widgets/Device.dart';

class moduleButton extends StatefulWidget {
  module _module;
  int index;
  moduleButton(this._module, this.index, {Key? key}) : super(key: key);

  @override
  State<moduleButton> createState() => _moduleButtonState();
}

class _moduleButtonState extends State<moduleButton> {
  late String title;
  late int id;
  late String type;
  late int _index;
  @override
  void initState() {
    title = widget._module.name;
    id = widget._module.id;
    type = widget._module.type;
    _index = widget.index;
    ampio_api.GetStateOfDevice(id: id);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (type == 'led') {
      return LEDlightButton(id, title, _index);
    }
    if (type == 'rgb') {
      return RGBlightbutton(id, title, _index);
    }
    if (type == 'przekaznik') {
      return lightButton(id, title, _index);
    }
    if (type == 'roller') {
      return Roller(id, title, _index);
    } else {
      return Container();
    }
  }
}
