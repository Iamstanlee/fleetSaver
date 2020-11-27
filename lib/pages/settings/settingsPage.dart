import 'package:fleetdownloader/appTheme.dart';
import 'package:fleetdownloader/bloc/appBloc.dart';
import 'package:fleetdownloader/helper/functions.dart';
import 'package:fleetdownloader/widgets/appBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    var appBloc = Provider.of<AppBloc>(context);
    return Scaffold(
      appBar: appBar(context, 'Settings'),
      body: ListView(
        children: [
          listTile(context,
              settings: 'Dark Mode',
              value: appBloc.darkMode,
              darkMode: appBloc.darkMode, action: (value) {
            setState(() {
              appBloc.darkMode = !appBloc.darkMode;
            });
          })
        ],
      ),
    );
  }
}

Widget listTile(BuildContext context,
    {String settings,
    bool value = false,
    bool darkMode = false,
    Function(bool) action}) {
  return Card(
    elevation: 0.4,
    margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.2),
    shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
    child: Container(
      height: getHeight(context, height: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${settings ?? ''}',
                    style: darkMode
                        ? textStyleDark.copyWith(fontSize: 18)
                        : textStyle.copyWith(fontSize: 18)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Align(
                alignment: Alignment.centerRight,
                child: CupertinoSwitch(value: value, onChanged: action)),
          )
        ],
      ),
    ),
  );
}
