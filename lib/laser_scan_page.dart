// ignore_for_file: avoid_print, unused_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LaserScannerPage extends StatefulWidget {
  @override
  _LaserScannerPageState createState() => _LaserScannerPageState();
}

class _LaserScannerPageState extends State<LaserScannerPage> {
  final TextEditingController _controller = TextEditingController();
  String _scannedCode = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _scannedCode += _controller.text;
        // _scannedCode += '${_controller.text}\n'; // ต่อ string ด้วย \n (return/enter)
        print(_scannedCode);
      });
      _controller.clear();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Laser Scanner')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              autofocus: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Scan a barcode',
              ),
            ),
            SizedBox(height: 20),
            Text('Scanned Code: $_scannedCode', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
