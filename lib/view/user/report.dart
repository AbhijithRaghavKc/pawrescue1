import 'package:flutter/material.dart';
import 'package:pawrescue1/view/const/custom_colors.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _conditionController = TextEditingController();

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Drop your image here"),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.buttonColor1),
                    onPressed: () {},
                    child: const Text(
                      "Upload Files",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ))
              ],
            ),
          ),
          Spacer(),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.buttonColor1),
              onPressed: () {},
              child: const Text(
                'Submit Report',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
