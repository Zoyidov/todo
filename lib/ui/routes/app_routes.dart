import 'package:flutter/material.dart';
import 'package:udevs/data/model/db_model.dart';
import 'package:udevs/ui/add_event/add_event.dart';
import 'package:udevs/ui/home_page/home_page.dart';



class RouteNames {
  static const String homePage = "/";
  static const String addEvent = "/add_event";

}


class AppRoutes {
  static get todo => TodoModel;


  static Route generateRoute(RouteSettings settings) {

    switch (settings.name) {
      case RouteNames.homePage:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case RouteNames.addEvent:
        return MaterialPageRoute(
          builder: (context) => const AddEvent(),
        );
    }
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(child: Text("Route not found!")),
      ),
    );
  }
}
