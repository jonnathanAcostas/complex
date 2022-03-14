import 'package:client/src/pages/cancha/categories/create/cancha_categories_create_page.dart';
import 'package:client/src/pages/cancha/fields/create/cancha_fields_create_page.dart';
import 'package:client/src/pages/cancha/field/list/cancha_field_list_page.dart';
import 'package:client/src/pages/client/adress/create/client_adress_create_page.dart';
import 'package:client/src/pages/client/adress/list/client_adress_list_page.dart';
import 'package:client/src/pages/client/adress/map/client_adress_map_page.dart';
import 'package:client/src/pages/client/field/list/client_field_list_page.dart';
import 'package:client/src/pages/client/field/list/update/client_update_page.dart';
import 'package:client/src/pages/login/login_page.dart';
import 'package:client/src/pages/register/register_page.dart';
import 'package:client/src/pages/roles/roles_page.dart';
import 'package:client/src/utils/my_colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({ Key key }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'GeoFiel',
      initialRoute: 'login',
      routes: {
        'login' : (BuildContext context) => LoginPage(),
        'register' : (BuildContext context) =>  RegisterPage(), 
        'roles' : (BuildContext context) =>  RolesPage(),
        'client/update' : (BuildContext context) =>  ClientUpdatePage(),
        'client/field/list' : (BuildContext context) =>  ClientFieldListPage(),
        'client/adress/list' : (BuildContext context) =>  ClientAdressListPage(),
        'client/adress/create' : (BuildContext context) =>  ClientAdressCreatePage(),
        'client/adress/map' : (BuildContext context) =>  ClientAdressMapPage(),
        'cancha/field/list' : (BuildContext context) =>  CanchaFieldListPage(),
        'cancha/categories/create' : (BuildContext context) =>  CanchaCategoriesCreatePage(),
        'cancha/fields/create' : (BuildContext context) =>  CanchaFieldsCreatePage(),   

      },
      theme: ThemeData(
        primaryColor: MyColors.primaryColor
      ),
      
    );
  }
}