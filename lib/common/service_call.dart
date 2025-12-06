import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'; // ✅ perlu buat RoutePredicate
import 'package:food_delivery/common/globs.dart';
import 'package:food_delivery/common/locator.dart';
import 'package:http/http.dart' as http;

typedef ResSuccess = Future<void> Function(Map<String, dynamic>);
typedef ResFailure = Future<void> Function(dynamic);

class ServiceCall {
  static final NavigationService navigationService = locator<NavigationService>();
  static Map userPayload = {};

  /// POST helper
  static void post(
    Map<String, dynamic> parameter,
    String path, {
    bool isToken = false,
    ResSuccess? withSuccess,
    ResFailure? failure,
  }) {
    Future(() {
      try {
        final headers = <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        };

        // if (isToken) {
        //   headers["token"] = "";
        // }

        http
            .post(Uri.parse(path), body: parameter, headers: headers)
            .then((value) {
          if (kDebugMode) {
            print(value.body);
          }
          try {
            final jsonObj =
                json.decode(value.body) as Map<String, dynamic>? ?? {};

            if (withSuccess != null) {
              withSuccess(jsonObj);
            }
          } catch (err) {
            if (failure != null) {
              failure(err.toString());
            }
          }
        }).catchError((e) {
          if (failure != null) {
            failure(e.toString());
          }
        });
      } catch (err) {
        if (failure != null) {
          failure(err.toString());
        }
      }
    });
  }

  /// LOGOUT GLOBAL
  static Future<void> logout() async {
    // ✅ reset flag login & payload lokal
    Globs.udBoolSet(false, Globs.userLogin);
    Globs.udRemove(Globs.userPayload);
    userPayload = {};

    // ✅ kalau ada token / data lain, bersihkan di sini juga
    // Globs.udRemove(KKey.authToken);

    // ✅ navigate ke "welcome" dan hapus semua route sebelumnya
    navigationService.navigatorKey.currentState?.pushNamedAndRemoveUntil(
      "welcome",
      (route) => false,
    );
  }
}
