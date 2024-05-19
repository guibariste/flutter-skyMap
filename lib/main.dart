import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sky_map/paint.dart';

import 'dart:async';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription _compassStream;
  double _azimuth = 0;
  double _screenWidth = 0;
  double _screenHeight = 0;
  double _altitude = 0;
  double axeY = 0;
  double? _azimut;
  // double _latitude = 0;
  // double _longitude = 0;
  String he = "";
  String hef = "";
  String hed = "";
  bool paysage = false;
  List<Map<String, dynamic>> _planetData = [];
  // List<Map<String, dynamic>> _visiblePlanets = [];
  @override
  void initState() {
    super.initState();

    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _altitude = (atan2(event.x, event.z) * (180 / pi)) - 90;
        axeY = event.y;
      });
      print('axey:$axeY');
    });

    _compassStream = FlutterCompass.events!.listen((event) {
      setState(() {
        _azimuth = event.heading ?? 0;
        _azimuth += 90;
        // compareAzimuthWithPlanetData();
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _screenWidth = MediaQuery.of(context).size.width;
        _screenHeight = MediaQuery.of(context).size.height;
      });
    });
    fetchData();
    _getLocation();
  }

  @override
  void dispose() {
    _compassStream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Grille du ciel'),
        ),
        body: Center(
          child: CustomPaint(
            painter:
                GridPainter(_azimuth, _screenWidth, _planetData, _altitude),
            size: Size.infinite,
          ),
        ));
  }

  Future<void> fetchData() async {
    String apiUrl = 'https://api.astronomyapi.com/api/v2/bodies/positions';
    String applicationId = 'cbafc241-bcae-4e4c-b53b-a200a390d67f';
    String applicationSecret =
        'd3582c95a83764e72b3170e40c7c110601ae58f17a98763463f902ca187d01579e8c373186cc0b1d8c1f2aaaa2b9aaf3b29260d573f3ac0158bf6790a1d49d61d8ef007d461e480d63c489a61cececeeb0e48f07808c0c44c20fa9877c03ca96a715cd46b0dc6d08918931119e64c4e6';

    // Générer la chaîne d'authentification
    String authString = generateAuthString(applicationId, applicationSecret);

    // Construire l'en-tête d'autorisation
    Map<String, String> headers = {
      'Authorization': 'Basic $authString',
    };
    Map<String, String> queryParams = {
      // 'latitude': _latitude.toStringAsFixed(2),
      // 'longitude': _longitude.toStringAsFixed(2),
      'latitude': '33',
      'longitude': '-84',
      'elevation': '0',
      'from_date': (DateTime.now().toString().split(' ')[0]),
      'to_date': (DateTime.now().toString().split(' ')[0]),
      'time':
          ('${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}'),
    };
    String queryString = Uri(queryParameters: queryParams).query;
    String requestUrl = '$apiUrl?$queryString';

    // Effectuer la requête HTTP avec l'en-tête d'autorisation
    try {
      final response = await http.get(Uri.parse(requestUrl), headers: headers);

      final jsonData = json.decode(response.body);
      print(jsonData);
      final rows = jsonData['data']['table']['rows'];

      for (var row in rows) {
        var cells = row['cells'];
        for (var cell in cells) {
          var position = cell['position']['horizonal'];
          var azimuthDegrees = double.parse(position['azimuth']['degrees']);
          var altitudeDegrees = double.parse(position['altitude']['degrees']);

          var constellation = cell['position']['constellation']['name'];
          // print(constellation);

          // Vérifier si l'azimut est dans la plage désirée

          _planetData.add({
            'azimuth': azimuthDegrees,
            'altitude': altitudeDegrees,
            'name': row['entry']['name'],
            'constellation': constellation,
          });
        }
      }
    } catch (error) {
      print('Erreur lors de la requête HTTP: $error');
    }
  }

  void compareAzimuthWithPlanetData() {
    // Videz d'abord la liste _visiblePlanets
    // _visiblePlanets.clear();
    if (_azimut != null) {
      var azimuthRounded = double.parse((_azimut!).toStringAsFixed(2));
      var altitudeRounded = double.parse((_altitude).toStringAsFixed(2));
      for (var planetData in _planetData) {
        var azimuthDegrees = planetData['azimuth'];
        var altitude = planetData['altitude'];

        // print(altitude);
        // print(altitudeRounded);

        // var planetName = planetData['name'];
        // var constellation = planetData['constellation'];
        // Vérifiez si l'azimut est dans la plage désirée
        if ((azimuthRounded >= azimuthDegrees - 50 &&
                azimuthRounded <= azimuthDegrees + 50) &&
            (altitudeRounded >= altitude - 50 &&
                altitudeRounded <= altitude + 50)) {
          // Ajoutez la planète à la liste _visiblePlanets
          // _visiblePlanets.add(planetData);
        }
      }
    }
  }

  Future<void> _getLocation() async {
    if (await Permission.location.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);
        setState(() {
          // _latitude = position.latitude;
          // _longitude = position.longitude;
        });
      } catch (e) {
        print('Error getting location: $e');
      }
    } else {
      // Demander les autorisations de localisation
      await Permission.location.request();
    }
  }

  String generateAuthString(String applicationId, String applicationSecret) {
    String authString = '$applicationId:$applicationSecret';
    String encodedAuthString = base64.encode(utf8.encode(authString));
    return encodedAuthString;
  }
}
