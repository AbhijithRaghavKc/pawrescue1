import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SuccessStoriesPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  SuccessStoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Success Stories'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collectionGroup('reports').snapshots(),
        builder: (context, snapshot) {
          // Handle loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Handle error state
          if (snapshot.hasError) {
            return const Center(child: Text('Error: Something occurred'));
          }

          // Check if snapshot has data
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No data available'));
          }

          // Extract and filter completed stories
          final stories = snapshot.data!.docs.where((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return data['status'] == 'completed';
          }).toList();

          // Handle empty completed stories
          if (stories.isEmpty) {
            return const Center(child: Text('No completed stories available'));
          }

          // Build the ListView
          return ListView.builder(
            itemCount: stories.length,
            itemBuilder: (context, index) {
              final document = stories[index];
              final animal = document.data() as Map<String, dynamic>;

              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(animal['imageUrl']),
                ),
                title: Text(animal['location']),
                subtitle: Text(
                  'Rescue date: ${animal['updatedAt'] != null ? (animal['updatedAt'] as Timestamp).toDate() : 'Unknown'}',
                ),
              );
            },
          );
        },
      ),
    );
  }
}
