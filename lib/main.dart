import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _rotationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 60));

    _rotationAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
        CurvedAnimation(
            parent: _rotationController, curve: Curves.bounceInOut));
    _rotationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: Center(
          child: Stack(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedBuilder(
                  animation: _rotationAnimation,
                  builder: (context, child) {
                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..rotateZ(2 * pi * _rotationAnimation.value),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          DottedBorder(
                            borderType: BorderType.Circle,
                            //radius: const Radius.circular(10),
                            color: Colors.white,
                            dashPattern: const [10, 4],
                            strokeCap: StrokeCap.round,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 160,
                                width: 160,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.cyan, width: 5),
                                ),
                              ),
                            ),
                          ),
                          for (int i = 0; i < 6; i++)
                            Positioned(
                                left: 160 / 2,
                                top: 160 / 2,
                                child: MyContainerWidget(
                                  no: i,
                                  radius: 80,
                                )),
                        ],
                      ),
                    );
                  }),
              AnimatedBuilder(
                  animation: _rotationAnimation,
                  builder: (context, child) {
                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..rotateZ(-2 * pi * _rotationAnimation.value),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          DottedBorder(
                            borderType: BorderType.Circle,
                            //radius: const Radius.circular(10),
                            color: Colors.white,
                            dashPattern: const [10, 4],
                            strokeCap: StrokeCap.round,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 160,
                                width: 160,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.cyan, width: 5),
                                ),
                                // child: Center(
                                //   child: Text(
                                //     '25',
                                //     style: TextStyle(fontSize: 50),
                                //   ),
                                // ),
                              ),
                            ),
                          ),
                          for (int i = 0; i < 6; i++)
                            Positioned(
                                left: 160 / 2,
                                top: 160 / 2,
                                child: MyContainerWidget(
                                  no: i,
                                  radius: 80,
                                )),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class MyContainerWidget extends StatefulWidget {
  final int no;
  final double radius;
  const MyContainerWidget({super.key, required this.no, required this.radius});

  @override
  State<MyContainerWidget> createState() => _MyContainerWidgetState();
}

class _MyContainerWidgetState extends State<MyContainerWidget>
    with TickerProviderStateMixin {
  late AnimationController _heightController;
  late Animation<double> _heightAnimation;
  late Animation<double> _widthAnimation;
  final rand = Random();
  // late Color color1;
  // late Color color2;
  // late Color color3;
  // late Color color4;
  // late Color color5;
  // late Color color6;
  late int colorIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _heightController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: Random().nextInt(1000) + 300));

    _heightAnimation = Tween<double>(begin: 0, end: 80).animate(
        CurvedAnimation(parent: _heightController, curve: Curves.easeIn));
    _widthAnimation = Tween<double>(begin: 0, end: 7).animate(
        CurvedAnimation(parent: _heightController, curve: Curves.bounceInOut));
    colorIndex = rand.nextInt(3);

    // color1 = Color(rand.nextInt(0xffffffff));
    // color2 = Color(rand.nextInt(0xffffffff));
    // color3 = Color(rand.nextInt(0xffffffff));
    // color4 = Color(rand.nextInt(0xffffffff));
    // color5 = Color(rand.nextInt(0xffffffff));
    // color6 = Color(rand.nextInt(0xffffffff));
    _heightController.repeat(reverse: true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _heightController.dispose();
    super.dispose();
  }

  double randValue = Random().nextDouble() * 40 + 10;
  double randWidth = Random().nextDouble() * 8 + 1;

  final List<Color> _colors = [
    Colors.deepOrange,
    Colors.cyan,
    Colors.purple,
  ];
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _heightAnimation,
        builder: (context, child) {
          double height = _heightAnimation.value + randValue;
          double width = _widthAnimation.value + randWidth;
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..translate(Vector3(-width / 2, -height / 2, 0))
              ..rotateZ(2 * pi * (widget.no / 6))
              ..translate(Vector3(0.0, widget.radius + height / 2, 0.0))
              ..rotateY(-pi / 4)
              ..rotateX(pi / 8),
            child: Stack(
              children: [
                //back
                Transform(
                  transform: Matrix4.identity()
                    ..translate(Vector3(0, 0, -width)),
                  alignment: Alignment.center,
                  child: Container(
                    height: height,
                    width: width,
                    color: Colors.red,
                  ),
                ),
                // left
                Transform(
                  transform: Matrix4.identity()..rotateY(pi / 2),
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: height,
                    width: width,
                    color: Colors.green,
                  ),
                ),
                // //right
                Transform(
                  transform: Matrix4.identity()..rotateY(-(pi / 2)),
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: height,
                    width: width,
                    color: _colors[colorIndex],
                  ),
                ),
                // //top
                Transform(
                  transform: Matrix4.identity()..rotateX(-(pi / 2)),
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: width,
                    width: width,
                    color: _colors[colorIndex],
                  ),
                ),
                // //bottom
                Transform(
                  transform: Matrix4.identity()
                    ..translate(Vector3(0, height - width, 0))
                    ..rotateX(pi / 2),
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: width,
                    width: width,
                    color: Colors.deepPurple,
                  ),
                ),
                //front
                Container(
                  height: height,
                  width: width,
                  color: _colors[colorIndex],
                ),
              ],
            ),
          );
        });
  }
}
