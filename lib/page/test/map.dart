import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  final LatLng _defaultLocation = LatLng(10.762622, 106.660172); // Vị trí mặc định ở Hồ Chí Minh

  @override
  void initState() {
    super.initState();
    // Không cần lấy vị trí hiện tại nữa
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Bản đồ với OpenStreetMap'),
      ),
      child: SafeArea(
        child: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            center: _defaultLocation, // Sử dụng vị trí mặc định
            zoom: 13.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: _defaultLocation, // Đánh dấu vị trí mặc định
                  builder: (ctx) => Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(CupertinoApp(
    home: MapScreen(),
  ));
}