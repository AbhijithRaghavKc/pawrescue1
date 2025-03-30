import 'dart:io';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pawrescue1/view/const/custom_colors.dart';
import 'package:pawrescue1/view/splash.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _conditionController = TextEditingController();
  dynamic _selectedImage;
  bool _isLoading = false;

  @override
  void dispose() {
    _locationController.dispose();
    _conditionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Report a Stray Animal',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextField(
            controller: _locationController,
            decoration: InputDecoration(
              labelText: 'Location',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: CustomColors.buttonColor1),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: CustomColors.buttonColor1),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(color: CustomColors.buttonColor1, width: 2.0),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _conditionController,
            decoration: const InputDecoration(
              labelText: 'Condition of the Animal',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: CustomColors.buttonColor1),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: CustomColors.buttonColor1),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(color: CustomColors.buttonColor1, width: 2.0),
              ),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 16),

          // **Container for Image Preview**
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              border: Border.all(
                color: CustomColors.buttonColor1,
                width: 1,
              ),
            ),
            padding: const EdgeInsets.all(6),
            child: _selectedImage == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Drop your image here"),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColors.buttonColor1),
                        onPressed: () => pickImage(),
                        child: const Text(
                          "Upload Files",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                : Image.file(
                    _selectedImage!,
                    fit: BoxFit.cover,
                  ), // Show image
          ),

          const Spacer(),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.buttonColor1),
              onPressed: _isLoading ? null : submitReport,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'Submit Report',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // **Function to Pick Image**
  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage =
            File(pickedFile.path); // Update state with selected image
      });
    }
  }

  // **Upload Image to AWS S3 and Store Data**
  Future<void> submitReport() async {
    if (_locationController.text.isEmpty ||
        _conditionController.text.isEmpty ||
        _selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Please fill all fields and upload an image")),
      );
      return;
    }

    setState(() {
      _isLoading = true; // Show loading indicator
    });

    try {
      // **Generate unique file name**
      String fileName = "reports/${DateTime.now().millisecondsSinceEpoch}.jpg";

// **Step 1: Upload Image to S3**
      await Amplify.Storage.uploadFile(
        localFile: AWSFile.fromPath(_selectedImage!.path),
        path: StoragePath.fromString(fileName),
        options: const StorageUploadFileOptions(),
      );

// **Step 2: Get the Public URL**
      final imageUrl =
          "https://pawrescue-imagesccffd-dev.s3.eu-west-1.amazonaws.com/$fileName";

      // https://pawrescue-imagesccffd-dev.s3.eu-west-1.amazonaws.com/reports/1743334747533.jpg

      print("S3 Image URL: $imageUrl");

      // **Step 3: Save Data to Firestore**
      await FirebaseFirestore.instance
          .collection('user')
          .doc(uid)
          .collection('reports')
          .add({
        'location': _locationController.text,
        'condition': _conditionController.text,
        'imageUrl': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // **Step 4: Show Success Message**
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Report submitted successfully!")),
      );

      // **Step 5: Clear Fields**
      _locationController.clear();
      _conditionController.clear();
      setState(() {
        _selectedImage = null;
        _isLoading = false;
      });
    } catch (e) {
      print("Error submitting report: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }
}
