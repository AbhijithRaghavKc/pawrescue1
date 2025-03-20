import 'package:flutter/material.dart';

class SuccessStoriesPage extends StatelessWidget {
  const SuccessStoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Example list of stories
    final List<Map<String, String>> stories = [
      {
        'title': 'Bella’s Rescue',
        'description':
            'Bella was rescued from the streets and found a loving home.',
      },
      {
        'title': 'Max’s Recovery',
        'description':
            'After medical care, Max made a full recovery and was adopted.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Success Stories'),
      ),
      body: ListView.builder(
        itemCount: stories.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(stories[index]['title']!),
              subtitle: Text(stories[index]['description']!),
            ),
          );
        },
      ),
    );
  }
}
