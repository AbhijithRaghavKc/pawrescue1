import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdoptionPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AdoptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collectionGroup('reports').snapshots(),
        builder: (context, snapshot) {
          print('////////');
          print(snapshot.data!.docs);
          final completedReports = snapshot.data!.docs.where((doc) {
            return doc['status'] == 'completed';
          }).toList();
          print('********');
          print(completedReports);
          // Handle loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Handle error state
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: Something occured'),
            );
          }

          // Handle empty state
          if (completedReports.isEmpty) {
            return const Center(
              child: Text('No animals available for adoption'),
            );
          }

          // Display data
          return SingleChildScrollView(
            child: Column(
              children: completedReports.map((document) {
                final animal = document.data() as Map<String, dynamic>;

                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        // Animal Image
                        animal['imageUrl'] != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  animal['imageUrl'],
                                  width: 80,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 80,
                                      height: 100,
                                      color: Colors.grey[200],
                                      child: const Icon(Icons.pets),
                                    );
                                  },
                                ),
                              )
                            : Container(
                                width: 80,
                                height: 100,
                                color: Colors.grey[200],
                                child: const Icon(Icons.pets),
                              ),

                        const SizedBox(width: 16),

                        // Animal Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                animal['name'] ?? 'Unnamed Animal',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                animal['age'] ?? 'Age not specified',
                                style: const TextStyle(color: Colors.grey),
                              ),
                              Text(
                                animal['description'] ??
                                    'No description available',
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      _showAdoptionConfirmation(
                                        context,
                                      );
                                    },
                                    child: const Text('Adopt'),
                                  ),
                                  const SizedBox(width: 10),
                                  OutlinedButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Fostering request sent for ${animal['name'] ?? 'this animal'}',
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text('Foster'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }

  void _showAdoptionConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Adoption Confirmation'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Happy for your decision to adopt!'),
              const SizedBox(height: 16),
              const Text('Kindly contact us at:'),
              const SizedBox(height: 8),
              const Text(
                '📞 +1 (555) 123-4567',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
