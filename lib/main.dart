import 'package:admob_flutter/admob_flutter.dart';
import 'package:fleetdownloader/bloc/appBloc.dart';
import 'package:fleetdownloader/bloc/fleetBloc.dart';
import 'package:fleetdownloader/pages/home/homePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize();
  runApp(MyApp());
}

// TODO: download video
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppBloc>(create: (context) => AppBloc()),
        ChangeNotifierProvider<FleetBloc>(create: (context) => FleetBloc()),
      ],
      child: Consumer<AppBloc>(
        builder: (BuildContext context, value, Widget child) {
          return MaterialApp(
            title: 'Fleet Saver',
            debugShowCheckedModeBanner: false,
            theme: value.theme,
            home: HomePage(),
          );
        },
      ),
    );
  }
}
