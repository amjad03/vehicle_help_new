import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAppointmentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
      ),
      body: Padding(
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
                  .collection('bookMechanic')
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
                        title: Text(data['mechanicName']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Booking Time: ${_formatDateTime(bookingTime)}'),
                            // Text('Contact Number: ${data['contactNumber']}'),
                            Text('Mechanic Address: ${data['mechanicAddress']}'),
                            // Text('Mechanic ID: ${data['mechanicId']}'),
                            Text('Mechanic Price Per Hour: ${data['mechanicPricePerHour']}'),
                            Text('Problem Description: ${data['problemDescription']}'),
                            // Text('User Name: ${data['userName']}'),
                            // Add more fields as needed
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

}
