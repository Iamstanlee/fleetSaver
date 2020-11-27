import 'package:fleetdownloader/appTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Toast {
  static void show(BuildContext context, String msg,
      {int duration = 3,
      int gravity = 0,
      bool isTimed = true,
      Color color = const Color(0xAA000000)}) {
    ToastView.dismiss();
    ToastView.createView(msg, context, isTimed, duration, gravity, color);
  }

  static void dismiss() {
    ToastView.dismiss();
  }
}

class ToastView {
  static final ToastView _singleton = new ToastView._internal();

  factory ToastView() {
    return _singleton;
  }

  ToastView._internal();

  static OverlayState overlayState;
  static OverlayEntry _overlayEntry;
  static bool _isVisible = false;
  static dismiss() async {
    if (!_isVisible) {
      return;
    }
    _isVisible = false;
    _overlayEntry?.remove();
  }

  static void createView(String msg, BuildContext context, bool isTimed,
      int duration, int gravity, Color background) async {
    overlayState = Overlay.of(context);

    Paint paint = Paint();
    paint.strokeCap = StrokeCap.square;

    _overlayEntry = new OverlayEntry(
      builder: (BuildContext context) => ToastWidget(
          widget: Container(
            width: MediaQuery.of(context).size.width,
            child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: background,
                    borderRadius: BorderRadius.zero,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.fromLTRB(12, 4, 12, 4),
                  child: Text(msg,
                      softWrap: true,
                      style: textStyle.copyWith(color: Colors.white)),
                )),
          ),
          gravity: gravity),
    );
    _isVisible = true;
    overlayState.insert(_overlayEntry);
    await new Future.delayed(Duration(seconds: duration));
    if (isTimed) dismiss();
  }
}

class ToastWidget extends StatelessWidget {
  ToastWidget({
    Key key,
    @required this.widget,
    @required this.gravity,
  }) : super(key: key);

  final Widget widget;
  final int gravity;

  @override
  Widget build(BuildContext context) {
    return new Positioned(
        top: gravity == 2 ? 50 : null,
        bottom: gravity == 0 ? 80 : null,
        child: Material(
          color: Colors.transparent,
          child: widget,
        ));
  }
}
