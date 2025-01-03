import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'all_importent_imports.dart';
import 'rashi_fal_view_inv.dart';
import 'rashi_model_new.dart';

class RashiController extends GetxController {
  RxInt currentPage = 0.obs;
  RxBool isButtonDisabled = false.obs;

  RxString dateDetails = "".obs;

  Future<void> callFunction(String rashi, String frequency) async {
    EasyLoading.show(status: 'Loading');
    var dateDetails = '';
    // var c1 = DateTime.now();
    // var c2 = DateTime.now();

    // // First day of the week
    // c1 = c1.subtract(Duration(days: c1.weekday));

    // // Last day of the week
    // c2 = c2.add(Duration(days: 7 - c2.weekday));

    // Get the current date
    DateTime currentDate = DateTime.now();

    // Find the previous Sunday
    DateTime previousSunday =
        currentDate.subtract(Duration(days: currentDate.weekday));

    // Find the next Saturday
    DateTime nextSaturday = previousSunday.add(const Duration(days: 6));

    var firstday = previousSunday;
    var lastday = nextSaturday;

    switch (frequency) {
      case 'todays':
        var pDate = DateFormat('dd-MMMM-yyyy', 'en_US').format(DateTime.now());
        dateDetails = 'আজকের দিন [ $pDate ]';
        break;
      case 'weekly':
        var fsttDate = DateFormat('dd MMM', 'en_US').format(firstday);
        var lstDate = DateFormat('dd MMM yyyy', 'en_US').format(lastday);
        dateDetails = 'এই সপ্তাহ [ $fsttDate - $lstDate ]';
        break;
      case 'monthly':
        var pDate = DateFormat('MMMM-yyyy', 'en_US').format(DateTime.now());
        dateDetails = 'এই মাস [ $pDate ]';
        break;
      case 'yearly':
        var pDate = DateFormat('yyyy', 'en_US').format(DateTime.now());
        dateDetails = 'এই বছর [ $pDate ]';
        break;
    }

    var sunshine = '';
    var details = '';

    print(dateDetails);

// Replace "rashifal" with your Firestore collection name
    final CollectionReference rashifalCollection =
        FirebaseFirestore.instance.collection('rashifal');

// Define your variables (rashi, frequency, and dateDetails) here

    rashifalCollection
        .where('rashi', isEqualTo: rashi)
        .where('frequency', isEqualTo: frequency)
        .where('dateDetails', isEqualTo: dateDetails)
        .limit(1)
        .snapshots()
        .listen((QuerySnapshot snapshots) async {
      if (snapshots.docs.isNotEmpty) {
        for (QueryDocumentSnapshot doc in snapshots.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          final Horoscope horoscope = Horoscope.fromJson(data);
          print('Called From Firestore');

          Get.to(
            () => RashiIndiView(
              horoscope: horoscope,
            ),
          );
          EasyLoading.dismiss();
          return;
        }
      } else {
        try {
          final HttpsCallable callable =
              FirebaseFunctions.instanceFor(region: 'asia-south1')
                  .httpsCallable('callRashiFall');

          final DateTime now = DateTime.now();
          final String formattedDate =
              DateFormat('MM/dd/yyyy', 'en_US').format(now);

          final Map<String, dynamic> data = {
            'DateIn': formattedDate,
            'Rashi': rashi,
            'Frequency': frequency,
          };

          final HttpsCallableResult<dynamic> result = await callable.call(data);
          if (result.data != null) {
            final Map<String, dynamic> jsonData =
                json.decode(result.data as String);
            final Horoscope horoscope = Horoscope.fromJson(jsonData);
            if (kDebugMode) {
              print('Called From Function');
            }

            var res = true;
            if (res == true) {
              Get.to(
                () => RashiIndiView(
                  horoscope: horoscope,
                ),
              );
            } else {
              // showSnackBar(
              //     type: ERROR,
              //     message:
              //         'Error! while loading the Ads for Basic plan users.');
            }

            if (kDebugMode) {
              print('Rashi: ${horoscope.rashi}');
              print('Prediction: ${horoscope.prediction}');
            }
            EasyLoading.dismiss();
          } else {
            // Handle error case
            // showSnackBar(
            //     type: ERROR, message: 'Error! Please try again later.');
            EasyLoading.dismiss();
          }
        } catch (e) {
          // showSnackBar(type: ERROR, message: 'Error! Please try again later.');
          EasyLoading.dismiss();
        }
      }
    }, onError: (dynamic e) {});
  }
}
