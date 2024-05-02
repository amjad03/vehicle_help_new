import 'package:flutter/material.dart';

class BookMechanicPage extends StatelessWidget {
  final String mechanicName;
  final String mechanicAddress;
  final String mechanicPricePerHour;

  const BookMechanicPage({super.key,
    required this.mechanicName,
    required this.mechanicAddress,
    required this.mechanicPricePerHour,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Mechanic'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mechanic Details:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              Text('Name: $mechanicName'),
              Text('Address: $mechanicAddress'),
              Text('Price per Hour: $mechanicPricePerHour'),
              const SizedBox(height: 20.0),
              const Text(
                'Enter your details:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              // const TextField(
              //   decoration: InputDecoration(labelText: 'Your Name'),
              // ),
              // const TextField(
              //   decoration: InputDecoration(labelText: 'Your Address'),
              // ),
              TextFormField(
                // controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Your Name',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    // borderSide: BorderSide.none,
                  ),
                  // prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                // controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Contact Number',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    // borderSide: BorderSide.none,
                  ),
                  // prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                // controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Describe Your Problem',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    // borderSide: BorderSide.none,
                  ),
                  // prefixIcon: Icon(Icons.person),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              // const TextField(
              //   decoration: InputDecoration(labelText: 'Contact Number'),
              // ),
              // const TextField(
              //   decoration: InputDecoration(labelText: 'Describe Your Problem',),
              // ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Add functionality to book mechanic
                  _bookMechanic(context);
                },
                child: const Text('Book Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _bookMechanic(BuildContext context) {
    // Add functionality to book mechanic
    // Here, you can implement the logic to handle booking
    // For example, sending data to server, updating database, etc.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Booking Confirmed'),
          content: const Text('Your booking has been confirmed.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
