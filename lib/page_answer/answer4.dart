import 'package:flutter/material.dart';

class Answer4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Profile Page',
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                ),
                SizedBox(height: 10),
                Text(
                  'Nun_Patchareeporn',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // Profile Information
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Column(
              children: [
                profileRow(Icons.email, 'saratee_p@su.ac.th'),
                profileRow(Icons.phone, '0912345XXX'),
                profileRow(Icons.location_on, 'Nakhonpathom'),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Edit Profile'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Logout"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget profileRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 28),
          SizedBox(width: 16),
          Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}