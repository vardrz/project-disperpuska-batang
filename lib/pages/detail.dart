import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:project_kearsipan/pages/login.dart';

class DetailPage extends StatefulWidget {
  final String archiveID;
  final String archiveNumber;
  final String archiveDate;
  final String archiveFrom;
  final String archiveContent;
  final bool login;
  final String public_id;

  const DetailPage(
    this.archiveID,
    this.archiveNumber,
    this.archiveDate,
    this.archiveFrom,
    this.archiveContent,
    this.login,
    this.public_id,
  );

  @override
  DetailPageState createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  final _formKey = GlobalKey<FormState>();
  final _needsController = TextEditingController();

  Future<void> _requestArchive() async {
    final needs = _needsController.text;

    if (needs.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter the purpose of borrowing.')),
      );
      return;
    }

    print("public : " + widget.public_id);
    print("arsip : " + widget.archiveID);
    print("keperluan : " + needs);

    final response = await http.post(
      Uri.parse('https://disperpuska.69dev.id/api/pinjam-arsip'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'publics_id': widget.public_id,
        'archives_id': widget.archiveID,
        'needs': needs,
      }),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData['status'] == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Berhasil mengajukan peminjaman arsip.')),
        );
        Navigator.pushNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengajukan peminjaman arsip.')),
        );
      }
    } else {
      throw Exception('Gagal mengajukan peminjaman arsip.');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLogin = widget.login;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffD9D9D9),
        centerTitle: true,
        title: const Text(
          "Detail Arsip",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        color: const Color(0xffffffff),
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Table(
              columnWidths: const {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(0.5),
                2: FlexColumnWidth(5),
              },
              children: [
                TableRow(
                  children: [
                    const Text("Nomor Arsip"),
                    const Text(":"),
                    Text(widget.archiveNumber)
                  ],
                ),
                TableRow(
                  children: [
                    const Text("Tanggal Arsip"),
                    const Text(":"),
                    Text(widget.archiveDate)
                  ],
                ),
                TableRow(
                  children: [
                    const Text("Dari Instansi"),
                    const Text(":"),
                    Text(widget.archiveFrom)
                  ],
                ),
                TableRow(
                  children: [
                    const Text("Isi Arsip"),
                    const Text(":"),
                    Text(widget.archiveContent)
                  ],
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () async {
                  if (!isLogin) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LoginPage(
                          widget.archiveID,
                          widget.archiveNumber,
                          widget.archiveDate,
                          widget.archiveFrom,
                          widget.archiveContent,
                          'borrow',
                        ),
                      ),
                    );
                  } else {
                    await showDialog<void>(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Stack(
                          clipBehavior: Clip.none,
                          children: <Widget>[
                            Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  TextFormField(
                                    controller: _needsController,
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: "Keperluan",
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Silahkan isi keperluan.';
                                      }
                                      return null;
                                    },
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    child: const Text(
                                      "*Masa peminjaman arsip adalah 7 hari.",
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              right: 30, top: 20),
                                          child: const Text(
                                            "Batal",
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Colors.deepPurple,
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _requestArchive();
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              right: 10, top: 20),
                                          child: const Text(
                                            "Pinjam",
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Colors.deepPurple,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
                child: const Text("Pinjam Arsip"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
