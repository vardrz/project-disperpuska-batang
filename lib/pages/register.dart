import 'dart:convert'; // Import untuk jsonDecode
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:io';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  File? _ktpFile;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _ktpFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Validate the file size and type
      if (_ktpFile != null) {
        final fileSize = await _ktpFile!.length();
        final fileExtension = _ktpFile!.path.split('.').last.toLowerCase();

        if (fileSize > 1024 * 1024) {
          // Check if file size exceeds 1MB
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('File size exceeds 1MB.')),
          );
          return;
        }

        if (!['jpg', 'jpeg', 'png'].contains(fileExtension)) {
          // Validate file extension
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Invalid file type. Please upload a JPG, JPEG, or PNG image.')),
          );
          return;
        }
      }

      final request = http.MultipartRequest(
        'POST',
        Uri.parse('https://disperpuska.69dev.id/api/register-public'),
      );

      if (_ktpFile != null) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'ktp',
            await _ktpFile!.readAsBytes(),
            filename: 'ktp_image.${_ktpFile!.path.split('.').last}',
            contentType: MediaType('image', _ktpFile!.path.split('.').last),
          ),
        );
      }

      request.fields['name'] = _nameController.text;
      request.fields['email'] = _emailController.text;
      request.fields['phone'] = _phoneController.text;

      try {
        final response = await request.send();
        final responseBody = await response.stream.bytesToString();
        print('Response body: $responseBody'); // Print the response body

        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registrasi berhasil.')),
          );
          Navigator.pushNamed(context, '/home');
        } else {
          final errorResponse = jsonDecode(responseBody);

          String errorMessage = 'Failed to submit form';
          if (errorResponse.containsKey('error') &&
              errorResponse['error'].containsKey('ktp')) {
            errorMessage = errorResponse['error']['ktp'].toString();
          } else if (errorResponse.containsKey('message') &&
              errorResponse['message'].containsKey('error')) {
            errorMessage = errorResponse['message']['error'].toString();
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage)),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
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
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: "Nama anda..",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      width: MediaQuery.of(context).size.width,
                      child: const Text(
                        "Nomor Ponsel",
                        textAlign: TextAlign.left,
                      ),
                    ),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: "08...",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      width: MediaQuery.of(context).size.width,
                      child: const Text(
                        "Email",
                        textAlign: TextAlign.left,
                      ),
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: "Email anda..",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            .hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
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
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _pickImage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                      ),
                      child: const Text(
                        "Upload Foto KTP",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Pratinjau Gambar
                    _ktpFile != null
                        ? Image.file(
                            _ktpFile!,
                            height: 200,
                            fit: BoxFit.cover,
                          )
                        : const Text('Belum ada foto KTP yang dipilih.'),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: _submitForm,
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
            ],
          ),
        ),
      ),
    );
  }
}
