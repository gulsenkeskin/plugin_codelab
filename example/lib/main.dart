import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:plugin_codelab/plugin_codelab.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _pluginCodelabPlugin = PluginCodelab();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform mesajları eşzamansızdır, bu yüzden async bir method'la başlatıyoruz.

  Future<void> initPlatformState() async {
    String platformVersion;
// Platform mesajları başarısız olabilir, bu yüzden bir try/catch PlatformException kullanıyoruz.
// Ayrıca potansiyel olarak null döndüren mesajı da işliyoruz.
    try {
      platformVersion =
          await _pluginCodelabPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
