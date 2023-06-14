class MapFileData {
  final String url;
  final String fileName;
  final String displayedName;
  final String theme;
  final double initialPositionLat;
  final double initialPositionLong;
  final int initialZoomLevel;
  final String? relativePathPrefix;
  final MAPTYPE mapType;

  final bool indoorZoomOverlay;

  final Map<int, String>? indoorLevels;

  const MapFileData({
    required this.url,
    required this.fileName,
    required this.displayedName,
    required this.initialPositionLat,
    required this.initialPositionLong,
    this.theme = "assets/render_themes/custom.xml",
    this.relativePathPrefix,
    this.initialZoomLevel = 16,
    this.indoorZoomOverlay = false,
    this.indoorLevels,
  }) : mapType = MAPTYPE.OFFLINE;

  MapFileData.online({
    required this.displayedName,
    required this.initialPositionLat,
    required this.initialPositionLong,
    this.initialZoomLevel = 14,
    this.indoorZoomOverlay = false,
    this.indoorLevels,
  })  : url = "unused",
        fileName = "unused",
        theme = "online",
        relativePathPrefix = null,
        mapType = MAPTYPE.OSM;

  MapFileData copyWith({
    String? url,
    String? fileName,
    String? displayedName,
    String? theme,
    double? initialPositionLat,
    double? initialPositionLong,
    int? initialZoomLevel,
    String? relativePathPrefix,
    MAPTYPE? mapType,
    bool? indoorZoomOverlay,
    Map<int, String>? indoorLevels,
  }) {
    return MapFileData(
        url: url ?? this.url,
        fileName: fileName ?? this.fileName,
        displayedName: displayedName ?? this.displayedName,
        initialPositionLat: initialPositionLat ?? this.initialPositionLat,
        initialPositionLong: initialPositionLong ?? this.initialPositionLong,
        indoorLevels: indoorLevels ?? this.indoorLevels,
        indoorZoomOverlay: indoorZoomOverlay ?? this.indoorZoomOverlay,
        initialZoomLevel: initialZoomLevel ?? this.initialZoomLevel,
        relativePathPrefix: relativePathPrefix ?? this.relativePathPrefix,
        theme: theme ?? this.theme);
  }

  MapFileData.onlineSatellite({
    required this.displayedName,
    required this.initialPositionLat,
    required this.initialPositionLong,
    this.initialZoomLevel = 14,
    this.indoorZoomOverlay = false,
    this.indoorLevels,
  })  : url = "unused",
        fileName = "unused",
        theme = "unused",
        relativePathPrefix = null,
        mapType = MAPTYPE.ARCGIS;
}

/////////////////////////////////////////////////////////////////////////////

enum MAPTYPE {
  // No Onlinemap --> We use offline-maps
  OFFLINE,
  // OpenStreetMap
  OSM,
  // ArcGis Map
  ARCGIS,
}
