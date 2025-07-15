import 'dart:async';
import 'package:auto_scroll_text/auto_scroll_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_android_volume_keydown/flutter_android_volume_keydown.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hello_world/count_provider.dart';
import 'package:hello_world/history.dart';
import 'package:hello_world/today.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class MyWidget extends StatefulWidget {
  final VoidCallback toggleTheme;
  const MyWidget({super.key, required this.toggleTheme});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  var date = DateTime.now();
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: isDarkTheme ? Colors.grey[900] : Colors.white,
        appBar: AppBar(
          backgroundColor: isDarkTheme ? Colors.grey[900] : Colors.white,
          foregroundColor: Colors.blue[300],
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: IconButton(
                onPressed: () {
                countProvider.resetCount();
                },
                icon: Icon(Icons.refresh, color: Colors.blue[300]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: IconButton(
                onPressed: widget.toggleTheme,
                icon: Icon(
                    isDarkTheme ? Icons.dark_mode : Icons.dark_mode_outlined,
                    color: Colors.blue[300]),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: IconButton(
            //         onPressed: () {},
            //         icon: Icon(
            //           Icons.list_alt,
            //           color: Colors.blue[300],
            //         ),
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: IconButton(
            //         onPressed: () {},
            //         icon: Icon(
            //           Icons.refresh,
            //           color: Colors.blue.shade300,
            //         ),
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: IconButton(
            //         onPressed: () {},
            //         icon: Icon(
            //           Icons.dark_mode,
            //           color: Colors.blue[300],
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(
              height: 20,
            ),
            Container(
                width: 250,
                decoration: BoxDecoration(
                    border: isDarkTheme
                        ? Border.all(color: Colors.grey.shade900, width: 0)
                        : Border.all(color: Colors.blue.shade300, width: 2),
                    borderRadius: isDarkTheme
                        ? BorderRadius.circular(0)
                        : BorderRadius.circular(20)),
                child: Center(
                    child: AutoScrollText(
                  //mode: AutoScrollTextMode.bouncing,
                  selectable: true,
                  // pauseBetween: Duration(milliseconds: 1000),
                  'Hare Krishna Hare Krishna, Krishna Krishna Hare Hare, Hare Ram Hare Ram, Ram Ram Hare Hare   ',
                  delayBefore: Duration(seconds: 2),
                  //pauseBetween: Duration(seconds: 1),
                  curve: Curves.linear,
                  velocity: Velocity(pixelsPerSecond: Offset(40, 0)),
                  style: TextStyle(fontSize: 25, color: Colors.green),
                ))),
            SizedBox(
              height: 20,
            ),
            Consumer<CountProvider>(
              builder: (context, value, child) {
                return Text(
                  value.counter.toString(), //counter
                  style: TextStyle(
                      fontSize: 68,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[200]),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              DateTime.now().toIso8601String().split('T').first,
              style: TextStyle(fontSize: 16, color: Colors.amber),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: isDarkTheme ? Colors.grey[900] : Colors.grey[100],
                  shadowColor: Colors.blue[300],
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 2, color: Colors.blue.shade300),
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Consumer<CountProvider>(
                        builder: (context, value, child) {
                          return Text(
                            value.times.toString(),
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                Card(
                  color: isDarkTheme ? Colors.grey[900] : Colors.grey[100],
                  shadowColor: Colors.blue[300],
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(width: 2, color: Colors.blue.shade300),
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    height: 60,
                    width: 160,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(width: 2, color: Colors.blue.shade300)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: IconButton(
                            onPressed: () {
                              HapticFeedback.lightImpact();
                              countProvider.decrementCount();
                            },
                            icon: Icon(
                              Icons.horizontal_rule,
                              size: 28,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            onPressed: () {
                            },
                            icon: Icon(
                              Icons.add,
                              size: 28,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 80,
            ),

            // counter button

            Card(
              color: Colors.grey[900],
              shadowColor: isDarkTheme ? Colors.amber : Colors.white70,
              elevation: 10,
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 2, color: Colors.amber),
                  borderRadius: BorderRadius.circular(100)),
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.blue[200]),
                child: FloatingActionButton(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    countProvider.setCount();
                  },
                  backgroundColor: Colors.blue[800],
                  disabledElevation: 1,
                  //  shape: Border.all(width: 2.5, color: Colors.amber, ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                      side: isDarkTheme
                          ? BorderSide(width: 2, color: Colors.amber)
                          : BorderSide.none),
                ),
              ),
            )
          ],
        ),
        drawer: Drawer(
          backgroundColor: Colors.grey[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Center(
                  child: Text(
                    "Drawer Header",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text(
                  "Todays",
                  style: TextStyle(color: Colors.amber),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Today()));
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                  "History",
                  style: TextStyle(color: Colors.amber),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => History()));
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                  "Share",
                  style: TextStyle(color: Colors.amber),
                ),
                onTap: () {
                  Share.share('com.example.hello_world');
                },
              ),
              Divider(),
              ListTile(
                title: Text(
                  "Join Us",
                  style: TextStyle(color: Colors.amber),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
