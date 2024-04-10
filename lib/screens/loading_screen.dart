import 'package:flutter/material.dart';
// import 'package:clima/services/location.dart';
// import 'package:clima/services/networking.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// Location location = Location();
const apiKey = "d454774256fba159cf520aa79c4eca20";

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    getLocationData();
    super.initState();
  }

  void getLocationData() async {
    WeatherModel weatherModel = WeatherModel();
    var wheatherData = await weatherModel.getLocationWeather();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(locationWeatherData: wheatherData);
    }));
  }

  // print(await http.read(Uri.https('example.com', 'foobar.txt')));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: LoadingAnimationWidget.threeArchedCircle(
        color: Colors.white,
        size: 200,
      ),
    ));
  }
}
