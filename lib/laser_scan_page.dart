import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LaserScannerPage extends StatefulWidget {
  final String title;
  const LaserScannerPage({super.key, required this.title});

  // @override
  // _LaserScannerPageState createState() => _LaserScannerPageState();
  @override
  State<LaserScannerPage> createState() => _LaserScannerPageState();
}

class _LaserScannerPageState extends State<LaserScannerPage> {
  String _scannedCode = '';
  String _buffer = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: KeyboardListener(
        focusNode: FocusNode(),
        // onKey: _handleKeyEvent,
        onKeyEvent: _handleKeyEvent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Scanned Code: $_scannedCode!',
                  style: const TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.enter) {
        setState(() {
          _scannedCode = _buffer;
          _buffer = '';
        });
      } else {
        _buffer += event.character ?? '';
      }
    }
  }
}
