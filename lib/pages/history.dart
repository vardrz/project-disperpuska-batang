import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // Tambahkan dependency intl pada pubspec.yaml

class HistoryPage extends StatefulWidget {
  final String public_id;

  const HistoryPage(this.public_id);

  @override
  State<HistoryPage> createState() => HistoryPageState();
}

class Archive {
  final String id;
  final String onDate;
  final String archiveNumber;
  final String institute;
  final String desc;
  final String status;
  final String keterangan;
  final String updated_at;

  Archive({
    required this.id,
    required this.onDate,
    required this.archiveNumber,
    required this.institute,
    required this.desc,
    required this.status,
    required this.keterangan,
    required this.updated_at,
  });

  factory Archive.fromJson(Map<String, dynamic> json) {
    return Archive(
      id: json['id'],
      onDate: json['on_date'],
      archiveNumber: json['archives_number'],
      institute: json['institute'],
      desc: json['isi'],
      status: json['status'],
      keterangan: json['keterangan'],
      updated_at: json['updated_at'],
    );
  }
}

Future<List<Archive>> fetchArchives(String publicId) async {
  print('https://disperpuska.69dev.id/api/list-arsip/$publicId');

  final response = await http.get(
    Uri.parse('https://disperpuska.69dev.id/api/list-arsip/$publicId'),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final List<dynamic> archivesJson = responseData['data'];

    return archivesJson.map((json) => Archive.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load archives');
  }
}

class HistoryPageState extends State<HistoryPage> {
  late Future<List<Archive>> futureArchives;

  @override
  void initState() {
    super.initState();
    futureArchives = fetchArchives(widget.public_id);
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Dipinjam':
        return Colors.green.shade800; // Warna hijau untuk status Dipinjam
      case 'Diproses':
        return Colors.orange.shade700; // Warna kuning untuk status Diproses
      default:
        return Colors.black; // Warna default
    }
  }

  String? _calculateFine(String updatedAt) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    final DateTime updateDate = dateFormat.parse(updatedAt);
    final DateTime today = DateTime.now();
    final Duration difference = today.difference(updateDate);
    final int daysLate = difference.inDays;

    if (daysLate > 7) {
      final int fine = (daysLate - 7) * 2000; // Menghitung denda
      return "Denda: \Rp ${fine}"; // Format denda
    }
    return null;
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
                final fine = _calculateFine(archive.updated_at);

                return Container(
                  color: Colors.black12,
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Nomor Arsip: " + archive.archiveNumber),
                      Text("Tanggal: " + archive.onDate),
                      Text("Instansi: " + archive.institute),
                      Text("Isi Arsip: " + archive.desc),
                      if (fine != null)
                        Text(
                          fine,
                          style: TextStyle(
                            color: Colors.red, // Warna denda merah
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      Text(
                        "Status: " + archive.keterangan,
                        style: TextStyle(
                          color: _getStatusColor(archive.keterangan),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
