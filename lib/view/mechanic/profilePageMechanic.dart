import 'package:flutter/material.dart';

class ProfileScreenMechanic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20.0),
          CircleAvatar(
            radius: 40.0,
            child: Icon(Icons.person),
          ),
          SizedBox(height: 20.0),
          Text(
            'Gajanan Naik',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            '(Mechanic)',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 20.0),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('gajanan_naik@example.com'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('+91 8899667755'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Mangrapoi road, Karwar'),
          ),
          Divider(),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              // Add functionality to edit profile
            },
            child: Text('Edit Profile'),
          ),
        ],
      ),
    );
  }
}