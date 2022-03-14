import 'package:client/src/models/adress.dart';
import 'package:client/src/provider/adress_provider.dart';
import 'package:client/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class ClientAdressListController {
BuildContext context;
Function refresh;


List<Adress> adress = [];
AdressProvider _adressProvider = new AdressProvider();
SharedPref _sharedPrefer = new SharedPref();

int radioValue = 0;

Future init(BuildContext context,Function refresh){
  this.context = context;
  this.refresh = refresh;

}




void goToNewAdress(){
  Navigator.pushNamed(context, 'client/adress/create');
}

  void handleRadioValueChange(int value){
    radioValue = value;

    print('valor seleccionado: $radioValue');
  }


Future <List<Adress>> getAdress() async{
  adress = await  _adressProvider.getAll();
  return adress;


}


}