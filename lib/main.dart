import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blue,
          accentColor: Colors.orange
      ),
      home: Home(),
      title: "Water-Animation",
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
}



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

int cigarette_count = 0;
int add_count = 0;
int add_count2 = 0;
int money_count = 1000000;

saveData() async {
  var storage = await SharedPreferences.getInstance();
  cigarette_count = storage.getInt('cigarette')!;
  if( storage.getInt('save_money') == null){
    add_count = 0;
  }
  else{
    add_count = storage.getInt('save_money')!;
    money_count = 1000000 - add_count;
    if(money_count < 0){
      storage.setInt('save_money',0);
    }
  }
}

setData(int num) async {
  var storage = await SharedPreferences.getInstance();
  storage.setInt('cigarette', num);
}


setSave() async {
  var storage = await SharedPreferences.getInstance();
  if( storage.getInt('save_money') == null){
    storage.setInt('save_money',4500);
  }
  else{
    add_count = storage.getInt('save_money')!;
    int n = storage.getInt('save_money')!;
    storage.setInt('save_money',n + 4500);
  }

}




class _HomeState extends State<Home> {
  @override
  void initState(){  // 앱 로드 될때 바로 GET 하고 싶음 그럼 이렇게
    super.initState();
    saveData();

    banner = BannerAd(size: AdSize.banner, adUnitId: androidTestUnitId , listener: BannerAdListener() , request: AdRequest())..load();
  }

  final String androidTestUnitId = "ca-app-pub-3940256099942544/6300978111";
  BannerAd? banner;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Color(0xff888080),
      appBar: AppBar( title: Text('금연해서 100만 원 모으기 첼린지') , backgroundColor: Color(0xff888080), ),
      body:
      Container(
        child: Center(
          child: Column(
            children: [
              Text('남은개비 : $cigarette_count',  style: TextStyle(fontSize: 41,  color: Color(
                  0xff131313) ),
              ),
              Container(
                padding: EdgeInsets.all(30),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        width: 60,
                        height: 300,
                        child: ColoredBox(
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                      SizedBox(
                        width: 60,
                        height: 150,
                        child: ColoredBox(
                          color: Color(0xffd27c18),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(26.0)),
                      Container(
                        height: 40.0,
                        child: banner == null ? Container() : AdWidget(
                          ad : banner!,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomAppBar( child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(icon: Icon(Icons.smoking_rooms), onPressed: (){
              if(cigarette_count > 0)
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                setState(() { //setState : 호출하면 ui를 변경하겠다라는 것
                  cigarette_count = cigarette_count - 1;
                  setData(cigarette_count);
                });
              }
              else{
                Navigator.push(context, MaterialPageRoute(builder: (context) => Save()));
              }
            }),

            IconButton(icon: Icon(Icons.add_circle_outline), onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Save()));

            })

          ],
        ),
      ) ),
    );

  }
}


class Save extends StatefulWidget {
  const Save({Key? key }) : super(key: key);
  @override
  State<Save> createState() => _SaveState();
}

class _SaveState extends State<Save> {

