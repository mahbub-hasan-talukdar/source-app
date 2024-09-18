import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:source_app/src/messages.g.dart';

void main() {
  runApp(SourceApp());
}

class SourceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Source',
      home: SourceHomePage(),
    );
  }
}

class SourceHomePage extends StatefulWidget {
  @override
  _SourceHomePageState createState() => _SourceHomePageState();
}

class _SourceHomePageState extends State<SourceHomePage> {
  static const platform = MethodChannel('com.example.source_app/navigate');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Source App'),
      ),
      body: Center(
        child: TextButton(
          onPressed: _navigateDestination,
          child: Text('Navigate to Destination App'),
        ),
      ),
    );
  }

  Future<void> _navigateDestination() async {
    try {
      const message =
          'https://i0.wp.com/www.memelate.com/wp-content/uploads/2021/07/23_Moti-Mia_Aj-robibar_Bangla-Meme-Template.png?fit=640%2C446&ssl=1';
      // await platform.invokeMethod('openDestinationApp', {'message': message});
      final ExampleHostApi _api = ExampleHostApi();
      await _api.sendMessage(message);
    } on PlatformException catch (e) {
      print("Failed to open destination app: '${e.message}'.");
    }
  }
}
