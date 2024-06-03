import 'dart:ffi';

import 'package:weather_app/exports.dart';



class CurrentLocation {
  String? _currentAddress;
  Position? _currentPosition; 

  Future<bool> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return false;
    
    try {
      _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }


  

  

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('enable Servives');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {   
        print('Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }
  
}


class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  double? lat;
  double? lon;

  void setup() async {
    CurrentLocation loca = CurrentLocation();
    bool result = await loca._getCurrentPosition();
    if (result == true) {
      setState(() {
        lat = loca._currentPosition!.latitude;
        lon = loca._currentPosition!.longitude;
      });
    }
    // function to get weather from current location


  }


  void next() {
    print('Setup done');
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setup();
    next();
  }
  @override
  
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(title: const Text("Location Page")),
       body: SafeArea(
         child: Center(
           child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('LAT: ${lat ?? 'Permissions Issue'}'),
                Text('LONL ${lon ?? 'Permissions Issue'}'),
                // Text('LAT: ${_currentPosition?.latitude ?? ""}'),
                // Text('LNG: ${_currentPosition?.longitude ?? ""}'),
                // Text('ADDRESS: ${_currentAddress ?? ""}'),
                const SizedBox(height: 32),
                
              ],
            ),
         ),
       ),
    );
  }
}


