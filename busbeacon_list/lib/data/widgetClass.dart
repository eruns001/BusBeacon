
import 'package:busbeacon_list/data/class.dart';
import 'package:busbeacon_list/data/data.dart';
import 'package:flutter/material.dart';

class busbutton extends StatelessWidget{
  busbutton({
    required this.busmapIndex,
    required this.screenHeight,
    required this.screenWidth,
    this.child,
    this.rideBus,
    required this.busTextStyleNumber,
    required this.busTextStyleType,
    required this.icon,
  });
  final int busmapIndex;
  final double screenWidth;
  final double screenHeight;
  final BusTile? rideBus;
  final Widget? child;
  final TextStyle busTextStyleType;
  final TextStyle busTextStyleNumber;
  final Widget icon;
  @override
  Widget build(BuildContext context) {

    /*
    BusTile outPutBus = this.rideBus != null ?
    rideBus:
    busMap[busMap.keys.elementAt(this.busmapIndex)];

     */

    BusTile outPutBus = (this.rideBus != null ?
    rideBus:
    busList![busmapIndex])!;

    return Container(
      height: this.screenHeight,
      width: this.screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: new EdgeInsets.only(right: screenWidth * 0.03),
            child: icon,
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(outPutBus.type,
                style: busTextStyleType,),

              outPutBus.side != null ?
              Text(
                "${outPutBus.number} ${outPutBus.side} 번",
                style: busTextStyleNumber,) :
              Text("${outPutBus.number} 번",
                style: busTextStyleNumber,),
            ],
          ),
        ],),
    );
  }
}

class containerRound extends StatelessWidget{
  containerRound({
    required this.screenHeight,
    required this.screenWidth,
    required this.header,
    required this.persent,
  });
  final double screenWidth;
  final double screenHeight;
  final String header;
  final double persent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth,
      height: screenHeight,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          width: screenWidth * persent,
          height: screenHeight* persent,
        ),
      ),
    );
  }
}
