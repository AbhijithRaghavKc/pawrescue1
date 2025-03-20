import 'package:flutter/material.dart';
import 'package:pawrescue1/view/const/custom_colors.dart';
import 'package:pawrescue1/view/user/adoption.dart';
import 'package:pawrescue1/view/user/donation.dart';
import 'package:pawrescue1/view/user/report.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('PawRescue'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Report'),
              Tab(text: 'Donation'),
              Tab(text: 'Adoption/Fostering'),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: CustomColors.buttonColor1,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'PawRescue',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Welcome to PawRescue!',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('About Us'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.help),
                title: const Text('Help'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ReportPage(),
            DonationPage(),
            AdoptionPage(),
          ],
        ),
      ),
    );
  }
}
