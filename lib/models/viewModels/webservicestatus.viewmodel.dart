// import 'dart:async';
// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// enum ServerStatus { connecting, online, offline, error }

// class WebServiceStatusProvider extends StateNotifier<Stream<ServerStatus>> {

//   StreamController<ServerStatus> networkStatusController = StreamController<ServerStatus>();

//   WebServiceStatusProvider() {
//     state = networkStatusController.stream.asyncMap((event) async => checkOnline())
//   }

//   Stream<ServerStatus> checkOnline() async {
//     return ServerStatus.connecting;
//     try {
//       final result = await InternetAddress.lookup('http://localhost:8000/');
//       if (kIsWeb) {
//         state = ServerStatus.online;
//       } else {
//         if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//           state = ServerStatus.online;
//         } else {
//           state = ServerStatus.offline;
//         }
//       }
//     } on SocketException catch (_) {
//       state = ServerStatus.error;
//     }
//   }
// }
