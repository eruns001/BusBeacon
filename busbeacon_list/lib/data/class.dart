
import 'package:flutter_blue/flutter_blue.dart';

///scanResult 결과값을 저장하는 class
class BusTile{
  // extends Comparable
  BusTile({
    this.type = '',
    this.number = '',
    this.side = '',
    required this.conDevice,
    required this.scanResult,
    required this.rssi,
    required this.ledState
  });
  String type;
  String number;
  String side;
  BluetoothDevice conDevice;
  ScanResult scanResult;
  int rssi;
  bool ledState = false;


  void changeLedState(){
    ledState = !ledState;
  }

  bool operator < (BusTile bt) => rssi < bt.rssi;
  bool operator > (BusTile bt) => rssi > bt.rssi;
  bool operator <= (BusTile bt) => rssi <= bt.rssi;
  bool operator >= (BusTile bt) => rssi >= bt.rssi;


}

