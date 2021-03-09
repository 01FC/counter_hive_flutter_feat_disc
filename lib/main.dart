import 'package:counter_hive/home_page.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // inicializar hive
  await Hive.initFlutter();
  // abrir la box donde gardaremos o leeremos datos
  await Hive.openBox<int>("la_cuenta");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FeatureDiscovery(child: HomePage()),
    );
  }
}