  // 브라우저를 열 링크
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text('금연해서 100만 원 모으기 첼린지') , backgroundColor: Color(0xff888080), ),
      body:
      Container(
        width: 800,
        height: 800,
        color: Color(0xff888080),
        child: Column(
          children: [

            Padding(
              padding: const  EdgeInsets.fromLTRB(15, 50, 0, 15),
              child: Row(
                children: [
                  Container(
                      height: 100,
                      width: 180,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                            spreadRadius: 3.0,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text('목표액수 까지 ',style: TextStyle(fontSize: 20)),
                          Text('$money_count 원',style: TextStyle(fontSize: 20)),
                        ],
                      )

                  ),
                  Container(
                      height: 100,
                      width: 180,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Color(0xff18d728),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                            spreadRadius: 3.0,
                          ),
                        ],
                      ),
                      child:
                      Column(
                        children: [
                          Text('저금액수 ',style: TextStyle(fontSize: 20)),
                          Text('$add_count 원',style: TextStyle(fontSize: 20)),
                        ],
                      )
                  ),
                ],
              ),
            ),

            Padding(
            padding: const  EdgeInsets.fromLTRB(10, 40, 0, 10),
            child:
            ElevatedButton.icon( onPressed: () async {
              // 브라우저를 열 링크
              const url = 'https://www.kakaopay.com/';
              // 외부 브라우저 실행
              await launch(url, forceWebView: false, forceSafariVC: false);

              showDialog(
                barrierDismissible: false, //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
                context: context,
                builder: (context){
                  return Dialog(
                    child: Container(
                      height: 400, width: 330,
                      //padding: EdgeInsets.all(10),

                      child: Column(
                        crossAxisAlignment:CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(30),
                            child: Text("양심적으로 4500원 본인 적금 계좌에 입금 하고 오세요 100만원 금방입니다 ",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(30, 10, 0, 5),
                            child:
                            Text("진짜 입금 하셨습니까?",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const  EdgeInsets.fromLTRB(30, 0, 0, 30),
                            child: Container(
                              //padding: EdgeInsets.fromLTRB(100, 0, 0, 30),

                              height:1.0,
                              width:270.0,
                              color:Colors.black12,),
                          ),
                          Container(
                            padding: const  EdgeInsets.fromLTRB(30, 0, 20, 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(onPressed: (){
                                  Navigator.pop(context); //열려있는 Dialog를 닫는 부분입니다.
                                }, child: Text("Cansel")),

                                TextButton(onPressed: (){
                                  Navigator.pop(context); // 열려있는 Dialog를 닫는 부분입니다.
                                  setState(() { //setState : 호출하면 ui를 변경하겠다라는 것
                                    cigarette_count = 20;
                                    setData(cigarette_count);
                                    setSave();
                                    saveData();
                                  });
                                }, child: Text("OK")),
                              ],
                            ),
                          ),
                        ],

                      ),
                    ),
                  );
                },
              );
            },
              style: ElevatedButton.styleFrom(
                primary: Color(0xffeac529),
                shape: RoundedRectangleBorder(
                  // shape : 버튼의 모양을 디자인 하는 기능

                    borderRadius: BorderRadius.circular(10.0)
                ),
              ),
              icon: Icon(Icons.savings, size: 50), label: Text("카카오페이 바로가기", style: TextStyle(
                  color: Colors.black,
                  letterSpacing: 2.0,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold),),
            ),
            ),
          ],
        ),
      ),
    );
  }
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController firstController;
  late Animation<double> firstAnimation;

  late AnimationController secondController;
  late Animation<double> secondAnimation;

  late AnimationController thirdController;
  late Animation<double> thirdAnimation;

  late AnimationController fourthController;
  late Animation<double> fourthAnimation;

  @override
  void initState() {
    super.initState();

    firstController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    firstAnimation = Tween<double>(begin: 1.9, end: 2.1).animate(
        CurvedAnimation(parent: firstController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          firstController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          firstController.forward();
        }
      });

    secondController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    secondAnimation = Tween<double>(begin: 1.8, end: 2.4).animate(
        CurvedAnimation(parent: secondController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          secondController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          secondController.forward();
        }
      });

    thirdController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    thirdAnimation = Tween<double>(begin: 1.8, end: 2.4).animate(
        CurvedAnimation(parent: thirdController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          thirdController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          thirdController.forward();
        }
      });

    fourthController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    fourthAnimation = Tween<double>(begin: 1.9, end: 2.1).animate(
        CurvedAnimation(parent: fourthController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          fourthController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          fourthController.forward();
        }
      });


    Timer(Duration(seconds: 2), () {
      firstController.forward();
    });

    Timer(Duration(milliseconds: 1600), () {
      secondController.forward();
    });

    Timer(Duration(milliseconds: 800), () {
      thirdController.forward();
    });

    fourthController.forward();

  }

  @override
  void dispose() {
    firstController.dispose();
    secondController.dispose();
    thirdController.dispose();
    fourthController.dispose();
    super.dispose();
  }
  int counter=0;
  double counter2=300.0;
  var tab = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;




    return Scaffold(
      floatingActionButton: Align(
          alignment: Alignment.centerRight,
          child:
          FloatingActionButton(
            backgroundColor: Color(0xffb71725),
            onPressed: (){
              setState(() {//setState : 호출하면 ui를 변경하겠다라는 것
                counter = counter + 10;//_counter값 하나씩 증가
                counter2 = counter2 - 25.0;
                if (counter2 <= 50.0){
                  counter2 = 300.0;
                  Navigator.pop(context);
                }
              });
            },
            child: Icon(Icons.fingerprint),
          )
      ),
      backgroundColor: Color(0xffe1d4d4),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(100),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    width: 60,
                    height: 10,
                    child: ColoredBox(
                      color: Color(0xffdc1717),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    height: counter2,
                    child: ColoredBox(
                      color: Color(0xffFFFFFF),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    height: 150,
                    child: ColoredBox(
                      color: Color(0xffd27c18),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Text('$counter%',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    wordSpacing: 3,
                    color: Colors.black.withOpacity(.7)),
                textScaleFactor: 7),
          ),
          CustomPaint(
            painter: MyPainter(
              firstAnimation.value,
              secondAnimation.value,
              thirdAnimation.value,
              fourthAnimation.value,
            ),
            child: SizedBox(
              height: size.height,
              width: size.width,
            ),
          ),
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double firstValue;
  final double secondValue;
  final double thirdValue;
  final double fourthValue;

  MyPainter(
      this.firstValue,
      this.secondValue,
      this.thirdValue,
      this.fourthValue,
      );

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Color(0xff989292).withOpacity(.8)
      ..style = PaintingStyle.fill;

    var path = Path()
      ..moveTo(0, size.height / firstValue)
      ..cubicTo(size.width * .4, size.height / secondValue, size.width * .7,
          size.height / thirdValue, size.width, size.height / fourthValue)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class somking extends StatefulWidget {
  const somking({Key? key}) : super(key: key);

  @override
  State<somking> createState() => _somkingState();
}

class _somkingState extends State<somking> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}



