import 'dart:async';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: 'AIzaSyCV7M3g1RxYyMXxd7wDaAp_F_YXHfPW14Q',
            appId: '1:239189465709:android:6421b172c44766d4bbbd64',
            storageBucket: 'library-system-6ef13.appspot.com',
            messagingSenderId: '239189465709',
            projectId: 'library-system-6ef13'));
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late int _dotCount;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _dotCount = 1;
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if (_dotCount < 3) {
        setState(() {
          _dotCount++;
        });
      } else {
        _timer.cancel();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 180.0,
              height: 180.0,
              child: CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage(
                  "assets/librario.jpg",
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 10.0,
                  height: 10.0,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _dotCount == index + 1 ? Colors.black : Colors.grey,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
