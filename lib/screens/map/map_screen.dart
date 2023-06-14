import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:ship_management/repositories/location_repository.dart';
import 'package:ship_management/services/location/location_service.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';
import 'package:vector_mbtiles/vector_mbtiles.dart';
import 'package:vector_tile_renderer/vector_tile_renderer.dart';
import 'package:vector_tile_renderer/vector_tile_renderer.dart'
    as vector_tile_renderer;
import 'osm_bright_ja_style.dart';
import 'package:ship_management/screens/map/map_controller.dart';
import 'package:ship_management/theme/dimens.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LocationData? _currentLocation;
  MapController _mapController = MapController();
  bool _liveUpdate = true;
  bool showPoly = true;
  List<LatLng> listLatLng = [];
  int interActiveFlags = InteractiveFlag.all;
  LatLng rootLocation = LatLng(0, 0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(Duration(seconds: 10), () async {
        await loadPolyGone();
        initLocationService();
      });
    });
  }

  Future<void> loadPolyGone() async {
    final listLC = await LocationRepository.locations;
    if (listLC.isNotEmpty) {
      listLC.forEach((element) {
        listLatLng.add(LatLng(element.lat, element.lng));
      });
      setState(() {
        rootLocation = listLatLng.first;
      });
    }
  }

  void initLocationService() async {
    final locationss = LocationService.instanceLocation;
    locationss.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 1000,
    );
    LocationData? location;
    location = await locationss.getLocation();
    _currentLocation = location;
    _mapController.move(
        LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
        _mapController.zoom);
    setState(() {
      rootLocation =
          LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!);
    });

    locationss.onLocationChanged.listen((LocationData result) async {
      if (mounted) {
        setState(() {
          _currentLocation = result;
          listLatLng.add(LatLng(
              _currentLocation!.latitude!, _currentLocation!.longitude!));
          // If Live Update is enabled, move map center
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    LatLng currentLatLng;

    if (_currentLocation != null) {
      currentLatLng =
          LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!);
    } else {
      currentLatLng = LatLng(0, 0);
    }
    final markers = <Marker>[
      Marker(
          rotate: true,
          width: 24,
          height: 24,
          point: rootLocation,
          builder: (ctx) => const Icon(
                Icons.gps_fixed_sharp,
                color: Colors.blue,
                size: 24,
              )),
      Marker(
          rotate: true,
          width: 80,
          height: 80,
          point: currentLatLng,
          builder: (ctx) => const Icon(
                Icons.location_on,
                color: Colors.red,
                size: 48,
              )),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () async {
                _mapController.move(
                    LatLng(_currentLocation!.latitude!,
                        _currentLocation!.longitude!),
                    _mapController.zoom);
              },
              child: Icon(Icons.gps_fixed),
            ),
            ElevatedButton(

              onPressed: () async {
                setState(() {
                  showPoly = !showPoly;
                });
              },
              child: showPoly
                  ? Icon(Icons.disabled_visible)
                  : Icon(Icons.remove_red_eye),
            ),
          ],
        ),
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: currentLatLng,
          zoom: 10,
          maxZoom: 20,
          minZoom: 2,
        ),
        children: [
          VectorTileLayer(
            key: const Key('VectorTileLayerWidget'),
            theme: _mapTheme(context),
            tileProviders: TileProviders(
                {'openmaptiles': _cachingTileProvider(_basemapPath())}),
          ),
          MarkerLayer(markers: markers),
          Visibility(
            visible: showPoly,
            child: PolylineLayer(
              polylines: [
                Polyline(
                  strokeWidth: 6,
                  points: listLatLng,
                  color: Colors.amberAccent,
                ),
              ],
            ),
          ),
        ],
        nonRotatedChildren: const [],
      ),
    );
  }

  VectorTileProvider _cachingTileProvider(String mbtilesPath) {
    return MemoryCacheVectorTileProvider(
        delegate: VectorMBTilesProvider(
            mbtilesPath: mbtilesPath,
            // this is the maximum zoom of the provider, not the
            // maximum of the map. vector tiles are rendered
            // to larger sizes to support higher zoom levels
            maximumZoom: 14),
        maxSizeBytes: 1024 * 1024 * 2);
  }

  // showPloyGone() {
  //   return Visibility(
  //     visible: showPoly,
  //     child: PolylineLayer(
  //       polylines: [
  //         Polyline(
  //           strokeWidth: 6,
  //           points: listLatLng,
  //           color: Colors.amberAccent,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  _mapTheme(BuildContext context) {
    // maps are rendered using themes
    // to provide a dark theme do something like this:
    // if (MediaQuery.of(context).platformBrightness == Brightness.dark) return myDarkTheme();
    return OSMBrightTheme.osmBrightJaTheme();
  }

  String _basemapPath() {
    return 'assets/example.mbtiles';
  }
}

extension OSMBrightTheme on ProvidedThemes {
  static vector_tile_renderer.Theme osmBrightJaTheme({Logger? logger}) =>
      ThemeReader(logger: logger).read(osmBrightJaStyle());
}
