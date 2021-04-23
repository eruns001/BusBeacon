import 'package:busbeacon_edit/data/class.dart';
import 'package:busbeacon_edit/data/data.dart';
import 'package:flutter_blue/flutter_blue.dart';


void bleLedOn(ScanResult resultScan) async {
  print("resultScan : ${resultScan.toString()}");
  //await resultScan.device.connect();
  await resultScan.device.connect();
  List<BluetoothService> services = await resultScan.device.discoverServices();
  services.forEach((service) {
    print("function_service : $service");
    var characteristics = service.characteristics;
    for(BluetoothCharacteristic c in characteristics) {
      //List<int> value = await c.read();
      print("BluetoothCharacteristic - $mainCounter: $c /n");
      //c.write([1]);
      resultcharacteristic = c;
      mainCounter++;
    }
  });
  await resultcharacteristic!.write(turnOn);
  await resultScan.device.disconnect();
}

void functionChangeBusNum(ScanResult resultScan, int busNum) async {
  //작
  int tempNumA = 0;
  //큰
  int tempNumB = 0;
  int command = 0;
  print("resultScan : ${resultScan.toString()}");
  //await resultScan.device.connect();
  await resultScan.device.connect();
  List<BluetoothService> services = await resultScan.device.discoverServices();
  services.forEach((service) {
    print("function_service : $service");
    var characteristics = service.characteristics;
    for(BluetoothCharacteristic c in characteristics) {
      //List<int> value = await c.read();
      print("BluetoothCharacteristic - $mainCounter: $c /n");
      //c.write([1]);
      resultcharacteristic = c;
      mainCounter++;
    }
  });

  tempNumA = busNum % 256;
  tempNumB = busNum ~/256;
  command = 3;
  print("tempNumA : $tempNumA, tempNumB : $tempNumB, command : $command");
  List<int> changeBusNum = [command, tempNumA, tempNumB];
  await resultcharacteristic!.write(changeBusNum);
  await resultScan.device.disconnect();
}

void initLoopForListpage(){
  scanloop();
  Future.delayed(const Duration(milliseconds: 5000), () {
    initLoopForListpage();
  });
}
void scanloop(){
  flutterBlue.startScan(timeout: Duration(seconds: 4));
  flutterBlue.scanResults.listen((List<ScanResult> event) {
    if(event.isNotEmpty){
      Map<ScanResult, BusTile> busResultMap = Map();
      for(ScanResult scanResult in event){
        scanResult.advertisementData.serviceData.forEach((key, value) {
          ///12 : ledoff, 15 : ledon
          if(value[0] == 12 || value[0] == 15){
            print("scanR : ${scanResult}");
            String type = (value[3] < 16) ? "시내버스" : "마을버스";
            String number = (value[1] * 256 + value[2]).toString();
            String side= (value[3] < 16) ? "- ${value[3]}" : "- ${value[3] - 16}";
            bool ledState = value[0] == 12? false : true;
            //print("ledState $ledState");
            if(value[3] == 0){
              side = "";
            }
            if(busResultMap == null){
              busResultMap = {scanResult : BusTile(type: type, number: number, side: side, conDevice: scanResult.device, scanResult: scanResult,
                  rssi: scanResult.rssi, ledState: ledState, uuid: scanResult.advertisementData.serviceUuids[0])};
            }
            else{
              busResultMap[scanResult] = BusTile(type: type, number: number, side: side, conDevice: scanResult.device, scanResult: scanResult,
                  rssi: scanResult.rssi, ledState: ledState, uuid: scanResult.advertisementData.serviceUuids[0]);
            }
          }
        });
      }

      busMap = busResultMap.cast<ScanResult, BusTile>();
      busList = busMap!.entries.map((e) => e.value).toList();
      busList!.sort();
    }
  });

  flutterBlue.stopScan();

}