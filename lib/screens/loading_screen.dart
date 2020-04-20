import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stormgaze01/screens/location_screen.dart';
import 'package:stormgaze01/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  String developer = 'Mubarak Ibrahim';
  void getLocationData() async {
    var weatherData = await WeatherModel().getLocationWeather();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                LocationScreen(locationWeather: weatherData)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Stack(
        children: <Widget>[
          SpinKitDoubleBounce(
            color: Colors.white,
            size: 100.0,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 15.0),
              child: Text(
                'Developed by $developer',
                style: TextStyle(
                    fontFamily: 'SourceCodePro', fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
