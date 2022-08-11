import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    MaterialApp(
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
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff888080),
      appBar: AppBar( title: Text('금연 적금 첼린지') ),
      body:
      Container(
        child: Center(
          child: Column(
            children: [
              Text("남은 개비 : 20"),
              Container(
                padding: EdgeInsets.all(50),
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            }),
            Icon(Icons.add_circle_outline),
            Icon(Icons.send)
          ],
        ),
      ) ),
    );

  }
}




class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController firstController;
  Animation<double> firstAnimation;

  AnimationController secondController;
  Animation<double> secondAnimation;

  AnimationController thirdController;
  Animation<double> thirdAnimation;

  AnimationController fourthController;
  Animation<double> fourthAnimation;

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
  const somking({Key key}) : super(key: key);

  @override
  State<somking> createState() => _somkingState();
}

class _somkingState extends State<somking> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
