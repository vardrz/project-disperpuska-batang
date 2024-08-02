import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => AboutPageState();
}

class AboutPageState extends State<AboutPage> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    String routeName;

    switch (index) {
      case 0:
        routeName = '/home';
        break;
      case 1:
        routeName = '/contact';
        break;
      case 2:
        routeName = '/about';
        break;
      default:
        routeName = '/about';
    }

    Navigator.pushReplacementNamed(context, routeName);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffD9D9D9),
        centerTitle: true,
        title: const Text(
          "About",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        color: Color(0xffC0C0C0),
        alignment: Alignment.topRight,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Text(
          "Dinas Perpustakaan dan Kearsipan (DISPERPUSKA) Kabupaten Batang merupakan unsur pelaksana urursan pemerintahan bidang kearsipan yang dipimpin oleh Kepala Dinas, berkedudukan dibawah dan bertanggung jawab kepada bupati melalui Sekretaris Daerah. Dinas Perpustakaan dan Kearsipan mempunyai tugas dalam melaksanakan urusan pemerintahan bidang perpustakaan dan kearsipan yang menjadi kewenangan daerah dan tugas pembantuan yang ditugaskan kepada daerah.",
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize: 18),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Contact',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black, // Warna untuk item yang dipilih
        unselectedItemColor: Colors.grey, // Warna untuk item yang tidak dipilih
        backgroundColor: Colors.white,
      ),
    );
  }
}
