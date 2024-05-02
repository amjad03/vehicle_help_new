import 'package:flutter/material.dart';
import 'package:vehicle_help_new/view/user/notificationScreenUser.dart';
import 'package:vehicle_help_new/view/user/profilePageUser.dart';

import '../auth/authRepository.dart';
import '../screens/aboutScreen.dart';
import 'bookMechanic.dart';


class HomePageUser extends StatelessWidget {
  const HomePageUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mechanic Services'),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreenUser()));
            },
            icon: Icon(Icons.notifications)
          ),
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreenUser()));
            },
            icon: Icon(Icons.person)
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          MechanicCard(
            name: 'John Doe',
            address: '123 Main Street, City',
            pricePerHour: '₹500/hr',
            image: 'https://images.pexels.com/photos/3807277/pexels-photo-3807277.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
          ),
          MechanicCard(
            name: 'Jane Smith',
            address: '456 Oak Street, Town',
            pricePerHour: '₹600/hr',
            image: 'https://images.pexels.com/photos/3806249/pexels-photo-3806249.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
          ),
          MechanicCard(
            name: 'Mike Johnson',
            address: '789 Elm Street, Village',
            pricePerHour: '₹550/hr',
            image: 'https://images.pexels.com/photos/3807329/pexels-photo-3807329.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
          ),
          MechanicCard(
            name: 'Mike Johnson',
            address: '789 Elm Street, Village',
            pricePerHour: '₹450/hr',
            image: 'https://images.pexels.com/photos/3807120/pexels-photo-3807120.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
          ),
          MechanicCard(
            name: 'Mike Johnson',
            address: '789 Elm Street, Village',
            pricePerHour: '₹580/hr',
            image: 'https://images.pexels.com/photos/8985615/pexels-photo-8985615.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  image: NetworkImage('https://images.pexels.com/photos/12884318/pexels-photo-12884318.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Text(
                  'Welcome User', // Replace with the user's name
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Navigate to the home page
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                // Navigate to the settings page
                // Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreenUser()));
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                // Navigate to the about page
                Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()));
                // Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Navigate to the about page
                Navigator.pop(context);
                logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MechanicCard extends StatelessWidget {
  final String name;
  final String address;
  final String pricePerHour;
  final String image;

  MechanicCard({
    required this.name,
    required this.address,
    required this.pricePerHour,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.only(bottom: 20.0),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    address,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    'Price/hour: $pricePerHour',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: () {
                      // Add functionality to book mechanic
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BookMechanicPage(mechanicName: name, mechanicAddress: address, mechanicPricePerHour: pricePerHour,)));
                    },
                    child: Text('Book Now'),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: AspectRatio(
                aspectRatio: 9/12,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
//
//
// class HomePageUser extends StatefulWidget {
//   @override
//   _HomePageUserState createState() => _HomePageUserState();
// }
//
// class _HomePageUserState extends State<HomePageUser> {
//   String _locationMessage = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _getLocation();
//   }
//
//   Future<void> _getLocation() async {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     setState(() {
//       _locationMessage =
//       'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('GPS Tracking'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Location:',
//               style: TextStyle(fontSize: 20),
//             ),
//             Text(
//               _locationMessage,
//               style: TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
