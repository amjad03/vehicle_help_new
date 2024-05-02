import 'package:flutter/material.dart';
import 'package:vehicle_help_new/view/mechanic/profilePageMechanic.dart';
import 'package:vehicle_help_new/view/screens/aboutScreen.dart';

import '../auth/authRepository.dart';
import 'appointmenList.dart';

class MechanicDashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreenMechanic()));
          }, icon: Icon(Icons.person))
        ],
      ),
      body: MechanicViewAppointmentsPage(),
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
                  'Welcome Mechanic', // Replace with the user's name
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreenMechanic()));
                // Navigator.pop(context);
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
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       MechanicViewAppointmentsPage(),
      //     ],
      //   ),
      // ),
    );
  }
}

class CardOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  const CardOption({
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(15.0),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 30.0,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(width: 20.0),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




