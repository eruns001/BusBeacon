
import 'package:busbeacon_list/buttonPage.dart';
import 'package:busbeacon_list/data/busBlock.dart';
import 'package:busbeacon_list/data/data.dart';
import 'package:busbeacon_list/data/function.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scanloop();
  }
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                  ///새로고침
                  Positioned(
                    right: _mainWidth * 0.01,
                    child: IconButton(
                      icon: Icon(CupertinoIcons.arrow_counterclockwise,
                        color: const Color(0xFF000000),),
                      onPressed: (){
                        setState(() {
                          scanloop();
                        });
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


            ///버스 목록
            StreamBuilder(
              stream: flutterBlue.scanResults,//flutterBlue.startScan(),
              builder: (BuildContext context, AsyncSnapshot<List<ScanResult>> snapshot ) {

                ///목록 출력
                if(snapshot.hasData){
                  if(busList != null){
                    return Container(
                      height: _mainHeight * 0.76,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: _mainHeight * 0.02),
                              child: Text(
                                "버스 목록",
                                style: TextStyle(
                                  color: Color(0xff000000),
                                  fontFamily: "NotoSansKR",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            for(int c = 0; c<busList!.length; c++)
                              Container(
                                margin: EdgeInsets.only(top: _mainHeight * 0.02),
                                padding: EdgeInsets.only(left: _mainWidth * 0.05),
                                decoration: BoxDecoration(
                                  color: Color(0x50ffffff),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextButton(
                                  onPressed: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ButtonPage(busTile: busList![c],)),
                                    );
                                  },
                                  child: BusBlock(screenWidth: _mainWidth, screenHeight: _mainHeight, busTile: busList![c],),
                                ),
                              )
                          ],
                        ),
                      ),
                    );
                  }
                }

                ///else -ing
                return Center(
                    child: CupertinoActivityIndicator()
                );
              },
            ),


            ///현대 마크
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: _mainWidth * 0.04),
                    height: _mainHeight * 0.04,
                    child: Image.asset(
                      'images/hyundai.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
