import 'package:client/src/models/adress.dart';
import 'package:client/src/models/user.dart';
import 'package:client/src/provider/adress_provider.dart';
import 'package:client/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class ClientAdressListController {
  BuildContext context;
  Function refresh;

  List<Adress> adress = [];
  AdressProvider _adressProvider = new AdressProvider();
  User user;
  SharedPref _sharedPrefer = new SharedPref();

  int radioValue = 0;

  bool isCreated;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPrefer.read('user'));

    _adressProvider.init(context, user);

    refresh();
  }

  void goToNewAdress() async {
    var result = await Navigator.pushNamed(context, 'client/adress/create');

    if (result != null) {
      if (result) {
        refresh();
      }
    }
  }

  void handleRadioValueChange(int value) async {
    radioValue = value;
    _sharedPrefer.save('adress', adress[value]);
    refresh();
  }

  Future<List<Adress>> getAdress() async {
    adress = await _adressProvider.getAll();
    Adress a = Adress.fromJson(await _sharedPrefer.read('adress') ?? {});
    int index = adress.indexWhere((ad) => ad.id == a.id);

    if (index != -1) {
      radioValue = index;
    }
    return adress;
  }
}
