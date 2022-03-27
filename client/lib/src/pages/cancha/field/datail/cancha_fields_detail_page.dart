import 'package:client/src/models/field.dart';
import 'package:client/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import 'cancha_fields_detail_controller.dart';

class CanchaFieldsDetailPage extends StatefulWidget {
  Field field;

  CanchaFieldsDetailPage({Key key, @required this.field}) : super(key: key);

  @override
  State<CanchaFieldsDetailPage> createState() => _CanchaFieldsDetailPageState();
}

class _CanchaFieldsDetailPageState extends State<CanchaFieldsDetailPage> {
  CanchaFieldsDetailController _con = new CanchaFieldsDetailController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh, widget.field);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Column(
        children: [
          _imageSlideShow(),
          _textName(),
          _textDescription(),
          _textAdress(),
          Spacer(),
          _buttonGoMap()
        ],
      ),
    );
  }

  Widget _textName() {
    return Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(right: 30, left: 15, top: 30),
        child: Text(_con.field?.name ?? '',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)));
  }

  Widget _textDescription() {
    return Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(right: 30, left: 15, top: 15),
        child: Text(_con.field?.description ?? '',
            style: TextStyle(fontSize: 20, color: Colors.grey)));
  }

  Widget _textAdress() {
    return Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(right: 30, left: 15, top: 15),
        child: Text(
            _con.field?.adress[0].street1 +
                    ' y ' +
                    _con.field?.adress[0].street2 ??
                '',
            style: TextStyle(fontSize: 20, color: Colors.grey)));
  }

  Widget _buttonGoMap() {
    return Container(
        margin: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 30),
        child: ElevatedButton(
            onPressed: _con.goToMap,
            style: ElevatedButton.styleFrom(
                primary: MyColors.primaryColor,
                padding: EdgeInsets.symmetric(vertical: 5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Text('VER EN MAPA',
                            style: TextStyle(
                              fontSize: 16,
                            )))),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        margin: EdgeInsets.only(left: 50, top: 7),
                        height: 30,
                        child: Image.asset('assets/img/google_maps.png')))
              ],
            )));
  }

  Widget _imageSlideShow() {
    return Stack(
      children: [
        ImageSlideshow(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.4,
          initialPage: 0,
          indicatorColor: MyColors.primaryColor,
          indicatorBackgroundColor: Colors.grey,
          children: [
            FadeInImage(
              image: _con.field?.image1 != null
                  ? NetworkImage(_con.field.image1)
                  : AssetImage('assets/img/cancha.png'),
              fit: BoxFit.contain,
              fadeInDuration: Duration(milliseconds: 50),
              placeholder: AssetImage('assets/img/no-image.png'),
            ),
            FadeInImage(
              image: _con.field?.image2 != null
                  ? NetworkImage(_con.field.image2)
                  : AssetImage('assets/img/no-image.png'),
              fit: BoxFit.contain,
              fadeInDuration: Duration(milliseconds: 50),
              placeholder: AssetImage('assets/img/no-image.png'),
            ),
          ],
          onPageChanged: (value) {
            print('Page changed: $value');
          },
          autoPlayInterval: 3000,
          isLoop: true,
        ),
        Positioned(
            left: 10,
            top: 5,
            child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_back_ios, color: MyColors.primaryColor)))
      ],
    );
  }

  void refresh() {
    setState(() {});
  }
}
