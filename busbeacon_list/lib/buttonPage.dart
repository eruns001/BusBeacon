
import 'package:busbeacon_list/data/busBlock.dart';
import 'package:busbeacon_list/data/class.dart';
import 'package:busbeacon_list/data/data.dart';
import 'package:busbeacon_list/data/edited_animationed_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'data/function.dart';

class ButtonPage extends StatefulWidget {
  final BusTile busTile;

  const ButtonPage({
    Key? key,
    required this.busTile
  });

  @override
  _ButtonPage createState() => _ButtonPage();
}
class _ButtonPage extends State<ButtonPage>{
  @override
  Widget build(BuildContext context) {
    double _mainWidth = MediaQuery.of(context).size.width;
    double _mainHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("images/busMainBackGround.png"),
              fit: BoxFit.fill,
            )
        ),
        child: Column(
          children: [
            ///헤더
            Container(
              decoration: BoxDecoration(
                color: Color(0x50090074),
              ),
              width: _mainWidth,
              height: _mainHeight * 0.08,
              margin: EdgeInsets.only(top: _mainHeight * 0.048),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ///뒤로가기
                  Positioned(
                    left: _mainWidth * 0.01,
                    child: IconButton(
                      icon: Icon(CupertinoIcons.arrow_left,
                        color: const Color(0xFF000000),),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                  ),

                  ///기사님 저 내려요
                  Positioned(
                    child: Container(
                      child : Text(
                        "기사님 저 내려요",
                        style: TextStyle(
                          color: const Color(0xffffffff),
                          fontFamily: "NotoSansKR",
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            ///탑승 버스
            Container(
              margin: EdgeInsets.only(top: _mainHeight * 0.02),
              padding: EdgeInsets.only(left: _mainWidth * 0.05),
              decoration: BoxDecoration(
                color: Color(0x1effffff),
                borderRadius: BorderRadius.circular(20),
              ),
              child: BusBlock(
                busTile: widget.busTile,
                screenWidth: _mainWidth,
                screenHeight: _mainHeight,
              ),
            ),

            ///하차 버튼
            Container(
              margin: EdgeInsets.only(top: _mainHeight * 0.02),
              child: AnimatedButton(
                height: _mainHeight * 0.2,  		// Button Height, default is 64
                width: _mainWidth * 0.6,
                child:Text(
                  '하 차',
                  style: TextStyle(
                    fontSize: 38,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () {
                  if(pushStopSec) {
                    bleLedOn(widget.busTile.scanResult);
                    pushStopSec = false;
                    Future.delayed(const Duration(milliseconds: 2000), () {
                      pushStopSec = true;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}