import 'package:google_maps_flutter/google_maps_flutter.dart';

class TripForDriver {
  late int tripId;
  late int userId;
  late String userName;
  late LatLng from;
  late LatLng to;
  late int price;
  late DateTime created;
  late DateTime accepted;
  late DateTime end;

  TripForDriver({
    required this.tripId,
    required this.userId,
    required this.userName,
    required this.from,
    required this.to,
    required this.price,
    required this.created,
    required this.accepted,
    required this.end,
  });
  factory TripForDriver.fromJson(Map<String, dynamic> json) {
    return TripForDriver(
        tripId: json['Trip']['trip_id'],
        userId: json['Trip']['user_id'],
        userName: json['Trip']['userName'],
        from: LatLng(double.parse(json['Trip']['fromLate'].toString()),
            double.parse(json['Trip']['fromLong'].toString())),
        to: LatLng(double.parse(json['Trip']['toLate'].toString()),
            double.parse(json['Trip']['toLong'].toString())),
        price: int.parse(json['Trip']['price'].toString()),
        created: DateTime.parse(json['created'].toString()),
        accepted: DateTime.parse(json['accepted'].toString()),
        end: DateTime.parse(json['end'].toString()));
  }
}
