import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pawrescue1/amplifyconfiguration.dart';
import 'package:pawrescue1/firebase_options.dart';
import 'package:pawrescue1/view/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configureAmplify();
  runApp(MyApp());
}

final _amplifyInstance = Amplify;

void configureAmplify() async {
  try {
    final authPlugin = AmplifyAuthCognito();
    final storagePlugin = AmplifyStorageS3();

    await _amplifyInstance.addPlugins([authPlugin, storagePlugin]);

    await _amplifyInstance.configure(amplifyconfig);

    print('Amplify successfully configured');
  } catch (e) {
    print(e);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
