import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'constants.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // referencia a la box para hacer operaciones de lectura y ecritura
  Box<int> _box;
  @override
  void initState() {
    _box = Hive.box<int>("la_cuenta");
    SchedulerBinding.instance
        .addPostFrameCallback((timeStamp) => _showDiscovery());
    super.initState();
  }

  _showDiscovery() async {
    FeatureDiscovery.clearPreferences(context, {
      // feature ids de los elementos a mostarar en orden deseado
      feature1,
      feature2,
    });

    FeatureDiscovery.discoverFeatures(context, {
      // feature ids de los elementos a mostarar en orden deseado
      feature1,
      feature2,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material App Bar'),
      ),
      body: Center(
        child: ValueListenableBuilder<Box<int>>(
          valueListenable: _box.listenable(),
          builder: (context, myBox, _) {
            //  leer dato guardados del contador
            return Text("${myBox.get("counter", defaultValue: 0)}");
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DescribedFeatureOverlay(
            featureId: feature1,
            tapTarget: Icon(Icons.add),
            backgroundOpacity: 0.7,
            description: Text("Boton para incrementar la cuenta"),
            child: FloatingActionButton(
              onPressed: () {
                // leer el valor de counter y guardarlo sumandole 1
                _box.put("counter", _box.get("counter", defaultValue: 0) + 1);
              },
              child: Icon(Icons.add),
              tooltip: "Incrementar contador",
            ),
          ),
          SizedBox(height: 16),
          DescribedFeatureOverlay(
            featureId: feature2,
            tapTarget: Icon(Icons.remove),
            backgroundOpacity: 0.7,
            description: Text("Boton para restar la cuenta"),
            child: FloatingActionButton(
              onPressed: () {
                // leer el valor de counter y guardarlo sumandole -1
                _box.put("counter", _box.get("counter", defaultValue: 0) - 1);
              },
              child: Icon(Icons.remove),
              tooltip: "Restar contador",
            ),
          ),
        ],
      ),
    );
  }
}
