import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:pawrescue1/amplifyconfiguration.dart';
import 'package:pawrescue1/view/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureAmplify();
  runApp(MyApp());
}

final _amplifyInstance = Amplify;

void configureAmplify() {
  try {
    AmplifyAuthCognito _amplifyCognito = AmplifyAuthCognito();
    _amplifyInstance.addPlugin(_amplifyCognito);
    _amplifyInstance.configure(amplifyconfig);
    print('Configured');
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
