


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/home_screen_controller/home_screen_controller.dart';
import '../screens/home_screen/home_screen.dart';

double  screenWidth(BuildContext context)=> MediaQuery.of(context).size.width;
double  screenHeight(BuildContext context)=> MediaQuery.of(context).size.height;
MediaQueryData mediaQueryData(BuildContext context) => MediaQuery.of(context);

Widget dialogInput({
  required TextEditingController controller,
  required String hintText,
  required String errorMsg
}){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
        hintText: hintText,
      ),
      validator: (value) {
        if(value!.isEmpty){
          return errorMsg;
        }
        return null;
      },
      keyboardType: TextInputType.number,
    ),
  );
}

TextStyle splashHeading() {
  return const TextStyle(
    fontSize: 30,
    color: Colors.purple,
    fontWeight: FontWeight.bold,
  );
}

gridBuilderDialog(
    {required BuildContext context,
      required TextEditingController rowController,
      required TextEditingController columnController,
      required GlobalKey<FormState> formKey,
      required HomeScreenController homeScreenController,
    required void Function() onPressed}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Generate Grid"),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: dialogInput(
                            controller: rowController,
                            hintText: "Rows",
                            errorMsg: "Enter Number of rows"),
                      ),
                      Expanded(
                        child: dialogInput(
                            controller: columnController,
                            hintText: "Columns",
                            errorMsg: "Enter Number of Columns"),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.05,
                ),
                MaterialButton(
                  onPressed:onPressed,
                  color: Colors.purple,
                  child: const Text(
                    "Generate",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        );
      },
      barrierDismissible: false);
}