import 'dart:io';
import 'package:fleetdownloader/bloc/appBloc.dart';
import 'package:fleetdownloader/helper/functions.dart';
import 'package:fleetdownloader/model/fleetModel.dart';
import 'package:fleetdownloader/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FleetBloc extends AppBloc {
  List<Fleet> _fleets;
  List<Fleet> get fleets => _fleets;
  set fleets(List<Fleet> value) {
    this._fleets = value;
    notifyListeners();
  }

  void loadFleets() async {
    busy = true;
    var directory = await getExternalStorageDirectory();
    var temp = <FileSystemEntity>[];
    var tempFleets = <Fleet>[];

    /// make reference to twitters app directory
    var twitterDir = Directory(
        "${directory.parent.parent.path}/com.twitter.android/cache/image_cache");
    twitterDir.list(recursive: true).listen((fileSystem) async {
      /// get all files with .cnt extension
      if (fileSystem.path.endsWith('.cnt')) {
        File image = new File(fileSystem.path);
        var decodedImage = await decodeImageFromList(image.readAsBytesSync());
        if (decodedImage.height > 300) {
          temp.add(fileSystem);
          tempFleets.add(
              new Fleet(file: fileSystem, reference: "${getReference()}.jpg"));
        }
      }
    }).onDone(() {
      fleets = tempFleets;
      busy = false;
    });
  }

  /// save fleet to user device
  void saveFleet(BuildContext context, Fleet fleet) async {
    var directory = await getExternalStorageDirectory();
    // path to save the image
    var saveDir =
        Directory("${directory.parent.parent.parent.parent.path}/FleetSaver");
    await saveDir.create();
    var savePath = "${saveDir.path}/${fleet.reference}";
    File file = fleet.file;
    await file.copy(savePath);
    Toast.show(context, 'Saved successfully');
  }

  /// ensure the user has given permission needed to access phone storage
  void checkStoragePermission(BuildContext context) async {
    if (await Permission.storage.isPermanentlyDenied) {
      Toast.show(context, 'Permission required to access phone storage',
          gravity: 2);
      Future.delayed(Duration(seconds: 2), () {
        openAppSettings();
      });
    } else if (await Permission.storage.request().isGranted) {
      loadFleets();
    } else if (await Permission.storage.request().isDenied) {
      busy = false;
      Toast.show(context, 'Permission required to access phone storage',
          gravity: 2);
      checkStoragePermission(context);
    } else {
      await Permission.storage.request();
      Toast.show(context, 'Permission required to access phone storage',
          gravity: 2);
      checkStoragePermission(context);
    }
  }
}
