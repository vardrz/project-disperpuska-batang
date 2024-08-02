import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => HistoryPageState();
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

class HistoryPageState extends State<HistoryPage> {
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
          "Riwayat Peminjaman",
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
                      Text("No. Definitif : " + archive.archiveNumber),
                      Text(archive.desc),
                      Text("Nama Berkas : " + archive.archiveName),
                    ],
                  ),
                );
                // ListTile(
                //   title: Text(archive.archiveName),
                //   subtitle: Text(archive.desc),
                //   trailing: Text(archive.archiveNumber),
                // );
              },
            );
          }
        },
      ),
    );
  }
}
