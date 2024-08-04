import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final String archiveNumber;
  final String archiveDate;
  final String archiveFrom;
  final String archiveContent;

  const DetailPage(
    this.archiveNumber,
    this.archiveDate,
    this.archiveFrom,
    this.archiveContent,
  );

  @override
  DetailPageState createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  final _formKey = GlobalKey<FormState>();
  bool isLogin = false;

  @override
  Widget build(BuildContext context) {
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
                    Navigator.pushNamed(context, "/login");
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
                                  const TextField(
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: "Keperluan",
                                    ),
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
                                          // Tambahkan aksi untuk "Pinjam" di sini
                                          Navigator.of(context)
                                              .pop(); // Tutup dialog
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
