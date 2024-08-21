import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sample_plugin_flutter/sample_plugin_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // set method channel name, this method is connect with channel in plugin
    const MethodChannel channel = MethodChannel('sample_plugin_flutter');
    // handle function from method channel call from native plugin
    channel.setMethodCallHandler((call) async {
      if (call.method == "method_from_native") {
        print(call.arguments);
        print("successfully call channel from native");
      }
      return;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Phần 2. Hướng dẫn tạo Widget với plugin
              SampleButton(
                text: "Sample Button",
                onPressed: () {
                  print("Sample Button Click");
                },
              ),
              FutureBuilder<String?>(
                future: SampleCallNativeFlutter.platformVersion,
                builder: (_, snapshoot) {
                  return Text(snapshoot.data ?? '');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
