import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../models/complaint_model.dart';
import '../../res/hostting.dart';

class MakeAComplaintController extends GetxController {
  Future<bool> sendMessage(String subject, String body) async {
    var json =
        jsonEncode(ComplaintModel(subject: subject, body: body).toJson());
    http.Response response = await http.post(HosttingTaxi.sendMessage,
        headers: HosttingTaxi().getHeader(), body: json);
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
