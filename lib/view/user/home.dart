import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:pawrescue1/view/const/custom_colors.dart';
import 'package:pawrescue1/view/user/adoption.dart';
import 'package:pawrescue1/view/user/auth/signup.dart';
import 'package:pawrescue1/view/user/donation.dart';
import 'package:pawrescue1/view/user/drawer/about_us.dart';
import 'package:pawrescue1/view/user/drawer/help.dart';
import 'package:pawrescue1/view/user/report.dart';
import 'package:pawrescue1/view/user/drawer/join_rescue.dart';
import 'package:pawrescue1/view/user/drawer/success.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.buttonColor1,
          title: const Text(
            'PawRescue',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            indicatorWeight: 4.0,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(text: 'Report'),
              Tab(text: 'Donation'),
              Tab(text: 'Adoption/Fostering'),
            ],
          ),
          iconTheme: const IconThemeData(
              color: Colors.white), // Ensure drawer icon is white
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
                leading: const Icon(Icons.star),
                title: const Text('Success Stories'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SuccessStoriesPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.volunteer_activism),
                title: const Text('Join Rescue Team'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => JoinRescueTeamPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('About Us'),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AboutUsPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.help),
                title: const Text('Help'),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HelpPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () async {
                  try {
                    print('=======');
                    // Sign out from AWS Cognito
                    await Amplify.Auth.signOut();

                    // Navigate to login/signup screen
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const UserSignUp()));

                    // Optional: Show success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Logged out successfully')),
                    );
                  } catch (e) {
                    // Handle errors
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Error logging out: ${e.toString()}')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const ReportPage(),
            const DonationPage(),
            AdoptionPage(),
          ],
        ),
      ),
    );
  }
}
