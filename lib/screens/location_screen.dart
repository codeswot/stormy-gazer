import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:stormgaze01/screens/city_screen.dart';
import 'package:stormgaze01/services/ads_service.dart';
import 'package:stormgaze01/services/weather.dart';
import 'package:stormgaze01/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});
  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  AdsServices adsService = AdsServices();
  WeatherModel weather = WeatherModel();
  BannerAd bannerAdAd;
  InterstitialAd interstitialAd;
  int temperature;
  String weatherICon;
  String cityName;
  String weatherMessage;
  String inKey;
  bool weatherDataNull = false;
  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: appId);
    adsService.createInterstitialAd();
//    adsService.runAds();

    updateUI(widget.locationWeather);
    weatherDataNull = false;

    super.initState();
  }

  @override
  void dispose() {
    adsService.disposeAds();
    super.dispose();
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        weatherDataNull = true;
        temperature = 0;
        weatherICon = 'Error';
        weatherMessage =
            'Unable to get weather, check internet connection and make sure location is on and make sure you typed a valid city name';
        cityName = '';
        inKey = '';
        return;
      } else {
        weatherDataNull = false;
        double temp = weatherData['main']['temp'];
        temperature = temp.toInt();
        var condition = weatherData['weather'][0]['id'];
        weatherICon = weather.getWeatherIcon(condition);
        weatherMessage = weather.getMessage(temperature);
        cityName = weatherData['name'];
        inKey = 'in';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AdsServices adsServices = AdsServices();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      FirebaseAdMob.instance.initialize(appId: appId);
                      adsServices.createBannerAd()
                        ..load()
                        ..show();
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      FirebaseAdMob.instance.initialize(appId: appId);
                      adsServices.createInterstitialAd()
                        ..load()
                        ..show();

                      var typedName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CityScreen()));
                      if (typedName != null) {
                        var weatherData =
                            await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherICon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text('$weatherMessage $inKey $cityName ',
                    textAlign: TextAlign.right,
                    style: weatherDataNull
                        ? TextStyle(
                            fontSize: 35.0,
                          )
                        : kMessageTextStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
