import 'dart:async';

import 'package:shake_it/pages/bluetooth_device_handle_page.dart';
import 'package:shake_it/service/bluetooth_configs/bluetooth_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class PairedDevicesPage extends StatefulWidget {
  const PairedDevicesPage({super.key});

  @override
  State<PairedDevicesPage> createState() => _PairedDevicesPageState();
}

class _PairedDevicesPageState extends State<PairedDevicesPage> {
  List<BluetoothDevice> _devices = [];

  @override
  void initState() {
    super.initState();
    _getPairedDevices();
  }

  Future<void> _getPairedDevices() async {
    List<BluetoothDevice> devices =
        await FlutterBluetoothSerial.instance.getBondedDevices();
    setState(() {
      _devices = devices;
    });
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    try {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BluetoothDeviceHandlePage(device: device),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Connection failed: ${e.toString()}')),
        );
      }
    }
  }

  @override
  void dispose() {
    BluetoothManager.instance.onConnectionStateChanged = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Paired Devices', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: _devices.isEmpty
          ? const Center(
              child: Text(
                'No paired devices found',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: _devices.length,
              itemBuilder: (context, index) {
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Icon(
                            Icons.bluetooth,
                            color: Colors.teal,
                            size: 30,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _devices[index].name ?? 'Unknown',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    BluetoothManager.instance.isConnected
                                        ? 'Connected'
                                        : 'Not Connected',
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ElevatedButton(
                                    onPressed:
                                        BluetoothManager.instance.isConnected
                                            ? () async {
                                                await BluetoothManager.instance
                                                    .disconnectDevice();
                                                if (mounted) {
                                                  setState(
                                                      () {}); // Update the UI only if the widget is still active
                                                }
                                              }
                                            : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    child: const Text(
                                      'Disconnect',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  ElevatedButton(
                                    onPressed: BluetoothManager
                                            .instance.isConnected
                                        ? null
                                        : () =>
                                            _connectToDevice(_devices[index]),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal,
                                    ),
                                    child: const Text(
                                      'Connect',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
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
              },
            ),
    );
  }
}
