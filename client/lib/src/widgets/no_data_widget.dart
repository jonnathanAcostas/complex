import 'package:flutter/material.dart';


class NoDataWidget extends StatelessWidget {

  String text;
  NoDataWidget({ Key key,this.text }) : super(key: key);

  


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.asset('assets/img/no_data.png'),
          Text(text) 
        ] )
    );
  }
}