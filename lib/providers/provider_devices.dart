import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyDeviceprovider with ChangeNotifier{
  @override
  void notifyListeners() {
   super.notifyListeners();
  }

  double value_led=0;
  void setLedvalue(double val) async{
    value_led=val;
    SharedPreferences ledval=await SharedPreferences.getInstance();
    ledval.setDouble('Led',value_led);
  }
  Future sheckLedvalue() async{
    SharedPreferences ledval=await SharedPreferences.getInstance();
    double? val=ledval.getDouble('Led');
    if(val==null){
      return value_led=125;
    }else {
      value_led=val;
    }
  }
  double getledvalue(){
    sheckLedvalue();
    return value_led;
  }



 void ChangeSlider(){
 }

}