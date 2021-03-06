import 'package:coinzie/widgets/drawer.dart';
import 'package:coinzie/pages/home.dart';
import 'package:coinzie/pages/news.dart';
import 'package:coinzie/pages/portfolio.dart';
import 'package:coinzie/pages/splashScreen.dart';
import 'package:coinzie/pages/wallets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';

import 'widgets/account.dart';

Future main() async {
  await Settings.init(cacheProvider: SharePreferenceCache());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueChangeObserver<bool>(
        cacheKey: Account.keyDarkMode,
        defaultValue: true,
        builder: (_, isDarkMode, __) => GetMaterialApp(
              title: 'Coinzie : Crypto Wallet',
              theme: ThemeData(
                  primaryColor: Colors.deepPurpleAccent.shade400,
                  highlightColor: Color.fromRGBO(126, 87, 194, 1.0)),
              home: SplashScreen(),
              debugShowCheckedModeBanner: false,
            ));
  }
}

class MainApp extends StatefulWidget {
  static final String title = 'Settings';
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _currentIndex = 0;

  final tabs = [Home(), Wallets(), Portforlio(), News(), Account()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.blue[900],
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  size: 40,
                ));
          },
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Coinzie',
          style: TextStyle(
              fontFamily: 'Varela Round',
              color: Colors.blue[900],
              fontSize: 40,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.tealAccent.shade400,
        currentIndex: _currentIndex,
        elevation: 0.0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined),
              label: 'Wallets'),
          BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart_outline), label: 'Portfolio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_outlined), label: 'News'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Account'),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
