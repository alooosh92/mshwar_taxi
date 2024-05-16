import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../../models/show_trip.dart';
import '../../res/color_manager.dart';
import '../../res/font_manager.dart';
import '../../widget/drawer_home.dart';
import '../../widget/progress_def.dart';
import '../trip/trip_controller.dart';

class UserTrip extends StatefulWidget {
  const UserTrip({super.key});

  @override
  State<UserTrip> createState() => _UserTripState();
}

class _UserTripState extends State<UserTrip> {
  @override
  Widget build(BuildContext context) {
    var storge = GetStorage();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_forward_ios_outlined))
        ],
        title: const Text(
          "رحلاتي",
          style: FontManager.w600s24cB,
        ),
        centerTitle: true,
      ),
      drawer: DrawerHome(),
      body: storge.read('roll') == 'user'
          ? const TripForUser()
          : const TripForDriver(),
    );
  }
}

class TripForUser extends StatelessWidget {
  const TripForUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TripController tripController = Get.find();
    return FutureBuilder<List<ShowTrip>>(
      future: tripController.getUserTrips(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ProgressDef();
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            snapshot.data!.sort((a, b) => b.created.compareTo(a.created));
            return FutureBuilder<Map<String, String?>>(
                future: getAdress(
                    snapshot.data![index].fromLate,
                    snapshot.data![index].fromLong,
                    snapshot.data![index].toLate,
                    snapshot.data![index].toLong),
                builder: (context, address) {
                  if (address.connectionState == ConnectionState.waiting) {
                    return const ProgressDef();
                  }
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: 180,

                      //230
                      child: Card(
                        color: Colors.white,
                        elevation: 10,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                            side: BorderSide(
                                color: ColorManager.primary, width: 1.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    ' كود الرحلة :',
                                    style: FontManager.w500s17cB,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    snapshot.data![index].id.toString(),
                                    style: FontManager.w500s17cB,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    ' من : ',
                                    style: FontManager.w500s17cB,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(address.data!['from']!),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'الى : ',
                                    style: FontManager.w500s17cB,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(address.data!['to']!)
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'تاريخ الرحلة : ',
                                    style: FontManager.w500s17cB,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    DateFormat('yyyy/MM/dd - hh:mm')
                                        .format(snapshot.data![index].created),
                                    style: FontManager.w500s17cB,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'المبلغ ',
                                    style: FontManager.w400s17cP,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    snapshot.data![index].price
                                        .toInt()
                                        .toString(),
                                    style: FontManager.w500s17cB,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              // const RouteButton(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          },
        );
      },
    );
  }
}

class TripForDriver extends StatelessWidget {
  const TripForDriver({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TripController tripController = Get.find();
    return FutureBuilder(
      future: tripController.getDriverTrips(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ProgressDef();
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            snapshot.data!.sort((a, b) => b.created.compareTo(a.created));
            return FutureBuilder<Map<String, String?>>(
                future: getAdress(
                    snapshot.data![index].from.latitude,
                    snapshot.data![index].from.longitude,
                    snapshot.data![index].to.latitude,
                    snapshot.data![index].to.longitude),
                builder: (context, address) {
                  if (address.connectionState == ConnectionState.waiting) {
                    return const ProgressDef();
                  }
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: 230,
                      child: Card(
                        color: Colors.white,
                        elevation: 10,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                            side: BorderSide(
                                color: ColorManager.primary, width: 1.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        ' كود الرحلة :',
                                        style: FontManager.w500s17cB,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        snapshot.data![index].tripId.toString(),
                                        style: FontManager.w500s17cB,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        ' كود المستخدم :',
                                        style: FontManager.w500s17cB,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        snapshot.data![index].userId.toString(),
                                        style: FontManager.w500s17cB,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    ' من : ',
                                    style: FontManager.w500s17cB,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(address.data!['from']!),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'الى : ',
                                    style: FontManager.w500s17cB,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(address.data!['to']!)
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'تاريخ الإنشاء : ',
                                    style: FontManager.w500s17cB,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    DateFormat('yyyy/MM/dd - hh:mm')
                                        .format(snapshot.data![index].created),
                                    style: FontManager.w500s17cB,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'تاريخ القبول : ',
                                    style: FontManager.w500s17cB,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    DateFormat('yyyy/MM/dd - hh:mm')
                                        .format(snapshot.data![index].accepted),
                                    style: FontManager.w500s17cB,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'تاريخ الإنهاء : ',
                                    style: FontManager.w500s17cB,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    DateFormat('yyyy/MM/dd - hh:mm')
                                        .format(snapshot.data![index].end),
                                    style: FontManager.w500s17cB,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'المبلغ ',
                                    style: FontManager.w400s17cP,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    snapshot.data![index].price
                                        .toInt()
                                        .toString(),
                                    style: FontManager.w500s17cB,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          },
        );
      },
    );
  }
}

Future<Map<String, String?>> getAdress(
    double frla, double frlo, double tola, double tolo) async {
  try {
    List<Placemark> from = await placemarkFromCoordinates(frla, frlo);
    List<Placemark> to = await placemarkFromCoordinates(tola, tolo);
    return {
      'from': from[0].street.toString(),
      'to': to[0].street.toString(),
    };
  } catch (erorr) {
    return {'from': '', 'to': ''};
  }
}
