import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';

import 'package:client/src/api/enviroment.dart';
import 'package:client/src/models/category.dart';
import 'package:client/src/models/field.dart';
import 'package:client/src/models/response_api.dart';
import 'package:client/src/models/user.dart';
import 'package:client/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class FieldsProvider{

String _url = Enviroment.API_GEOFIELD;
String _api = '/api/fields';
BuildContext context;

User sessionUser;


Future init(BuildContext context, User sessionUser){
  this.context = context;
  this.sessionUser = sessionUser;
}

Future<Stream> create(Field field, List<File> images) async {
    try{
    Uri url = Uri.http(_url, '$_api/create');
    final request = http.MultipartRequest('POST', url);
    request.headers['Authorization'] = sessionUser.sessionToken;


    for (int i =0; i < images.length; i++){
      request.files.add(http.MultipartFile(
        'image',
        http.ByteStream(images[i].openRead().cast()),
        await images[i].length(),
        filename: basename(images[i].path)
      ));
    }

      request.fields['field'] = json.encode(field);
      final response = await request.send(); // enviar petición
      return response.stream.transform(utf8.decoder);


    }
    catch(e){
      print ('Error: $e');
      return null;
    }
  }


}