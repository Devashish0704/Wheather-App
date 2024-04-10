import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

late double temp;
late String cityName;
late int condition;
late String Wicon;

// ignore: must_be_immutable
class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeatherData});
  final locationWeatherData;
  WeatherModel weather = WeatherModel();

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeatherData);
  }

  void updateUI(dynamic wheatherData) {
    setState(() {});
    if (wheatherData == null) {
      temp = 0;
      condition = 0;
      cityName = '';
      return;
    } else {
      condition = wheatherData['weather'][0]['id'];
      cityName = wheatherData['name'];
      temp = wheatherData['main']['temp'];
      Wicon = wheatherData['weather'][0]['icon'];
      print(condition);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/p6b.jpg"),
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
                  TextButton(
                    onPressed: () {
                      updateUI(widget.locationWeatherData);
                    },
                    child: Icon(
                      Icons.location_on_sharp,
                      color: Color.fromARGB(255, 255, 255, 0),
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var weatherData =
                          await WeatherModel().getLocationWeather();
                      updateUI(weatherData);

                      var typedName = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return (CityScreen());
                      }));
                      if (typedName != null) {
                        var weatherData =
                            await WeatherModel().getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      color: Color.fromARGB(255, 255, 255, 0),
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
                      temp.toInt().toString() + '°C',
                      style: kTempTextStyle,
                    ),

                    // Text(
                    //   WeatherModel().getWeatherIcon(condition),
                    //   style: kConditionTextStyle,
                    // ),
                    Image.network(
                      'http://openweathermap.org/img/w/${Wicon}.png',
                      // width: 100.0,
                      height: 150.0,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  WeatherModel().getMessage(temp.toInt()) + "in $cityName  ",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
