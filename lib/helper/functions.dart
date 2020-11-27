import 'dart:math' show Random;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:developer' show log;

/// log to console
void logg(Object value, [String name = 'logger']) {
  log("$value", name: ' $name ');
}

/// return a random a from range 0 to [max] params
int getRandomInt(int max) {
  return new Random().nextInt(max);
}

/// returns a random string of characters
String getReference({int limit = 16}) {
  String reference = '';
  DateTime dateTime = new DateTime.now();
  for (var i = 0; i < limit; i++) {
    reference += getRandomInt(limit).toString();
  }
  return "${dateTime.microsecond}-$reference";
}

mixin Init<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => init(context));
  }

  void init(BuildContext context);
}

/// takes a percentage of the screens width and return a double of current width
double getWidth(context, {width}) {
  if (width == null) return MediaQuery.of(context).size.width;
  return ((width / 100) * MediaQuery.of(context).size.width);
}

/// takes a percentage of the screens height and return a double of screen height.
double getHeight(context, {height}) {
  if (height == null) return MediaQuery.of(context).size.height;
  return ((height / 100) * MediaQuery.of(context).size.height);
}

String getPngIcon(String icon) {
  return 'assets/res/icons/$icon.png';
}

String getImage(String img) {
  return 'assets/res/$img';
}

String getPng(String img) {
  return 'assets/res/$img.png';
}

ImageIcon imageIcon(String name, {double size, Color color}) {
  return ImageIcon(AssetImage(getPngIcon(name)), size: size, color: color);
}

/// Navigate to a new route by passing a route widget
Future<dynamic> push(
  context,
  Widget widget,
) async {
  return Navigator.push(
      context, MaterialPageRoute(builder: (context) => widget));
}

/// replace the current widget with a new route by passing a route widget
void replace(context, Widget widget, {dynamic args}) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}

/// replace the current widget with a new route by passing a route widget
void pushAndDisposePreviousRoutes(context, Widget widget, {dynamic args}) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => widget), (_) => _.isFirst);
}

/// go back to the previous route, takes an optional [result] params
/// which is returned from the route
void pop(context, {dynamic result}) {
  Navigator.of(context).pop(result);
}

void showDraggableBottomSheet(BuildContext context, {@required Widget child}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    backgroundColor: Colors.transparent,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 1.0,
      minChildSize: 0.6,
      maxChildSize: 1.0,
      builder: (context, scrollController) {
        return Container(
          color: Colors.white,
          child: SingleChildScrollView(
            controller: scrollController,
            child: child,
          ),
        );
      },
    ),
  );
}
