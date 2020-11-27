import 'dart:io';

enum FleetType { IMAGE, VIDEO }

class Fleet {
  String reference;
  FleetType type;
  FileSystemEntity file;
  Fleet({this.reference, this.file, this.type});
}
