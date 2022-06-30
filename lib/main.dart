import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:norway_map/map_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MapController>(
          create: ((context) => MapController()),
        )
      ],
      child: MaterialApp(
        title: 'Norway map kiosk',
        theme: ThemeData(
            // primarySwatch:
            // 1b7b60
            ),
        home: const MyHomePage(title: 'Norway map kiosk'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const MapView(),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () => {},
        child: const Icon(Icons.home),
      ),
    );
  }
}
