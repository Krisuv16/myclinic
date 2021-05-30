import 'package:flutter/material.dart';
import 'package:myclinic/main/bottomnav.dart';
import 'package:myclinic/model/appointmentmodels.dart';
import 'package:myclinic/patient/appointment_booked.dart';
import 'package:myclinic/patient/appointments.dart';
import 'package:myclinic/patient/changeprofile.dart';
import 'package:myclinic/patient/doctor_search.dart';
import 'package:myclinic/patient/edit_profile.dart';
import 'package:myclinic/patient/find_doctor.dart';
import 'package:myclinic/patient/p_dashboard.dart';
import 'package:myclinic/patient/patient_home.dart';
import 'package:myclinic/patient/patient_profile.dart';
import 'package:myclinic/patient/report_page.dart';
import 'package:myclinic/screens/auth/login.dart';
import 'package:myclinic/screens/auth/reset.dart';
import 'package:myclinic/screens/doctor/create_report.dart';
import 'package:myclinic/screens/doctor/d_myapppointments.dart';
import 'package:myclinic/screens/doctor/doctor_profile.dart';
import 'package:myclinic/screens/doctor/doctorview.dart';
import 'package:myclinic/screens/homepage.dart';
import 'package:myclinic/screens/try.dart';

class RouterClass {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'home':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => BottomNavigation(settings.arguments),
          transitionDuration: Duration(seconds: 0),
        );
      case 'dashboard':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => DashBoard(),
          transitionDuration: Duration(seconds: 0),
        );
      case 'login':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => LoginPage(),
          transitionDuration: Duration(seconds: 0),
        );
      case 'dprofile':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => DoctorProfile(),
          transitionDuration: Duration(seconds: 0),
        );
      case 'pdashboard':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => PatientDashboard(),
          transitionDuration: Duration(seconds: 0),
        );
      case 'paitenthome':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => PaitentHome(),
          transitionDuration: Duration(seconds: 0),
        );
      case 'pprofile':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => PProfile(),
          transitionDuration: Duration(seconds: 0),
        );
      case 'editprofile':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => ChangeProfiel(),
          transitionDuration: Duration(seconds: 0),
        );
      case 'appointments':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => Appointments(),
          transitionDuration: Duration(seconds: 0),
        );
      case 'booked-appointments':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => BookedAppointment(),
          transitionDuration: Duration(seconds: 0),
        );
      case 'doctor-search':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => DoctorSearch(),
          transitionDuration: Duration(seconds: 0),
        );
      case 'pw-reset':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => ResetPasswordToken(),
          transitionDuration: Duration(seconds: 0),
        );
      case 'dappointments':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => DoctorAppointments(),
          transitionDuration: Duration(seconds: 0),
        );
      case 'doctor-view':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => DoctorView(),
          transitionDuration: Duration(seconds: 0),
        );
      case 'p-report':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => ReportPage(),
          transitionDuration: Duration(seconds: 0),
        );
      case 'create-report':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => CreateReport(),
          transitionDuration: Duration(seconds: 0),
        );
              case 'edit-pprofile':
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => EditProfilePatient(),
          transitionDuration: Duration(seconds: 0),
        );
      default:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => LoginPage(),
          transitionDuration: Duration(seconds: 0),
        );
    }
  }
}
