import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mobigic_project/controllers/home_screen_controller/home_screen_controller.dart';
import 'package:mobigic_project/screens/home_screen/home_screen.dart';

import '../../utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final TextEditingController rowsController = TextEditingController();
  final TextEditingController columnController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final HomeScreenController homeScreenController = Get.put(HomeScreenController());

  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      gridBuilderDialog(
          context: context,
          columnController: columnController,
          rowController: rowsController,
          formKey: formKey,
        homeScreenController: homeScreenController,
        onPressed: () {
          if(formKey.currentState!.validate()){
            if (int.parse(columnController.text) > 7) {
              Get.showSnackbar(GetSnackBar(
                message: "Column length should be less than 8",
                dismissDirection: DismissDirection.horizontal,
              ));
            } else {
              homeScreenController.rows.value = int.parse(rowsController.text.isEmpty?"0":rowsController.text);
              homeScreenController.column.value = int.parse(columnController.text.isEmpty?"0":columnController.text);
              homeScreenController.generateCars();
              Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));

            }
          }
        },
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            "Crossword Mania",
            style: splashHeading(),
          ),
        ),
      ),
    );
  }
}


