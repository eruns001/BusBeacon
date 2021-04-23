
import 'package:busbeacon_edit/data/busBlock.dart';
import 'package:busbeacon_edit/data/class.dart';
import 'package:busbeacon_edit/data/data.dart';
import 'package:busbeacon_edit/data/edited_animationed_button.dart';
import 'package:busbeacon_edit/data/function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  ///이름
  TextEditingController _numberController = new TextEditingController();

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
              child: BusBlock(
                busTile: widget.busTile,
                screenWidth: _mainWidth,
                screenHeight: _mainHeight,
              ),
            ),

            Container(
              height: _mainHeight * 0.08,
              width: _mainWidth * 0.725,
              child: TextField(
                controller: _numberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  counterText: '',
                  contentPadding: EdgeInsets.only(top: _mainHeight * 0.02, bottom: _mainHeight * 0.02, left: _mainWidth * 0.05),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            ///하차 버튼
            Container(
              child: AnimatedButton(
                height: _mainHeight * 0.2,  		// Button Height, default is 64
                width: _mainWidth * 0.6,
                child:Text(
                  '수 정',
                  style: TextStyle(
                    fontSize: 38,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () {
                  if(_numberController.text.length == 0){
                    Fluttertoast.showToast(
                        msg: "숫자를 입력해주세요",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }
                  else if(pushStopSec) {
                    functionChangeBusNum(widget.busTile.scanResult, int.parse(_numberController.text));
                    pushStopSec = false;
                    Future.delayed(const Duration(milliseconds: 2000), () {
                      pushStopSec = true;
                    });
                    Navigator.pop(context);
                  }
                },
              ),
            )

          ],
        ),
      ),
    );
  }
}