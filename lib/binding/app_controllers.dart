import 'package:flutter_firebase_push_notification/lib.dart';

class AppBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return binds;
  }

  static List<Bind> binds = [
    ///Networking
    // Bind.put(ConnectivityController()),

    ///Controllers
    Bind.put(HomeController()),
  ];
}
