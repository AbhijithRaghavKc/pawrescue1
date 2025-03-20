import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        backgroundColor: Color.fromRGBO(144, 136, 228, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Need Assistance?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'If you have any issues or questions, feel free to reach out to us using the following options:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            _buildHelpOption(
                Icons.email, 'Contact Us via Email', 'support@pawrescue.com'),
            _buildHelpOption(Icons.phone, 'Call Us', '+1 (123) 456-7890'),
            _buildHelpOption(
                Icons.help_outline, 'FAQs', 'Get answers to common questions'),
            _buildHelpOption(
                Icons.feedback, 'Send Feedback', 'We value your thoughts!'),
            const SizedBox(height: 40),
            const Center(
              child: Text(
                'We’re here to help you 24/7!',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Help Option Card
  Widget _buildHelpOption(IconData icon, String title, String subtitle) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Color.fromRGBO(144, 136, 228, 1)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        onTap: () {},
      ),
    );
  }
}
