import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:myclinic/patient/appointment_booked.dart';
import 'package:myclinic/patient/find_doctor.dart';
import 'package:myclinic/patient/p_dashboard.dart';
import 'package:myclinic/patient/patient_profile.dart';
import 'package:myclinic/screens/homepage.dart';
import 'package:myclinic/screens/try.dart';

class BottomNavigation extends StatefulWidget {
  final index;
  BottomNavigation(this.index);
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          physics: new NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            PatientDashboard(),
            SearchDoctor(),
            BookedAppointment(),
            PProfile(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text(
                'Home',
                style: TextStyle(fontSize: 13),
              ),
              icon: Icon(Icons.dashboard_sharp),
              inactiveColor: Colors.grey,
              activeColor: Color.fromRGBO(70, 209, 89, 1.0)),
          BottomNavyBarItem(
              title: Text(
                'Search',
                style: TextStyle(fontSize: 13),
              ),
              icon: Icon(Icons.search),
              inactiveColor: Colors.grey,
              activeColor: Color.fromRGBO(70, 209, 89, 1.0)),
          BottomNavyBarItem(
              title: Text(
                'Report',
                style: TextStyle(fontSize: 13),
              ),
              icon: Icon(Icons.chat_bubble),
              inactiveColor: Colors.grey,
              activeColor: Color.fromRGBO(70, 209, 89, 1.0)),
          BottomNavyBarItem(
              title: Text(
                'Account',
                style: TextStyle(fontSize: 13),
              ),
              icon: Icon(Icons.account_circle_sharp),
              inactiveColor: Colors.grey,
              activeColor: Color.fromRGBO(70, 209, 89, 1.0)),
        ],
      ),
    );
  }
}
