import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as Http;
import 'package:smart_home_12/services/Authentification.dart';

//**AMPIO-API
//prv
class ampio_api {
  static String ip = user_info().get_user_ip();
  static Future<dynamic> getdevicesList() async {
    print('user Ip $ip');
    final url = 'http://admin:Ksbahnet1@$ip:8060/api/json/devices';
    Http.Response res = await Http.get(Uri.parse(url));
    if (res.statusCode != 200) {
      throw Exception('http.get error: statusCode= ${res.statusCode}');
    } else {
      var data = json.decode(res.body);
      return data['List'];
    }
  }

  static Future<dynamic> RGBLightSet(String State, int id) async {
    //turnOff
    //turnOn
    final url = 'http://admin:Ksbahnet1@$ip:8060/api/set/$id/$State';
    var res = await Http.get(Uri.parse(url));
    var obj = json.decode(res.body);
    if (res.statusCode == 200) {
      return obj['Response'];
    } else {
      throw Exception('Error');
    }
  }

  static void setRGBColorAPI({required Color coleur, required int id}) {
    //setColors param 1: RED, param2: GREEN, param3: BLUE, param4: WHITE
    // (all range from 0 to 255)
    // (ex: admin:admin@192.168.1.1:8060/api/set/1/setColors/R0/G0/B0/W0)
    int R = coleur.red;
    int G = coleur.green;
    int B = coleur.blue;
    int W = coleur.alpha;

    final url =
        'http://admin:Ksbahnet1@$ip:8060/api/set/$id/setColors/$R/$G/$B/$W';
    Http.get(Uri.parse(url));
  }

  static Future<bool> GetStateOfDevice({required int id}) async {
    // If Off State return 0
    final url = 'http://admin:Ksbahnet1@$ip:8060/api/json/device/$id/state';
    var object = await Http.get(Uri.parse(url));
    if (object.statusCode == 200) {
      Map res = jsonDecode(object.body);
      if (res['Results']['state'] == '0') {
        //If Device is off return value gonna be 0
        return Future<bool>.value(false);
      } else {
        //Device is On
        return Future<bool>.value(true);
      }
    } else {
      throw Exception(
          'Probléme de connexion  StatueCode :${object.statusCode}');
    }
  }

  static Future GetvalueOfDeviceLED({required int id}) async {
    print('im getting it');
    // If Off State return 0
    final url = 'http://admin:Ksbahnet1@$ip:8060/api/json/device/$id/state';
    var object = await Http.get(Uri.parse(url));
    print('api called');
    if (object.statusCode == 200) {
      Map res = jsonDecode(object.body);
      String value = res['Results']['state'];
      return value;
    } else {
      throw Exception('Connexion Error ! StatueCode : ${object.statusCode}');
    }
  }

  static Future<dynamic> LightSet({
    required String State,
    required int Id,
  }) async {
    //turnOff
    //turnOn
    // 200 Id of normal Light
    final url = 'http://admin:Ksbahnet1@$ip:8060/api/set/$Id/$State';
    var res = await Http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      //var obj = json.decode(res.body);
      //  return obj['Response'];
    } else {
      throw Exception('Error');
    }
  }

  static Future<dynamic> SetledLightvalue({
    required int value,
    required int Id,
  }) async {
    // setValue (setValue for device for example. led, value must but from 0 - 255)
    final url = 'http://admin:Ksbahnet1@$ip:8060/api/set/$Id/setValue/$value';
    var res = await Http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      // var obj = json.decode(res.body);
      // return obj['Response'];
    } else {
      throw Exception('Error');
    }
  }

// Windows
  static Future<dynamic> RollerSet(String State, int id) async {
    //open
    //stop
    //close
    final url = 'http://admin:Ksbahnet1@ip:8060/api/set/$id/$State';
    var res = await Http.get(Uri.parse(url));
    var obj = json.decode(res.body);
    if (res.statusCode == 200) {
      return obj['Response'];
    } else {
      throw Exception('Error');
    }
  }

  static Future<dynamic> SetRollerPos(int Position, int _id) async {
    final url =
        'http://admin:Ksbahnet1@ip:8060/api/set/$_id/setRollerPos/$Position/50';
    var res = await Http.get(Uri.parse(url));
    var obj = json.decode(res.body);
    if (res.statusCode == 200) {
      return obj['Response'];
    } else {
      throw Exception('Error');
    }
  }

