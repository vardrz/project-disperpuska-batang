import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

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
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    width: MediaQuery.of(context).size.width,
                    child: const Text(
                      "Nama Lengkap",
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Nama anda..",
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    width: MediaQuery.of(context).size.width,
                    child: const Text(
                      "Nomor Ponsel",
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "08...",
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    width: MediaQuery.of(context).size.width,
                    child: const Text(
                      "Email",
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Email anda..",
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    width: MediaQuery.of(context).size.width,
                    child: const Text(
                      "Wilayah",
                      textAlign: TextAlign.left,
                    ),
                  ),
                  TextFormField(
                    initialValue: "Kabupaten Batang",
                    readOnly: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
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
                  Navigator.pushNamed(context, '/home');
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
