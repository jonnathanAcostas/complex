import 'dart:async';
import 'dart:convert';

import 'package:client/src/models/category.dart';
import 'package:client/src/models/field.dart';
import 'package:client/src/models/user.dart';
import 'package:client/src/provider/categories_provider.dart';
import 'package:client/src/provider/field_provider.dart';
import 'package:client/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClientFieldListController {
  BuildContext context;
  SharedPref _sharedPref = new SharedPref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Function refresh;
  CategoriesProvider _categoriesProvider = new CategoriesProvider();

  FieldsProvider _fieldsProvider = new FieldsProvider();
  Completer<GoogleMapController> _mapController = Completer();
  User user;
  Position _position;

  String adressName;
  LatLng adressLatLng;
  String idCategoryTest;

  CameraPosition initialPosition =
      CameraPosition(target: LatLng(-0.2249878, -78.516911), zoom: 14);

  List<Category> categories = [];

  List<Field> fields = [];

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    _categoriesProvider.init(context, user);
    _fieldsProvider.init(context, user);
    getCategories();

    refresh();
  }

  void logout() {
    _sharedPref.logout(context, user.id);
  }

  void openDrawer() {
    key.currentState.openDrawer();
  }

  void goToUpdatePage() {
    Navigator.pushNamed(context, 'client/update');
  }

  void goToRoles() {
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }

  void getCategories() async {
    categories = await _categoriesProvider.getAll();
    refresh();
  }

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(
        '[{"elementType":"geometry","stylers":[{"color":"#f5f5f5"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#f5f5f5"}]},{"featureType":"administrative.land_parcel","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#ffffff"}]},{"featureType":"road.arterial","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#dadada"}]},{"featureType":"road.highway","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"transit.line","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"transit.station","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#c9c9c9"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]}]');
    _mapController.complete(controller);
  }

  Future<List<Field>> getField(String id) async {
    fields = await _fieldsProvider.getByCategory(id);
    return fields;
  }

  Future<Null> setLocationDraggableInfo() async {
    if (initialPosition != null) {
      double lat = initialPosition.target.latitude;
      double lng = initialPosition.target.longitude;

      List<Placemark> adress = await placemarkFromCoordinates(lat, lng);

      if (adress != null) {
        if (adress.length > 0) {
          String direction = adress[0].thoroughfare;
          String street = adress[0].subThoroughfare;
          String city = adress[0].locality;
          String department = adress[0].administrativeArea;
          String country = adress[0].country;

          adressName = '$direction $street, $city, $department, $country';
          adressLatLng = new LatLng(lat, lng);

          refresh();
        }
      }
    }
  }
}
