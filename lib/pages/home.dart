import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

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
        routeName = '/home';
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
          "DISPERPUSKA KABUPATEN BATANG",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
      body: Container(
        color: Color(0xffC0C0C0),
        alignment: Alignment.center,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: const Image(
                image: AssetImage("assets/home-image1.png"),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: const Color(0xffD9D9D9),
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Text(
                      "MENU UTAMA",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Image(
                            image: AssetImage("assets/home-icon-profile.png"),
                          ),
                          Text('Profile')
                        ],
                      ),
                      Column(
                        children: [
                          Image(
                            image: AssetImage("assets/home-icon-archive.png"),
                          ),
                          Text('Riwayat')
                        ],
                      ),
                      Column(
                        children: [
                          Image(
                            image: AssetImage("assets/home-icon-borrow.png"),
                          ),
                          Text('Pinjam')
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Image(
                image: AssetImage("assets/home-image2.png"),
              ),
            )
          ],
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
