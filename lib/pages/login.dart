import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_kearsipan/pages/detail.dart';
import 'package:project_kearsipan/pages/history.dart';

class LoginPage extends StatefulWidget {
  final String archiveID;
  final String archiveNumber;
  final String archiveDate;
  final String archiveFrom;
  final String archiveContent;
  final String toPage;

  const LoginPage(
    this.archiveID,
    this.archiveNumber,
    this.archiveDate,
    this.archiveFrom,
    this.archiveContent,
    this.toPage,
  );

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final phone = _phoneController.text;

      // Kirim request login ke API
      final response = await http.post(
        Uri.parse('https://disperpuska.69dev.id/api/login-public'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'phone': phone,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data['status'] == 200 && data['data'] != null) {
          final userData = data['data'];

          if (widget.toPage == 'history') {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HistoryPage(userData['id']),
              ),
            );
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DetailPage(
                  widget.archiveID,
                  widget.archiveNumber,
                  widget.archiveDate,
                  widget.archiveFrom,
                  widget.archiveContent,
                  true,
                  userData['id'],
                ),
              ),
            );
          }
        } else {
          // Tampilkan pesan kesalahan jika login gagal
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login gagal, periksa lagi nomor anda.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login gagal, periksa lagi nomor anda.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage("assets/logo-kab-batang.png")),
            const SizedBox(height: 40),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: "Nomor HP",
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),
                child: const Text(
                  "Register",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
