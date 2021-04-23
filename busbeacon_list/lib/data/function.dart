
import 'package:busbeacon_list/data/class.dart';
import 'package:busbeacon_list/data/data.dart';
import 'package:flutter_blue/flutter_blue.dart';



///블루투스에 Led 켜는 신호 전달
///[1] LedOn
///[2] LedOff
///[3, n, m] Change Number to n + m*256

void bleLedOn(ScanResult resultScan) async {
  print("resultScan : ${resultScan.toString()}");
  //await resultScan.device.connect();
  await resultScan.device.connect();
  List<BluetoothService> services = await resultScan.device.discoverServices();
  services.forEach((service) {
    print("function_service : $service");
    var characteristics = service.characteristics;
    int mainCounter = 0;
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

///브로드케스팅중인 데이터를 수집, 정리, 저장
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
                  rssi: scanResult.rssi, ledState: ledState)};
            }
            else{
              busResultMap[scanResult] = BusTile(type: type, number: number, side: side, conDevice: scanResult.device, scanResult: scanResult,
                  rssi: scanResult.rssi, ledState: ledState);
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