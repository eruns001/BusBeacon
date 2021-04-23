
import 'package:busbeacon_list/data/class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///버스목록의 블럭

class BusBlock  extends StatefulWidget {
  final BusTile busTile;
  final double screenWidth;
  final double screenHeight;
  final Color color;

  const BusBlock({
    Key? key,
    required this.busTile,
    required this.screenWidth,
    required this.screenHeight,
    this.color = const Color(0xff000000),
  });

  @override
  _BusBlockState createState() => _BusBlockState();
}

class _BusBlockState extends State<BusBlock>{
  @override
  Widget build(BuildContext context) {

    return Container(
      height: widget.screenHeight * 0.08,
      width: widget.screenWidth * 0.8,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ///버스 아이콘
          Container(
            child: Icon(
              Icons.bus_alert,
              color: widget.color,
              size: 40,
            ),
          ),
          ///버스 정보
          Container(
            margin: EdgeInsets.only(left: widget.screenWidth * 0.2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                      widget.busTile.type,
                    style: TextStyle(
                      color: Color(0xff000000),
                      fontFamily: "NotoSansKR",
                      fontStyle: FontStyle.normal,
                      fontSize: 12,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "${widget.busTile.number} 번",
                    style: TextStyle(
                      color: Color(0xff000000),
                      fontFamily: "NotoSansKR",
                      fontStyle: FontStyle.normal,
                      fontSize: 28,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

}