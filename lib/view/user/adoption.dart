import 'package:flutter/material.dart';

class AdoptionPage extends StatelessWidget {
  const AdoptionPage({Key? key}) : super(key: key);

  final List<Map<String, String>> animals = const [
    {
      'name': 'Snow',
      'age': '4 months',
      'description': 'Cute and adorable',
      'image': 'assets/images/cat1.jpeg'
    },
    {
      'name': 'Luna',
      'age': '1.5 years',
      'description': 'Friendly and energetic',
      'image': 'assets/images/dog2.jpeg'
    },
    {
      'name': 'Max',
      'age': '1 years',
      'description': 'Loves cuddles and playtime',
      'image': 'assets/images/cat2.jpeg'
    },
    {
      'name': 'Kate',
      'age': '4 years',
      'description': 'Calm and affectionate',
      'image': 'assets/images/dog1.jpeg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: animals.map((animal) {
            return Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Image.asset(
                      animal['image']!,
                      width: 80,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(animal['name']!,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(animal['age']!,
                              style: const TextStyle(color: Colors.grey)),
                          Text(animal['description']!),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Adoption request sent for ${animal['name']}')),
                                  );
                                },
                                child: const Text('Adopt'),
                              ),
                              const SizedBox(width: 10),
                              OutlinedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Fostering request sent for ${animal['name']}')),
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
      ),
    );
  }
}
