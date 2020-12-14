import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform =
      const MethodChannel('com.facegraph.download_new_apk/ota');

  Future<void> _downloadNewRelease() async {
    try {
      if (apkUrl == null || apkUrl.isEmpty) return;
      await platform.invokeMethod("downloadAPK", {'url': apkUrl});
    } on PlatformException catch (e) {
      print("Failed to get download new APK : '${e.message}'.");
    }
  }

  String apkUrl = "https://storageaccountrgsmi8b17.blob.core.windows.net/uploaded-apks/app-release-v2.apk";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
        children: [
          Text("App Version 1 with blue style"),
          TextFormField(
            autofocus: false,
            initialValue: apkUrl,
            decoration: InputDecoration(
              hintText: 'APK url',
            ),
            onChanged: (val) {
              setState(() {
                apkUrl = val;
              });
            },
          ),
          RaisedButton(
            child: Text(
              "Downlaod",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blue,
            onPressed: _downloadNewRelease,
          ),
        ],
      )),
    );
  }
}
