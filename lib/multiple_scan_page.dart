import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MultiInputScannerPage extends StatefulWidget {
 
  @override
  _MultiInputScannerPageState createState() => _MultiInputScannerPageState();
}

class _MultiInputScannerPageState extends State<MultiInputScannerPage> {
  final TextEditingController _controller = TextEditingController();
  String _scannedCode = '';
  String _buffer = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    if (_controller.text.endsWith('\n')) {
      setState(() {
        _scannedCode = _controller.text.trim();
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
      appBar: AppBar(title: Text('Multi-Input Scanner')),
      body: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: _handleKeyEvent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Scan or Enter Code',
                ),
              ),
              SizedBox(height: 20),
              Text('Scanned/Entered Code: $_scannedCode',
                  style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }

  void _handleKeyEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
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