/**--------------------------  Scenarios---------------------------------------*/
  static Future<dynamic> OnAll() async {
    List _Devices_List;
    _Devices_List = await getdevicesList();
    _Devices_List.forEach((element) {
      switch (element['typ_komponentu']) {
        case 'przekaznik':
          {
            final url =
                'http://admin:Ksbahnet1@$ip:8060/api/set/${element['id']}/turnOn';
            Http.get(Uri.parse(url));
            break;
          }
        case 'led':
          {
            final url =
                'http://admin:Ksbahnet1@ip:8060/api/set/${element['id']}/setValue/235';
            Http.get(Uri.parse(url));
            break;
          }
        case 'rgb':
          {
            final url =
                'http://admin:Ksbahnet1@$ip:8060/api/set/${element['id']}/turnOn';
            Http.get(Uri.parse(url));
            break;
          }
        case 'roller':
          {
            final url =
                'http://admin:Ksbahnet1@ip:8060/api/set/${element['id']}/open';
            Http.get(Uri.parse(url));
            break;
          }
      }
    });
  }

  static Future OffAll() async {
    List _Devices_List;
    _Devices_List = await getdevicesList();
    _Devices_List.forEach((element) {
      switch (element['typ_komponentu']) {
        case 'przekaznik':
          {
            final url =
                'http://admin:Ksbahnet1@$ip:8060/api/set/${element['id']}/turnOff';
            Http.get(Uri.parse(url));
            break;
          }
        case 'led':
          {
            final url =
                'http://admin:Ksbahnet1@ip:8060/api/set/${element['id']}/setValue/0';
            Http.get(Uri.parse(url));
            break;
          }
        case 'rgb':
          {
            final url =
                'http://admin:Ksbahnet1@$ip:8060/api/set/${element['id']}/turnOff';
            Http.get(Uri.parse(url));
            break;
          }
        case 'roller':
          {
            final url =
                'http://admin:Ksbahnet1@ip:8060/api/set/${element['id']}/close';
            Http.get(Uri.parse(url));
            break;
          }
      }
    });
  }

  static Future onAll_light() async {
    List _Devices_List;
    _Devices_List = await getdevicesList();
    _Devices_List.forEach((element) {
      switch (element['typ_komponentu']) {
        case 'przekaznik':
          {
            final url =
                'http://admin:Ksbahnet1@$ip:8060/api/set/${element['id']}/turnOn';
            Http.get(Uri.parse(url));
            break;
          }
        case 'led':
          {
            final url =
                'http://admin:Ksbahnet1@$ip:8060/api/set/${element['id']}/setValue/230';
            Http.get(Uri.parse(url));
            break;
          }
        case 'rgb':
          {
            final url =
                'http://admin:Ksbahnet1@$ip:8060/api/set/${element['id']}/setColors/99/99/99/20';
            Http.get(Uri.parse(url));
            break;
          }
        default:
          {
            break;
          }
      }
    });
  }

  static Future offAll_light() async {
    List _Devices_List;
    _Devices_List = await getdevicesList();
    _Devices_List.forEach((element) {
      switch (element['typ_komponentu']) {
        case 'przekaznik':
          {
            final url =
                'http://admin:Ksbahnet1@$ip:8060/api/set/${element['id']}/turnOff';
            Http.get(Uri.parse(url));
            break;
          }
        case 'led':
          {
            final url =
                'http://admin:Ksbahnet1@$ip:8060/api/set/${element['id']}/setValue/0';
            Http.get(Uri.parse(url));
            break;
          }
        case 'rgb':
          {
            final url =
                'http://admin:Ksbahnet1@$ip:8060/api/set/${element['id']}/setColors/00/00/00/00';
            Http.get(Uri.parse(url));
            break;
          }
        default:
          {
            break;
          }
      }
    });
  }

  static Future open_All_rollers_at_50() async {
    List _Devices_List;
    _Devices_List = await getdevicesList();
    _Devices_List.forEach((element) {
      switch (element['typ_komponentu']) {
        case 'roller':
          {
            final url =
                'http://admin:Ksbahnet1@ip:8060/api/set/${element['id']}/setRollerPos/50/50';
            Http.get(Uri.parse(url));
            break;
          }

        default:
          {
            break;
          }
      }
    });
  }

  static Future close_All_rollers() async {
    List _Devices_List;
    _Devices_List = await getdevicesList();
    _Devices_List.forEach((element) {
      switch (element['typ_komponentu']) {
        case 'roller':
          {
            //open
            //stop
            //close
            final url =
                'http://admin:Ksbahnet1@ip:8060/api/set/${element['id']}/close';
            Http.get(Uri.parse(url));

            break;
          }

        default:
          {
            break;
          }
      }
    });
  }

  static Future open_All_rollers() async {
    List _Devices_List;
    _Devices_List = await getdevicesList();
    _Devices_List.forEach((element) {
      switch (element['typ_komponentu']) {
        case 'roller':
          {
            //open
            //stop
            //close
            final url =
                'http://admin:Ksbahnet1@ip:8060/api/set/${element['id']}/open';
            Http.get(Uri.parse(url));

            break;
          }
        default:
          {
            break;
          }
      }
    });
  }

  static Future Simulation_de_precense() async {
    List _Devices_List;
    _Devices_List = await getdevicesList();
    _Devices_List.forEach((element) {
      switch (element['typ_komponentu']) {
        case 'przekaznik':
          {
            final url =
                'http://admin:Ksbahnet1@$ip:8060/api/set/${element['id']}/turnOn';
            Http.get(Uri.parse(url));
            break;
          }
        default:
          {
            break;
          }
      }
    });
    await Future.delayed(Duration(seconds: 15));
    _Devices_List.forEach((element) {
      switch (element['typ_komponentu']) {
        case 'led':
          {
            final url =
                'http://admin:Ksbahnet1@$ip:8060/api/set/${element['id']}/setValue/240';
            Http.get(Uri.parse(url));
            break;
          }
        default:
          {
            break;
          }
      }
    });
    await Future.delayed(Duration(seconds: 8));
    _Devices_List.forEach((element) {
      switch (element['typ_komponentu']) {
        case 'przekaznik':
          {
            final url =
                'http://admin:Ksbahnet1@$ip:8060/api/set/${element['id']}/turnOff';
            Http.get(Uri.parse(url));
            break;
          }
        default:
          {
            break;
          }
      }
    });
    await Future.delayed(Duration(seconds: 8));

    _Devices_List.forEach((element) {
      switch (element['typ_komponentu']) {
        case 'przekaznik':
          {
            final url =
                'http://admin:Ksbahnet1@$ip:8060/api/set/${element['id']}/turnOn';
            Http.get(Uri.parse(url));
            break;
          }
        default:
          {
            break;
          }
      }
    });
    await Future.delayed(Duration(seconds: 8));
    _Devices_List.forEach((element) {
      switch (element['typ_komponentu']) {
        case 'przekaznik':
          {
            final url =
                'http://admin:Ksbahnet1@$ip:8060/api/set/${element['id']}/turnOff';
            Http.get(Uri.parse(url));
            break;
          }
        default:
          {
            break;
          }
      }
    });
    await Future.delayed(Duration(seconds: 8));
    _Devices_List.forEach((element) {
      switch (element['typ_komponentu']) {
        case 'led':
          {
            final url =
                'http://admin:Ksbahnet1@$ip:8060/api/set/${element['id']}/setValue/100';
            Http.get(Uri.parse(url));
            break;
          }
        default:
          {
            break;
          }
      }
    });
    await Future.delayed(Duration(seconds: 8));
    _Devices_List.forEach((element) {
      switch (element['typ_komponentu']) {
        case 'led':
          {
            final url =
                'http://admin:Ksbahnet1@$ip:8060/api/set/${element['id']}/setValue/0';
            Http.get(Uri.parse(url));
            break;
          }
        default:
          {
            break;
          }
      }
    });
  }
}
