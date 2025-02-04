import 'package:shake_it/model/cocktail.dart';
import 'package:shake_it/pages/coin_page.dart';
import 'package:shake_it/pages/homepage.dart';
import 'package:shake_it/pages/paired_devices.dart';
import 'package:shake_it/service/bluetooth_configs/bluetooth_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothDeviceHandlePage extends StatefulWidget {
  final BluetoothDevice device;

  const BluetoothDeviceHandlePage({super.key, required this.device});

  @override
  State<BluetoothDeviceHandlePage> createState() =>
      _BluetoothDeviceHandlePageState();
}

class _BluetoothDeviceHandlePageState extends State<BluetoothDeviceHandlePage> {
  BluetoothConnection? _connection;

  @override
  void initState() {
    super.initState();
    _connectToDevice();
  }

  Future<void> _connectToDevice() async {
    try {
      // Establish the Bluetooth connection
      BluetoothConnection connection =
          await BluetoothConnection.toAddress(widget.device.address);

      // Store the connection in a global manager
      BluetoothManager.instance.setConnection(connection, context);

      // Ensure the widget is still mounted before updating state
      if (!mounted) return;

      setState(() {
        _connection = connection;
      });

      // connection.input?.listen((data) {
      //   // Handle incoming data here
      // }).onDone(() {
      //   // Ensure the widget is still mounted before navigation
      //   if (!mounted) return;
      //   Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(builder: (context) => const PairedDevicesPage()),
      //   );
      // });

      // Navigate to HomePage after successful connection
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const HomePage()),
        );
      }
    } catch (e) {
      // Ensure the widget is still mounted before navigation
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PairedDevicesPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
