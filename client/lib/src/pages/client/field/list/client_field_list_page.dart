import 'dart:convert';

import 'package:client/src/models/category.dart';
import 'package:client/src/pages/client/field/list/client_field_list_controller.dart';
import 'package:client/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const LatLng SOURCE_LOCATION = LatLng(-0.2809903, -78.5447584);
const LatLng DEST_LOCATION = LatLng(-0.2883072, -78.5464321);

class ClientFieldListPage extends StatefulWidget {
  const ClientFieldListPage({Key key}) : super(key: key);

  @override
  State<ClientFieldListPage> createState() => _ClientFieldListPageState();
}

Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

class _ClientFieldListPageState extends State<ClientFieldListPage> {
  ClientFieldListController _con = new ClientFieldListController();

  var marker;
  double lat;
  double long;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.key,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: _menuDrawer(),
      ),
      drawer: _drawer(),
      body:
      Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.14),
          child: _googleMaps()),
    );
  }

  Widget _googleMaps() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _con.initialPosition,
      onMapCreated: _con.onMapCreated,
      myLocationButtonEnabled: false,
      myLocationEnabled: false,
      markers: _createMarkers('2'),
      onCameraMove: (position) {
        _con.initialPosition = position;
      },
      onCameraIdle: () async {
        await _con.setLocationDraggableInfo();
      },
    );
  }

  Set<Marker> _createMarkers(id) {
    _con.getField(id);
    marker = Set<Marker>();
    if (lat != null && long != null) {
      marker.add(Marker(
          markerId: MarkerId(_con.adressName.toString()),
          infoWindow: InfoWindow(
            title: _con.adressName.toString(),
          ),
          position: LatLng(lat, long),
          icon: BitmapDescriptor.defaultMarker));
    }

    for (var item in _con.fields) {
      print('item2 ${item.adress.toString()}');
      marker.add(Marker(
          markerId: MarkerId(item.adress[0].adress.toString()),
          infoWindow: InfoWindow(
              title: item.description,
              snippet: item.adress[0].adress.toString().toUpperCase(),
              onTap: () {}),
          position: LatLng(item.adress[0].latitude, item.adress[0].longitude),
          icon: BitmapDescriptor.defaultMarker));
    }
    return marker;
  }

  Widget _menuDrawer() {
    return GestureDetector(
        onTap: _con.openDrawer,
        child: Container(
          margin: EdgeInsets.only(left: 20),
          alignment: Alignment.centerLeft,
          child: Image.asset('assets/img/menu.png', width: 20, height: 20),
        ));
  }

  Widget _drawer() {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
      DrawerHeader(
          decoration: BoxDecoration(color: MyColors.primaryColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${_con.user?.name ?? ''} ${_con.user?.lastname ?? ''} ',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
              ),
              Text(
                _con.user?.email ?? '',
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[200],
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
                maxLines: 1,
              ),
              Text(
                _con.user?.phone ?? '',
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[200],
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
                maxLines: 1,
              ),
              Container(
                height: 60,
                margin: EdgeInsets.only(top: 10),
                child: FadeInImage(
                  image: _con.user?.image != null
                      ? NetworkImage(_con.user?.image)
                      : AssetImage('assets/img/no-image.png'),
                  fit: BoxFit.contain,
                  fadeInDuration: Duration(milliseconds: 50),
                  placeholder: AssetImage('assets/img/no-image.png'),
                ),
              )
            ],
          )),
      ListTile(
        onTap: _con.goToUpdatePage,
        title: Text('Editar Perfil'),
        trailing: Icon(Icons.edit_outlined),
      ),
      _con.user != null
          ? _con.user.roles.length > 1
              ? ListTile(
                  onTap: _con.goToRoles,
                  title: Text('Seleccionar rol'),
                  trailing: Icon(Icons.person_outline),
                )
              : Container()
          : Container(),
      ListTile(
        onTap: _con.logout,
        title: Text('Cerrar Sesión'),
        trailing: Icon(Icons.power_settings_new),
      )
    ]));
  }

  void refresh() {
    setState(() {});
  }
}
