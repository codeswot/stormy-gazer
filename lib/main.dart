import 'package:flutter/material.dart';
import 'package:stormgaze01/screens/loading_screen.dart';

void main() => runApp(MyApp());
const String testDevice = '6F421817C7DCB6C6CF3BFAA4344BC165';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: LoadingScreen(),
    );
  }
}
