import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg.jpg"), fit: BoxFit.cover),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage("assets/logo-kab-batang.png")),
            const SizedBox(height: 40),
            Text(
              "JARINGAN INFORMASI KEARSIPAN DAERAH DINAS PERPUSTAKAAN DAN KEARSIPAN DAERAH KABUPATEN BATANG",
              style: GoogleFonts.montserrat(
                  fontSize: 15, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text(
                "GET STARTED",
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
            )
          ],
        ),
      ),
    );
  }
}
