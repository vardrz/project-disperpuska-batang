import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffD9D9D9),
        centerTitle: true,
        title: const Text(
          "Profil",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xffC0C0C0),
          alignment: Alignment.topRight,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: const Column(
            children: [
              Text(
                "Struktur Organisasi Dinas Perpustakaan dan Kearsipan.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              Image(
                image: AssetImage("assets/org-chart.png"),
              ),
              SizedBox(height: 80)
            ],
          ),
        ),
      ),
    );
  }
}
