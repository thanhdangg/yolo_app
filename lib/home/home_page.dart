import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:yolo_app/home/widgets/home_view.dart';
@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}