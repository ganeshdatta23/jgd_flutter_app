import 'dart:math';

import 'package:vector_math/vector_math.dart';

class Haversine {
  static double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371e3; // metres
    final phi1 = radians(lat1);
    final phi2 = radians(lat2);
    final deltaPhi = radians(lat2 - lat1);
    final deltaLambda = radians(lon2 - lon1);

    final a = sin(deltaPhi / 2) * sin(deltaPhi / 2) +
        cos(phi1) * cos(phi2) *
        sin(deltaLambda / 2) * sin(deltaLambda / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1-a));

    final d = R * c;
    return d;
  }

  static double calculateBearing(double lat1, double lon1, double lat2, double lon2) {
    final phi1 = radians(lat1);
    final lambda1 = radians(lon1);
    final phi2 = radians(lat2);
    final lambda2 = radians(lon2);

    final y = sin(lambda2 - lambda1) * cos(phi2);
    final x = cos(phi1) * sin(phi2) -
        sin(phi1) * cos(phi2) * cos(lambda2 - lambda1);
    final theta = atan2(y, x);

    return (degrees(theta) + 360) % 360; // in degrees
  }
} 