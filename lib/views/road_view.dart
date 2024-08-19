/*import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants/routes.dart';
import '../enums/menu_actions.dart';
import '../services/auth/auth_service.dart';


class HappyRoad extends StatefulWidget {
  const HappyRoad({super.key});

  @override
  State<HappyRoad> createState() => _HappyRoadState();
}

class _HappyRoadState extends State<HappyRoad> {
  late MapController _mapController;
  LatLng? _currentPosition;
  List<Marker> _markers = [];
  List<LatLng> _routePoints = [];

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _determinePosition();
    _loadNearbyPlaces();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _mapController.move(_currentPosition!, 13.0);
    });
  }

  void _loadNearbyPlaces() async {
    final response = await http.get(Uri.parse('https://your-api.com/nearby-places?lat=42.8746&lng=74.5698'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _markers = (data['places'] as List).map((place) {
          final lat = place['lat'];
          final lng = place['lng'];
          return Marker(
            point: LatLng(lat, lng),
            child: GestureDetector(
              onTap: () => _onPlaceSelected(LatLng(lat, lng)),
              child: Icon(Icons.location_on, color: Colors.red),
            ),
          );
        }).toList();
      });
    }
  }

  void _onPlaceSelected(LatLng destination) async {
    if (_currentPosition == null) return;

    final response = await http.get(Uri.parse('https://your-api.com/get-route?startLat=${_currentPosition!.latitude}&startLng=${_currentPosition!.longitude}&endLat=${destination.latitude}&endLng=${destination.longitude}'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _routePoints = (data['route'] as List).map((point) {
          return LatLng(point['latitude'], point['longitude']);
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main UI'),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    await AuthService.firebase().logOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      LoginRoute,
                          (_) => false,
                    );
                  }
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text('Log out'),
                ),
              ];
            },
          ),
        ],
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter : _currentPosition ?? LatLng(42.8746, 74.5698),
          maxZoom: 13.0,
          onTap: (tapPosition, latLng) {
            _onPlaceSelected(latLng);
          },
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: _markers,
          ),
          PolylineLayer(
            polylines: [
              Polyline(
                points: _routePoints,
                strokeWidth: 4.0,
                color: Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Sign out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Log out'),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
} */
//AIzaSyAZn5CbCGF5QJZTX845_4eWkwqKE1HJFn8 - idk
//AIzaSyCrV14hN72pJ596fqLIKYxzPOCctSvBS9w - myApi

import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/auth/auth_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


import '../constants/routes.dart';
import '../enums/menu_actions.dart';


class HappyRoad extends StatefulWidget {
  const HappyRoad({super.key});

  @override
  State<HappyRoad> createState() => _HappyRoadState();
}

class _HappyRoadState extends State<HappyRoad> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(42.8746, 74.5698);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main UI'),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    await AuthService.firebase().logOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      LoginRoute,
                          (_) => false,
                    );
                  }
                  break;
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text('Log out'),
                ),
              ];
            },
          ),
        ],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
        markers: {
          const Marker(
            markerId: MarkerId('Bishkek'),
            position: LatLng(42.8746, 74.5698),
          ),
        },
      ),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Sign out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Log out'),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}