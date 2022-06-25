import 'package:flutter/material.dart';
import 'package:norway_map/map_provider.dart';
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
        ChangeNotifierProvider<MapProvider>(
          create: ((context) => MapProvider()),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
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

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    if (Provider.of<MapProvider>(context).isLoading) {
      Provider.of<MapProvider>(context, listen: false).init();
      return Container();
    }

    return DefaultTabController(
      length: Provider.of<MapProvider>(context, listen: false)
          .config
          .sources
          .length,
      child: Scaffold(
          appBar: TabBar(
            tabs: Provider.of<MapProvider>(context, listen: false)
                .config
                .sources
                .map(
                  (e) => Tab(
                    icon: Container(),
                  ),
                )
                .toList(),
          ),
          body: TabBarView(
            children: Provider.of<MapProvider>(context, listen: false)
                .config
                .sources
                .map((e) => MapView(mapSource: e))
                .toList(),
          )),
    );
  }
}
