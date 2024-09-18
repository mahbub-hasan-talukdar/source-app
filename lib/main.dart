import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
          'https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg';
      await platform.invokeMethod('openDestinationApp', {'message': message});
    } on PlatformException catch (e) {
      print("Failed to open destination app: '${e.message}'.");
    }
  }
}
