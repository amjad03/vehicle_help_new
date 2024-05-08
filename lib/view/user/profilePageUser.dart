import 'package:flutter/material.dart';

class ProfileScreenUser extends StatelessWidget {
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
            'Darshan Patel',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            '(User)',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 20.0),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('darshanpatel@example.com'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('+91 9988776655'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Patel wada, Karwar'),
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