import 'package:shake_it/pages/bluetooth_enable.dart';
import 'package:shake_it/pages/paired_devices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkBluetoothState();
  }

  Future<void> _checkBluetoothState() async {
    bool? isEnabled = await FlutterBluetoothSerial.instance.isEnabled;
    if (!mounted) return;
    if (isEnabled == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PairedDevicesPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BluetoothEnablePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Lottie.asset('assets/spalsh.json'),
            const Text(
              'Shake It Up',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Color.fromARGB(255, 85, 85, 85),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
