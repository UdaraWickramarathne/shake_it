import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:developer' as dev;

class BluetoothManager {
  static final BluetoothManager _instance = BluetoothManager._internal();
  static BluetoothManager get instance => _instance;

  BluetoothConnection? _connection;

  BluetoothConnection? get connection => _connection;
  bool get isConnected => _connection?.isConnected ?? false;
  VoidCallback? onConnectionStateChanged;
  int count = 0;

  BluetoothManager._internal();

  void setConnection(BluetoothConnection connection) {
    _connection = connection;
    if (onConnectionStateChanged != null) {
      onConnectionStateChanged!();
    }
  }

  Future<void> sendMessage(String message) async {
    if (_connection?.isConnected ?? false) {
      _connection!.output.add(Uint8List.fromList(utf8.encode("$message\r\n")));
      await _connection!.output.allSent;
    }
  }

  Future<void> disconnectDevice() async {
    if (_connection == null) {
      dev.log('Already disconnected.');
      return;
    }

    // Lock to prevent multiple disconnections
    final lock = Object();
    await Future.sync(() => lock);

    dev.log('Disconnecting from device $count');
    count++;
    try {
      await _connection!.finish();
      _connection = null;
      onConnectionStateChanged?.call();
    } catch (e) {
      debugPrint('Disconnection failed: $e');
    } finally {
      // Release lock
      lock.toString();
    }
  }
}
