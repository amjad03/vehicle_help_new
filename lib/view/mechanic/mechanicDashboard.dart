import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_help_new/view/mechanic/invoiceGenerator.dart';
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
      body:  Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder<User?>(
          future: _getCurrentUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError || snapshot.data == null) {
              return Center(
                child: Text('Error: Unable to fetch user data.'),
              );
            }
            // User is logged in, fetch appointments using UID
            final String uid = snapshot.data!.uid;

            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('mechanics')
                  .doc(uid)
                  .collection('appointments')
                  .snapshots(),

              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text('No appointments found.'),
                  );
                }

                // Display appointment documents from the subcollection
                return ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;

                    // Determine the color based on status
                    Color statusColor = data['status'] == 'pending'
                        ? Colors.orange
                        : Colors.green;

                    DateTime bookingTime = (data['bookingTime'] as Timestamp).toDate();

                    return Card(
                      child: ListTile(
                        title: Text('Customer Name:${data['userName']}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Booking Time: ${_formatDateTime(bookingTime)}'),
                            Text('Problem description: ${data['problemDescription']}'),
                            Text('Contact Number: ${data['contactNumber']}'),
                          ],
                        ),
                        trailing: Text(
                          data['status'],
                          style: TextStyle(color: statusColor),
                        ),
                      ),
                    );
                  }).toList(),
                );
                // return ListView(
                //   children: snapshot.data!.docs.map((DocumentSnapshot document) {
                //     Map<String, dynamic> data =
                //     document.data() as Map<String, dynamic>;
                //     // Customize the UI to display appointment data
                //     return ListTile(
                //       title: Text(data['mechanicName']),
                //       subtitle: Text(data['status']),
                //       // Add more ListTile properties as needed
                //     );
                //   }).toList(),
                // );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => InvoiceGeneratorScreen()));
          // _addMechanic();
        },
        child: Icon(Icons.add),
        tooltip: "Generate Invoice",
      ),
      // MechanicViewAppointmentsPage(),
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

  Future<User?> _getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  String _formatDateTime(DateTime dateTime) {
    String period = dateTime.hour < 12 ? 'AM' : 'PM';
    int hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    hour = hour == 0 ? 12 : hour; // Handle midnight (12 AM)
    String minute = dateTime.minute.toString().padLeft(2, '0');
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} at $hour:$minute $period';
  }

  // Future<void> _addMechanic() async {
  //   try {
  //     // Get the current user's UID
  //     String? uid = FirebaseAuth.instance.currentUser?.uid;
  //     if (uid == null) {
  //       // Handle the case where the user is not authenticated
  //       return;
  //     }
  //     await FirebaseFirestore.instance.collection('mechanics')
  //         .doc(uid)
  //         .set({
  //       'latitude':14.834505,
  //       'longitude':74.146224,
  //       'mechanicAddress':"Patel wada, Karwar",
  //       'mechanicImage':"https://i.pinimg.com/originals/6b/eb/d2/6bebd2f554c39c4c62e548efa536a97c.jpg",
  //       'mechanicName':"Gajanan Naik",
  //       'mechanicPhone':"99887755",
  //       'pricePerHour':"₹600/hr",
  //     });
  //     print("Successful");
  //   }catch (e) {
  //     print('Error booking mechanic: $e');
  //     // Handle error if needed
  //   }
  // }

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




