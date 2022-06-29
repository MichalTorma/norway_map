import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:norway_map/loc.dart';
import 'package:norway_map/map_provider.dart';
import 'package:norway_map/map_view.dart';
import 'package:provider/provider.dart';
import 'package:webviewx/webviewx.dart';

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
  late TabController tabController;
  @override
  void initState() {
    Loc? initialLoc;
    print(Uri.base);
    if (Uri.base.queryParametersAll.isNotEmpty) {
      print(jsonEncode(Uri.base.queryParametersAll));
    }

    Provider.of<MapProvider>(context, listen: false)
        .init(initialLoc: initialLoc);
    tabController = TabController(
        length: 1,
        // length: Provider.of<MapProvider>(context, listen: false)
        //     .config
        //     .sources
        //     .length,
        vsync: this);
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        Provider.of<MapProvider>(context, listen: false)
            .changeTab(tabController.index);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Provider.of<MapProvider>(context).isLoading) {
      return Container();
    }

    return Scaffold(
      // appBar: TabBar(
      //   // overlayColor: ,
      //   controller: tabController,
      //   tabs: Provider.of<MapProvider>(context, listen: false)
      //       .config
      //       .sources
      //       .map(
      //         (e) => Tab(
      //           icon: Container(),
      //           text: e.name,
      //         ),
      //       )
      //       .toList(),
      // ),
      body: TabBarView(
        controller: tabController,
        children: Provider.of<MapProvider>(context, listen: false)
            .config
            .sources
            .map((e) => MapView(mapSource: e))
            .toList(),
      ),
      floatingActionButton: WebViewAware(
        child: Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: FloatingActionButton(
            // shape: shapebo,
            mini: true,
            onPressed: () =>
                Provider.of<MapProvider>(context, listen: false).reload(),
            child: const Icon(Icons.home),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
