import 'package:flutter/material.dart';
import 'package:pawrescue1/view/const/custom_colors.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Image
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/images/aboutus.jpg'),
                  fit: BoxFit.cover,
                ),
                color: CustomColors.buttonColor1,
              ),
              child: Container(
                color: Colors.black.withOpacity(0.4),
                child: const Center(
                  child: Text(
                    'Welcome to PawRescue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // About Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About PawRescue',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'PawRescue is dedicated to helping stray animals by providing shelter, '
                    'medical care, and finding loving homes. Our mission is to ensure that '
                    'every animal gets the chance to live a safe and happy life.',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const SizedBox(height: 20),

                  // Activities Section
                  const Text(
                    'Our Activities',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  _buildActivityItem(
                      Icons.pets, 'Animal rescue and rehabilitation'),
                  _buildActivityItem(
                      Icons.healing, 'Medical care for injured animals'),
                  _buildActivityItem(
                      Icons.home, 'Adoption and fostering programs'),
                  _buildActivityItem(
                      Icons.campaign, 'Community education and awareness'),
                  const SizedBox(height: 20),

                  // Call to Action
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(144, 136, 228, 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Join us in making a difference! Together, we can ensure every animal has a loving home.',
                      style: TextStyle(
                          fontSize: 16, color: CustomColors.buttonColor1),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Activity List Item
  Widget _buildActivityItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: CustomColors.buttonColor1),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
