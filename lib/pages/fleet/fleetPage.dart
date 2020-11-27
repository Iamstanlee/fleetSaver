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

class _FleetPageState extends State<FleetPage> {
  int index;
  @override
  void initState() {
    super.initState();
    index = widget.fleetIndex;
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
          Hero(
              tag: ObjectKey(fleets[index].reference),
              child: GestureDetector(
                  onHorizontalDragEnd: (drag) {
                    if (drag.primaryVelocity > 0) {
                      setState(() {
                        if (index != 0) index--;
                      });
                    } else if (drag.primaryVelocity < 0) {
                      setState(() {
                        if (index != fleets.length) index++;
                      });
                    }
                  },
                  child: InteractiveViewer(
                      child: Image.file(fleets[index].file)))),
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
                  child: Text("${fleets[index].reference}",
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
                  fleetBloc.saveFleet(context, fleets[index]);
                },
                child: imageIcon('icon-download', color: Colors.grey)),
          )
        ],
      ),
    );
  }
}
