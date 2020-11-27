import 'package:admob_flutter/admob_flutter.dart';
import 'package:fleetdownloader/appTheme.dart';
import 'package:fleetdownloader/bloc/appBloc.dart';
import 'package:fleetdownloader/bloc/fleetBloc.dart';
import 'package:fleetdownloader/helper/config.dart';
import 'package:fleetdownloader/helper/functions.dart';
import 'package:fleetdownloader/pages/about/aboutPage.dart';
import 'package:fleetdownloader/pages/fleet/fleetPage.dart';
import 'package:fleetdownloader/pages/settings/settingsPage.dart';
import 'package:fleetdownloader/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Init<HomePage> {
  AdmobInterstitial interstitialAd;

  @override
  void init(BuildContext context) {
    // load fleets from device
    if (mounted) {
      var fleetBloc = Provider.of<FleetBloc>(context, listen: false);
      fleetBloc.checkStoragePermission(context);
    }
    // load ads
    interstitialAd = AdmobInterstitial(
      adUnitId: InterstitialAdUnitID,
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
      },
    );
    interstitialAd.load();
  }

  @override
  Widget build(BuildContext context) {
    var fleetBloc = Provider.of<FleetBloc>(context);
    var appBloc = Provider.of<AppBloc>(context);

    var fleets = fleetBloc.fleets;
    return Scaffold(
      appBar: AppBar(
        title: Text('Fleet Saver',
            style: appBloc.darkMode
                ? textStyleDark.copyWith(
                    fontWeight: FontWeight.bold, fontSize: 18)
                : textStyle.copyWith(
                    fontWeight: FontWeight.bold, fontSize: 18)),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () async {
              if (await interstitialAd.isLoaded) {
                interstitialAd.show();
              }
              push(context, SettingsPage());
            },
            child: Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: imageIcon('icon-settings', size: 21)),
          ),
          GestureDetector(
            onTap: () async {
              if (await interstitialAd.isLoaded) {
                interstitialAd.show();
              }
              push(context, AboutPage());
            },
            child: Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: imageIcon('icon-help')),
          )
        ],
      ),
      body: Padding(
          padding: EdgeInsets.only(bottom: getHeight(context, height: 15)),
          child: fleets == null
              ? Center(
                  child: Text('Loading..',
                      style: appBloc.darkMode
                          ? textStyleDark.copyWith(fontSize: 18)
                          : textStyle.copyWith(fontSize: 18)))
              : fleetBloc.busy
                  ? Center(
                      child: Text('Go view some fleets and come back here.',
                          style: appBloc.darkMode
                              ? textStyleDark.copyWith(fontSize: 18)
                              : textStyle.copyWith(fontSize: 18)))
                  : GridView.count(
                      key: PageStorageKey('fleet'),
                      crossAxisCount: 3,
                      children: fleets.map((fleet) {
                        int index = fleets.indexOf(fleet);
                        return InkWell(
                            onTap: () {
                              push(context,
                                  FleetPage(fleets: fleets, fleetIndex: index));
                            },
                            child: Container(
                                margin: EdgeInsets.all(2.0),
                                child: Hero(
                                  tag: ObjectKey(fleet.reference),
                                  child: Image.file(
                                    fleet.file,
                                    fit: BoxFit.cover,
                                  ),
                                )));
                      }).toList())),
      bottomSheet: Container(
        height: getHeight(context, height: 15),
        child: Column(children: [
          Container(
            height: getHeight(context, height: 7),
            child: AdmobBanner(
                adUnitId: BannerAdUnitID, adSize: AdmobBannerSize.BANNER),
          ),
          Container(
            height: getHeight(context, height: 7),
            width: getWidth(context),
            child: Buttons.button('View Fleets on Twitter', () async {
              var url = 'https://twitter.com/';
              if (await canLaunch('$url')) launch("$url");
            }),
          )
        ]),
      ),
    );
  }
}
