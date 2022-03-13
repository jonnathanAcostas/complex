import 'package:client/src/models/user.dart';
import 'package:client/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';


class RolesController{


  BuildContext context;
  Function refresh;


  User user;
  SharedPref sharedPref = new SharedPref();

  Future init(BuildContext context, Function refresh)async {
    this.context = context;
    this.refresh = refresh;

  //Obteniendo el usuario de sesios
    user = User.fromJson(await sharedPref.read('user'));

    refresh();
  }
  
 void goToPage(String route) {
   Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
 }
}