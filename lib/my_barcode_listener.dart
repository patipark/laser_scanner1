import 'dart:io';

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';


class MyBarcodeListener extends StatefulWidget {
  const MyBarcodeListener({super.key, required this.title});

  final String title;

  @override
  State<MyBarcodeListener> createState() => _MyBarcodeListenerState();
}

class _MyBarcodeListenerState extends State<MyBarcodeListener> {
  String? _barcode;
  late bool visible;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Add visiblity detector to handle barcode
        // values only when widget is visible
        child: VisibilityDetector(
          onVisibilityChanged: (VisibilityInfo info) {
            visible = info.visibleFraction > 0;
          },
          key: const Key('visible-detector-key'),
          child: BarcodeKeyboardListener(
            bufferDuration: const Duration(milliseconds: 200),
            onBarcodeScanned: (barcode) {
              if (!visible) return;
              // ignore: avoid_print
              print(barcode);
              setState(() {
                _barcode = barcode;
              });
            },
            useKeyDownEvent: Platform.isWindows,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  _barcode == null ? 'SCAN BARCODE' : 'BARCODE: $_barcode',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
