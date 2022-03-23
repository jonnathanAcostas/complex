import 'package:client/src/models/adress.dart';
import 'package:client/src/models/field.dart';
import 'package:client/src/models/response_api.dart';
import 'package:client/src/models/user.dart';
import 'package:client/src/pages/client/adress/map/client_adress_map_page.dart';
import 'package:client/src/provider/adress_provider.dart';
import 'package:client/src/utils/my_snackbar.dart';
import 'package:client/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';


class ClientAdressCreateController {
BuildContext context;
Function refresh;

TextEditingController refPointController = new TextEditingController();

TextEditingController adressController = new TextEditingController();

TextEditingController street1Controller = new TextEditingController();

TextEditingController street2Controller = new TextEditingController();


Map<String, dynamic> refPoint;

AdressProvider _adressProvider = new AdressProvider();
User user;

SharedPref _sharedPref = new SharedPref();



Future init(BuildContext context,Function refresh) async {
  this.context = context;
  this.refresh = refresh;
  user = User.fromJson(await _sharedPref.read('user'));
  _adressProvider.init(context, user);
}


void createAdress() async {
  String adressName = adressController.text;
  String street1 = street1Controller.text;
  String street2 = street2Controller.text;
  double lat = refPoint['lat'] ??  0;
  double lng = refPoint['lng'] ??  0;


  if(adressName.isEmpty || street1.isEmpty || street2.isEmpty || lat ==0 || lng == 0){

    MySnackbar.show(context,'Complete los campos');
    return;

  }

  Adress adress = new Adress(
    adress: adressName,
     street1: street1,
     street2: street2,
      latitude: lat,
       longitude: lng
       );

  ResponseApi responseApi =await  _adressProvider.create(adress);

  if(responseApi.success){

    adress.id = responseApi.data;
    _sharedPref.save('adress', adress);

    Fluttertoast.showToast(msg: responseApi.message);
    Navigator.pop(context, true); 
    refresh();
  }

}

void openMap()async {
  refPoint = await showMaterialModalBottomSheet(
    context: context,
    isDismissible: false,
    enableDrag: false,
    builder: (context) => ClientAdressMapPage()
  );

  if(refPoint != null){
    refPointController.text = refPoint['adress'];
    refresh();
  }

}


}