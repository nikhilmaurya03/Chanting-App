import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello_world/count_provider.dart';
import 'dart:async';
import 'package:hello_world/today.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'history.dart';
import 'package:auto_scroll_text/auto_scroll_text.dart';
import 'package:flutter_android_volume_keydown/flutter_android_volume_keydown.dart';
//import 'package:buttonhandler/buttonhandler.dart';

class SuperHomeScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  
  const SuperHomeScreen({required this.toggleTheme, Key? key})
      : super(key: key);
  @override
  State<SuperHomeScreen> createState() => _SuperHomeScreenState();
}

class _SuperHomeScreenState extends State<SuperHomeScreen>

    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
     
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.5, 1)),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();

    Timer(
      Duration(seconds: 5),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(
            title: 'ISKON',
            toggleTheme: widget.toggleTheme, //showing error
          ),
        ),
      ),
    );
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Stack(
            children: [
              Center(
                child: AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Text(
                        'Hare Krishna',
                        style: TextStyle(
                          fontSize: 48,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Center(
                child: AnimatedBuilder(
                  animation: _opacityAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _opacityAnimation.value,
                      child: Text(
                        'Hare Krishna',
                        style: TextStyle(
                          fontSize: 48,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class SplashScreenState extends State<SuperHomeScreen>
//     with SingleTickerProviderStateMixin {
//   @override
//   void initState() {
//     super.initState();
//     Timer(
//         Duration(seconds: 5),
//         () => Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => MyHomePage(
//                       title: 'ISKON',
//                     ))));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.orange,
//       child: FlutterLogo(size: MediaQuery.of(context).size.height),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  final VoidCallback toggleTheme;
  const MyHomePage({super.key, required this.title, required this.toggleTheme});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  StreamSubscription<HardwareButton>? subscription;
  void startListening() {
    subscription = FlutterAndroidVolumeKeydown.stream.listen((event) {
      if (event == HardwareButton.volume_down) {
        print("Volume down received");
      } else if (event == HardwareButton.volume_up) {
        print("Volume up received");
      }
    });
  }
    void stopListening() {
    subscription?.cancel();
  }

  @override
  


  Widget build(BuildContext context) {
    final countProvider = Provider.of<CountProvider>(context, listen: false);
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    print('outside the consumer');

    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.title,
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
            )),

        //backgroundColor: Color.fromRGBO(236, 81, 64, 1),
        actions: [
          IconButton(
            icon: Icon(
              isDarkTheme ? Icons.dark_mode : Icons.dark_mode_outlined,
            ),
            onPressed: widget.toggleTheme,
          ),
          PopupMenuButton<int>(
            itemBuilder: (context) {
              return [
                PopupMenuItem<int>(value: 0, child: Text('Today')),
                PopupMenuItem<int>(value: 1, child: Text('History')),
                PopupMenuItem<int>(value: 2, child: Text('join us')),
              ];
            },
            onSelected: (value) {
              if (value == 0) {
                //print("Today is selected");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Today()),
                );
              } else if (value == 1) {
                //print("history is selected");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => History()),
                );
              } else {
                print("join us is selected");
              }
            },
          ),
        ],
      ),
      body: Container(
        // color: Color.fromARGB(136, 76, 76, 76),
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : const Color.fromARGB(136, 76, 76, 76),

        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Column(
                children: [
                  Container(
                      width: 250,
                      child: Center(
                          child: AutoScrollText(
                        //mode: AutoScrollTextMode.bouncing,
                        'Hare Krishna Hare Krishna, Krishna Krishna Hare Hare, Hare Ram Hare Ram, Ram Ram Hare Hare   ',
                        delayBefore: Duration(seconds: 2),
                        //pauseBetween: Duration(seconds: 1),
                        curve: Curves.linear,
                        velocity: Velocity(pixelsPerSecond: Offset(40, 0)),
                        style: TextStyle(fontSize: 25, color: Colors.green),
                      ))),
                ],
              ),
              Column(
                children: [
                  Container(
                      child: Center(
                          child: Text(
                    'Krishna Consiousness',
                    style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                  ))),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Container(
                        height: 120,
                        width: 120,
                        margin: EdgeInsets.fromLTRB(100, 10, 50, 05),
                        decoration: BoxDecoration(
                          color: Colors.brown[600],
                          borderRadius: BorderRadius.circular(
                              100), // More than 50% of width makes it a circle
                        ),
                        child: Center(child: Consumer<CountProvider>(
                            builder: (context, value, child) {
                          //print('inside consumer');
                          //CountDatabase.instance.deleteRecord(value.counter);
                          return Text(
                            value.counter >= 0
                                ? value.counter.toString()
                                : 'chant',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 45,
                                overflow: TextOverflow.fade,
                                color: Color.fromARGB(226, 255, 255, 255)),
                            softWrap: false,
                          );
                        })),
                      ),
                    ),
                  ),
                  Container(
                    height: 80,
                    width: 80,
                    margin: EdgeInsets.fromLTRB(0, 50, 10, 10),
                    decoration: BoxDecoration(
                      color: Colors.brown[500],
                      borderRadius: BorderRadius.circular(
                          100), // More than 50% of width makes it a circle
                    ),
                    child: Center(child: Consumer<CountProvider>(
                        builder: (context, value, child) {
                      return Text(
                        value.times >= 0 ? value.times.toString() : 'Times',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Color.fromARGB(226, 255, 255, 255)),
                      );
                    })),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      //color: Colors.amberAccent,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.amberAccent
                          : const Color.fromARGB(255, 180, 136, 5),

                      elevation: 10,
                      child: Container(
                          height: 200,
                          width: 200,
                          //color: Colors.amberAccent,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.amberAccent
                                  : const Color.fromARGB(255, 180, 136, 5),
                          margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                          child: Center(child: Consumer<CountProvider>(
                              builder: (context, value, child) {
                            return Text(
                              value.counter == value.yellowcounter
                                  ? value.counter.toString()
                                  : value.yellowcounter.toString(),
                              style: TextStyle(fontSize: 20, color: Colors.red),
                            );
                          }))),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      color: Colors.blue,
                      elevation: 10,
                      child: Container(
                        height: 200,
                        width: 200,
                        //padding: EdgeInsets.all(30),
                        margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                        color: Colors.blue,
                        child: Center(
                          child: Consumer<CountProvider>(
                              builder: (context, value, child) {
                            return Text(
                                value.counter == value.bluecounter
                                    ? value.counter.toString()
                                    : value.bluecounter.toString(),
                                style: TextStyle(
                                    fontSize: 20, color: Colors.yellow));
                          }),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Card(
                      color: Colors.green,
                      elevation: 10,
                      child: Container(
                        height: 200,
                        width: 100,
                        color: Colors.green,
                        margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                        child: Center(child: Consumer<CountProvider>(
                            builder: (context, value, child) {
                          return Text(
                              value.counter == value.greencounter
                                  ? value.counter.toString()
                                  : value.greencounter.toString(),
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black));
                        })),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Card(
                      color: Colors.redAccent,
                      elevation: 10,
                      child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.redAccent,
                        margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
                        child: Center(child: Consumer<CountProvider>(
                            builder: (context, value, child) {
                          return Text(
                              value.counter == value.redcounter
                                  ? value.counter.toString()
                                  : value.redcounter.toString(),
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white));
                        })),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 210,
                child: Card(
                  elevation: 10,
                  child: Image.asset(
                    'assets/images/krishna.jpg',
                    width: 400,
                    height: 700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          tooltip: "chant button",
          // backgroundColor: Colors.orange[700],
          child: Text('Start'),
          onPressed: () {
            HapticFeedback.lightImpact();
            countProvider.setCount();
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        //color: Color.fromRGBO(236, 81, 64, 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: IconButton(
                padding: EdgeInsets.all(10),
                icon: Icon(Icons.share),
                onPressed: () {
                  print("icon button work");
                  Share.share('com.example.hello_world');
                },
              ),
            ),
            Container(
         
              child: IconButton(
                padding: EdgeInsets.all(10),
                icon: Icon(Icons.vibration_outlined),
                onPressed: () {
                  HapticFeedback.lightImpact();
                  startListening();
                },
              ),
            ),
            Container(
     
              child: IconButton(
                padding: EdgeInsets.all(10),
                icon: Icon(Icons.link),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
