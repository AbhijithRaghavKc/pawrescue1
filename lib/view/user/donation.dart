import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pawrescue1/view/const/custom_colors.dart';
import 'package:pawrescue1/view/splash.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({Key? key}) : super(key: key);

  @override
  _DonationPageState createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  final TextEditingController _amountController = TextEditingController();
  String selectedPaymentMethod = 'Credit Card';
  double selectedAmount = 0.0;
  bool _isProcessing = false;
  final _firestore = FirebaseFirestore.instance;

  final List<double> donationAmounts = [10, 20, 50, 100, 200];
  Future<void> _saveDonation(double amount) async {
    setState(() => _isProcessing = true);

    try {
      // 1. Get current Cognito user
      final user = await Amplify.Auth.getCurrentUser();
      final userId = user.userId; // This is the Cognito user ID
      print(userId);
      // 2. Get user email
      final attributes = await Amplify.Auth.fetchUserAttributes();
      String? userEmail;

      for (final attribute in attributes) {
        if (attribute.userAttributeKey.key == AuthUserAttributeKey.email.key) {
          userEmail = attribute.value;
          break;
        }
      }

      // 3. Save to Firestore with proper UID
      await _firestore
          .collection('users')
          .doc(userId) // Use the actual user ID
          .collection('donations')
          .add({
        'userId': userId,
        'email': userEmail ?? 'no-email',
        'amount': amount,
        'paymentMethod': selectedPaymentMethod,
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'completed',
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Thank you for donating \$${amount.toStringAsFixed(2)}!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a donation amount:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: donationAmounts.map((amount) {
                return ChoiceChip(
                  label: Text('\$$amount'),
                  selected: selectedAmount == amount,
                  selectedColor: CustomColors.buttonColor1,
                  backgroundColor: Colors.white,
                  side: BorderSide(color: CustomColors.buttonColor1),
                  labelStyle: TextStyle(
                    color:
                        selectedAmount == amount ? Colors.white : Colors.black,
                  ),
                  onSelected: (bool selected) {
                    setState(() {
                      selectedAmount = selected ? amount : 0.0;
                      _amountController.clear();
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter custom amount',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: CustomColors.buttonColor1),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: CustomColors.buttonColor1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: CustomColors.buttonColor1, width: 2.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  selectedAmount = 0.0; // Clear preset amount if custom is used
                });
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Select Payment Method:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: selectedPaymentMethod,
              isExpanded: true,
              items: ['Credit Card', 'PayPal', 'Google Pay', 'Apple Pay']
                  .map((method) {
                return DropdownMenuItem<String>(
                  value: method,
                  child: Text(method),
                );
              }).toList(),
              onChanged: (String? newMethod) {
                setState(() {
                  selectedPaymentMethod = newMethod!;
                });
              },
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _isProcessing
                    ? null
                    : () {
                        final donation = selectedAmount > 0
                            ? selectedAmount
                            : double.tryParse(_amountController.text) ?? 0.0;

                        if (donation > 0) {
                          _saveDonation(donation);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please enter a valid amount')),
                          );
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.buttonColor1,
                  disabledBackgroundColor: Colors.grey,
                ),
                child: _isProcessing
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Donate Now',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
