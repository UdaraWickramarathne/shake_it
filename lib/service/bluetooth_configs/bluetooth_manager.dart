import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:provider/provider.dart';
import 'package:shake_it/service/bluetooth_configs/bluetooth_data_provider.dart';

class BluetoothManager {
  static final BluetoothManager _instance = BluetoothManager._internal();
  static BluetoothManager get instance => _instance;

  BluetoothConnection? _connection;

  BluetoothConnection? get connection => _connection;
  bool get isConnected => _connection?.isConnected ?? false;
  VoidCallback? onConnectionStateChanged;

  BluetoothManager._internal();

  void setConnection(BluetoothConnection connection, BuildContext context) {
    _connection = connection;
    final bluetoothDataProvider =
        Provider.of<BluetoothDataProvider>(context, listen: false);

    // Listen to the input stream of the connection and forward data
    _connection!.input!.listen(
      (data) {
        String coinInput = String.fromCharCodes(data).trim();
        // dev.log('Received coin data: $coinInput');

        bluetoothDataProvider.updateData(coinInput);
      },
      onDone: () {},
      onError: (error) {
        debugPrint('Input stream error: $error');
      },
    );

    if (onConnectionStateChanged != null) {
      onConnectionStateChanged!();
    }
  }

  Future<void> sendMessage(String message) async {
    if (_connection?.isConnected ?? false) {
      _connection!.output.add(Uint8List.fromList(utf8.encode("$message\r\n")));
      await _connection!.output.allSent;
    } else {
      debugPrint('Cannot send message, no active connection.');
    }
  }

  Future<void> disconnectDevice() async {
    if (_connection == null) {
      dev.log('Already disconnected.');
      return;
    }

    try {
      dev.log('Disconnecting device...');
      await _connection!.finish();
    } catch (e) {
      debugPrint('Error during disconnection: $e');
    } finally {
      // Clear connection and close input stream controller
      _connection = null;

      onConnectionStateChanged?.call();
      dev.log('Device disconnected.');
    }
  }
}
