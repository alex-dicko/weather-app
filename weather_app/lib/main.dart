import 'exports.dart';



void main() {
  runApp(MaterialApp(
    home: Base(),
  ));
}


class Base extends StatefulWidget {
  
  Base({super.key});

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  int currentPageIndex = 0;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      


      body: [
        LocationPage(),
        Text("Hello"),
        Text("Search"),
        Text("Idk")

      ][_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: LineIcons.map,
                  text: 'Current',
                ),
                GButton(
                  icon: LineIcons.heart,
                  text: 'Injury Hub',
                ),
                GButton(
                  icon: LineIcons.search,
                  text: 'Profile',
                ),
                GButton(
                  icon: LineIcons.search,
                  text: 'Profile',
                ),


              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}















// class LocationPage extends StatefulWidget {
//   const LocationPage({super.key});

//   @override
//   State<LocationPage> createState() => _LocationPageState();
// }

// class _LocationPageState extends State<LocationPage> {
  
//   String? _currentAddress;
//   Position? _currentPosition;

//   Future<void> _getCurrentPosition() async {
//     final hasPermission = await _handleLocationPermission();
//     if (!hasPermission) return;
//     await Geolocator.getCurrentPosition(
//             desiredAccuracy: LocationAccuracy.high)
//         .then((Position position) {
//       setState(() => _currentPosition = position);
//     }).catchError((e) {
//       debugPrint(e);
//     });
//   }

  

//   Future<bool> _handleLocationPermission() async {
//     bool serviceEnabled;
//     LocationPermission permission;
    
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text('Location services are disabled. Please enable the services')));
//       return false;
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {   
//         ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Location permissions are denied')));
//         return false;
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text('Location permissions are permanently denied, we cannot request permissions.')));
//       return false;
//     }
//     return true;
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _getCurrentPosition();
//     setState(() {
      
//     });
//   }
//   @override
  
//   Widget build(BuildContext context) {
//      return Scaffold(
//        appBar: AppBar(title: const Text("Location Page")),
//        body: SafeArea(
//          child: Center(
//            child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('LAT: ${_currentPosition?.latitude ?? ""}'),
//                 Text('LNG: ${_currentPosition?.longitude ?? ""}'),
//                 Text('ADDRESS: ${_currentAddress ?? ""}'),
//                 const SizedBox(height: 32),
                
//               ],
//             ),
//          ),
//        ),
//     );
//   }
// }


