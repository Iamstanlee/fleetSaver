import 'package:fleetdownloader/appTheme.dart';
import 'package:fleetdownloader/helper/functions.dart';
import 'package:fleetdownloader/widgets/appBar.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, 'How it works'),
      body: ListView(children: [
        Center(
            child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                    'Twitter saves fleets that you browse to a hidden folder. These fleets disappear after 24hours. Now you can save them using Fleet Saver',
                    textAlign: TextAlign.center,
                    style: textStyle.copyWith(color: Colors.grey[600])))),
        Padding(
            padding: EdgeInsets.only(),
            child: Stepper(
                steps: [
                  Step(
                    title: Text('Browse fleet images and videos on twitter',
                        style: textStyle.copyWith(color: Colors.grey[600])),
                    content: Container(
                        width: getWidth(context),
                        child: Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Container(
                              child: Image.asset(getImage('fleet.jpeg')),
                            ))),
                  ),
                  Step(
                    title: Text('Come back here to save them',
                        style: textStyle.copyWith(color: Colors.grey[600])),
                    content: Container(
                        width: getWidth(context),
                        child: Padding(
                            padding: EdgeInsets.only(), child: Container())),
                  ),
                ],
                controlsBuilder: (BuildContext context,
                    {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                  return Container();
                }))
      ]),
    );
  }
}
