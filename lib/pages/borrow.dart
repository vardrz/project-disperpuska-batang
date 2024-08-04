import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_kearsipan/pages/detail.dart';

class BorrowPage extends StatefulWidget {
  const BorrowPage({super.key});

  @override
  State<BorrowPage> createState() => BorrowPageState();
}

class Archive {
  final String archiveNumber;
  final String desc;
  final String archiveName;
  final String id;

  Archive({
    required this.archiveNumber,
    required this.desc,
    required this.archiveName,
    required this.id,
  });

  factory Archive.fromJson(Map<String, dynamic> json) {
    return Archive(
      archiveNumber: json['archive_number'],
      desc: json['desc'],
      archiveName: json['archive_name'],
      id: json['id'],
    );
  }
}

Future<List<Archive>> fetchArchives() async {
  final response = await http.get(
      Uri.parse('https://66acbcfef009b9d5c7333c16.mockapi.io/api/archive'));

  if (response.statusCode == 200) {
    List<dynamic> json = jsonDecode(response.body);
    return json.map((data) => Archive.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load archives');
  }
}

class BorrowPageState extends State<BorrowPage> {
  late Future<List<Archive>> futureArchives;

  @override
  void initState() {
    super.initState();
    futureArchives = fetchArchives();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffD9D9D9),
        centerTitle: true,
        title: const Text(
          "Pinjam Arsip",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: FutureBuilder<List<Archive>>(
        future: futureArchives,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No Data Available'));
          } else {
            List<Archive> archives = snapshot.data!;

            return ListView.builder(
              itemCount: archives.length,
              itemBuilder: (context, index) {
                final archive = archives[index];
                return Container(
                  color: Colors.black12,
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(archive.desc),
                      Text("Nama Berkas : " + archive.archiveName),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                      archive.archiveNumber,
                                      "2002-01-02",
                                      archive.archiveName,
                                      archive.desc),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 10, right: 5),
                              color: Colors.green.shade300,
                              padding: EdgeInsets.all(5),
                              child: Text(
                                "Pinjam",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
