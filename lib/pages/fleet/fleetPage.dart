import 'package:fleetdownloader/appTheme.dart';
import 'package:fleetdownloader/bloc/appBloc.dart';
import 'package:fleetdownloader/bloc/fleetBloc.dart';
import 'package:fleetdownloader/helper/functions.dart';
import 'package:fleetdownloader/model/fleetModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FleetPage extends StatefulWidget {
  final List<Fleet> fleets;
  final int fleetIndex;
  FleetPage({this.fleets, this.fleetIndex});
  @override
  _FleetPageState createState() => _FleetPageState();
}

class _FleetPageState extends State<FleetPage>
    with SingleTickerProviderStateMixin<FleetPage> {
  TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(
        initialIndex: widget.fleetIndex,
        length: widget.fleets.length,
        vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var fleetBloc = Provider.of<FleetBloc>(context);
    var appBloc = Provider.of<AppBloc>(context);

    var fleets = widget.fleets;
    return Material(
      color: appBloc.darkMode ? Colors.black : Colors.white,
      child: Stack(
        alignment: Alignment.center,
        children: [
          TabBarView(
              controller: tabController,
              children: fleets.map((fleet) {
                return Hero(
                    tag: ObjectKey(fleet.reference),
                    child: InteractiveViewer(child: Image.file(fleet.file)));
              }).toList()),
          Positioned(
              top: 42,
              left: 22,
              child: Row(children: [
                InkWell(
                    onTap: () {
                      pop(context);
                    },
                    child: imageIcon('icon-arrowback',
                        color: appBloc.darkMode
                            ? Colors.grey[300]
                            : Colors.black)),
                Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text("${fleets[tabController.index].reference}",
                      style: appBloc.darkMode
                          ? textStyleDark.copyWith(
                              fontSize: 18, color: Colors.grey)
                          : textStyle.copyWith(fontSize: 18)),
                )
              ])),
          Positioned(
            bottom: 42,
            right: 27,
            child: InkWell(
                onTap: () {
                  fleetBloc.saveFleet(context, fleets[tabController.index]);
                },
                child: imageIcon('icon-download', color: Colors.grey)),
          )
        ],
      ),
    );
  }
}
