class LocationModel {
  final String id;
  final double latitude;
  final double longitude;
  final String? address;
  final String? googleMapsUrl;
  final DateTime updatedAt;

  LocationModel({
    required this.id,
    required this.latitude,
    required this.longitude,
    this.address,
    this.googleMapsUrl,
    required this.updatedAt,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      address: json['address'],
      googleMapsUrl: json['googlemapsurl'] ?? json['googleMapsUrl'], // Handle both possible keys
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'googlemapsurl': googleMapsUrl,
      'updated_at': updatedAt.toIso8601String(),
    };
  }
} 