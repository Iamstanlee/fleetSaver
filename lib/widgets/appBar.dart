import 'package:fleetdownloader/appTheme.dart';
import 'package:fleetdownloader/bloc/appBloc.dart';
import 'package:fleetdownloader/helper/functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

PreferredSizeWidget appBar(BuildContext context, String title) {
  var appBloc = Provider.of<AppBloc>(context);
  return AppBar(
    title: Text('$title',
        style: appBloc.darkMode
            ? textStyleDark.copyWith(fontWeight: FontWeight.bold, fontSize: 18)
            : textStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 18)),
    centerTitle: true,
    leading: InkWell(
        onTap: () {
          pop(context);
        },
        child: imageIcon('icon-arrowback')),
  );
}
