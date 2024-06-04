import 'package:weather_app/exports.dart';


class Location {
  // location
  String? location_name;
  String? location_region;
  String? location_country;
  String? location_tz_id;
  String? location_localtime;

  //current
  String? current_lastupdated;
  String? current_temp_c;
  String? current_wind_mph;
  String? current_humidity;
  String? feelslife_c;
  String? uv;
  String? current_condition_text;
  String? current_condiftion_icon;

  Location({
    required this.location_name,
    // required this.location_region,
    // required this.location_country,
    // required this.location_tz_id,
    // required this.location_localtime,
    // required this.current_lastupdated,
    // required this.current_temp_c,
    // required this.current_wind_mph,
    // required this.current_humidity,
    // required this.feelslife_c,
    // required this.uv,
    // required this.current_condition_text,
    // required this.current_condiftion_icon,
  });




}
class CurrentLocation {
  String? _currentAddress;
  Position? _currentPosition; 
  double? lon;
  double? lat;
  Location? location;
  String? name;
  String? location_name;
  String? location_region;
  String? location_country;
  String? location_tz_id;
  String? location_localtime;

  //current
  String? current_lastupdated;
  double? current_temp_c;
  String? current_wind_mph;
  String? current_humidity;
  String? feelslife_c;
  String? uv;
  String? current_condition_text;
  String? current_condition_icon;

  Future<bool> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return false;
    
    try {
      _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      lat = _currentPosition!.latitude;
      lon = _currentPosition!.longitude;
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

  Future<void> _getData() async {
    var headers = {

    };
    Uri URI = Uri.parse('http://api.weatherapi.com/v1/current.json?key=$key&q=$lat,$lon&aqi=no');
    Response response = await get(URI);
    Map data = jsonDecode(response.body);
    print(data['location']['name']);
    if (response.statusCode == 200) {
        location_name = data['location']['name'];   
        location_region = data['location']['region'];
        location_country = data['location']['region'];
        location_tz_id = data['location']['tz_id'];
        location_localtime = data['location']['localtime'];
        current_temp_c = data['current']['temp_c'];
        current_lastupdated = data['current']['last_updated'];
        current_condition_text = data['current']['condition']['text'];
        current_condition_icon = data['current']['condition']['icon'];

    }
    
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
  String? name;
  bool loaded = false;
  CurrentLocation loca = CurrentLocation();

  void setup() async {
    bool result = await loca._getCurrentPosition();
    await loca._getData();
    print('name is: ${loca.name}');
    

    if (result == true) {
      setState(() {
        lat = loca._currentPosition!.latitude;
        lon = loca._currentPosition!.longitude;
        name = loca.name;
        loaded = true;
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
    if (loaded == true)
    {
      return Scaffold(
        appBar: AppBar(title: const Text("Location Page")),
        body: SafeArea(
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('LAT: ${lat ?? 'Permissions Issue'}'),
                  Text('LON: ${lon ?? 'Permissions Issue'}'),
                  Text('NAME: ${loca.location_name ?? 'Permissions Issue'}'),
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
    else 
    {
      return Scaffold(
        body: SafeArea(child: Center(child: Text('Loading...'),),),
      );
    }
  }
}


