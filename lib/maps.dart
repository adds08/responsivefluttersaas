import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final _search = TextEditingController();
  final _mapController = MapController();
  List<LatLng> tappedPoints = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              SizedBox(
                child: TextField(
                  controller: _search,
                ),
                width: 200,
              ),
              MaterialButton(child: const Text("Search"), onPressed: () {})
            ],
          ),
        ),
        Expanded(
          flex: 9,
          child: SizedBox(
            height: 500,
            width: 800,
            child: FlutterMap(
              mapController: _mapController,
              children: const [Text("HI APEK")],
              options: MapOptions(
                center: LatLng(27.70, 85.3),
                zoom: 13.0,
                onTap: (tapPosition, point) {
                  setState(() {
                    tappedPoints.add(point);
                  });
                },
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                  attributionBuilder: (_) {
                    return const Text("© OpenStreetMap contributors");
                  },
                ),
                MarkerLayerOptions(
                  markers: tappedPoints.map((e) {
                    return Marker(
                      width: 60.0,
                      height: 60.0,
                      point: e,
                      builder: (ctx) => GestureDetector(
                        onTap: () {
                          print("Latitude : ${e.latitude}");
                          print("Longitude : ${e.longitude}");
                        },
                        child: Container(
                          child: FlutterLogo(),
                        ),
                      ),
                    );
                  }).toList(),
                  // markers: [
                  //   // Marker(width: 80.0, height: 80.0, point: LatLng(27.70, 85.3), builder: (ctx) => Text("Apek is here")),

                  // ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
