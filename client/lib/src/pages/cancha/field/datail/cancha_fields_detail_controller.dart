import 'package:client/src/models/field.dart';
import 'package:flutter/material.dart';

class CanchaFieldsDetailController {
  BuildContext context;
  Function refresh;
  Field field;

  Future init(BuildContext context, Function refresh, Field field) {
    this.context = context;
    this.refresh = refresh;
    this.field = field;

    refresh();
  }

  void goToMap() {
    Navigator.pushNamed(context, 'client/field/list');
  }
}
