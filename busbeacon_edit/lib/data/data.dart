
import 'dart:ui';
import 'package:busbeacon_edit/data/class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

BluetoothCharacteristic? resultcharacteristic;

///전역 instance
FlutterBlue flutterBlue = FlutterBlue.instance;

bool connect = false;

List<int> turnOn = [11];
List<int> turnOff = [12];
bool readOn = false;

int mainCounter = 0;

List<BusTile>? busList;
Map<ScanResult, BusTile>? busMap;

///탑승버스
BusTile? recentBus;
bool stopButtonState = false;
bool pushStopSec = true;

bool stopScan = true;

TextStyle busTextStyleNumber = TextStyle(
  color: Color(0xff000000),
  letterSpacing: -0.5,
  fontWeight: FontWeight.w300,
  fontFamily: "NotoSansKR",
  fontStyle: FontStyle.normal,
  fontSize: 24,
);
TextStyle busTextStyleNumberWhite = TextStyle(
  color: Color(0xffffffff),
  letterSpacing: -0.5,
  fontWeight: FontWeight.w300,
  fontFamily: "NotoSansKR",
  fontStyle: FontStyle.normal,
  fontSize: 24,
);

TextStyle busTextStyleType = TextStyle(
  color: Color(0xff000000),
  letterSpacing: -0.5,
  fontWeight: FontWeight.w300,
  fontFamily: "NotoSansKR",
  fontStyle: FontStyle.normal,
  fontSize: 15,
);
TextStyle busTextStyleTypeWhite = TextStyle(
  color: Color(0xffffffff),
  letterSpacing: -0.5,
  fontWeight: FontWeight.w300,
  fontFamily: "NotoSansKR",
  fontStyle: FontStyle.normal,
  fontSize: 15,
);


Color busColor = const Color(0xffeb6100);
Color beforeBusColor = const Color(0xffeb6100);
Color afterBusColor = const Color(0xff5d9023);
Color ledOfColor = const Color(0xFF838383);

///busbutton
String stateString = "탑승";

///busicon
Widget busIconAfter = Icon(
  //Icons.bus_alert,
  CupertinoIcons.bus,
  color: const Color(0xff000000),
  size: 40,
);
Widget busIconBefore = Icon(
  Icons.bus_alert,
  color: const Color(0xff000000),
  size: 40,
);
Widget busIconBeforeWhite = Icon(
  Icons.bus_alert,
  color: const Color(0xffffffff),
  size: 40,
);

///busBoxDeco
BoxDecoration busBoxDeco = BoxDecoration(
  borderRadius: BorderRadius.all(
      Radius.circular(20)
  ),
  border: Border.all(
      color: beforeBusColor, //busRideState ? afterBusColor :
      width: 1),
  color: beforeBusColor,// busRideState ? afterBusColor :
);
BoxDecoration busTranBoxDeco = BoxDecoration(
  borderRadius: BorderRadius.all(
      Radius.circular(20)
  ),
  color: const Color(0x20000000),
);


///선택버스
BusTile? busRide;
//BusTile? busNow;


///main init loop
bool initBool = true;