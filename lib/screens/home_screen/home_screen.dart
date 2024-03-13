import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobigic_project/controllers/home_screen_controller/home_screen_controller.dart';
import 'package:mobigic_project/utils/utils.dart';

class HomeScreen extends StatefulWidget {


  const HomeScreen(
      {super.key,});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());
  final TextEditingController rowsController = TextEditingController();
  final TextEditingController columnController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              flex: 5,
              child: SearchBar(
                controller: homeScreenController.searchController,
                leading: Icon(Icons.search),
                elevation: MaterialStatePropertyAll(0),
                side: MaterialStatePropertyAll(BorderSide(width: 2,color: Colors.black12)),
                hintText: "Search...",
              ),
            ),
            Expanded(
              flex: 1,
              child:  IconButton(onPressed: () {
                  homeScreenController.rows.value = 0;
                  homeScreenController.column.value = 0;
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
                          Get.back();
                        }
                      }
                    },
                  );
                }, icon: Icon(Icons.refresh)),

            ),
          ],
        ),
      ),
      body: Obx(
        ()=> Padding(
          padding: const EdgeInsets.all(8.0),
          child: Expanded(
            child:homeScreenController.generatedChars.isNotEmpty && (homeScreenController.rows.value > 0)? GridView.builder(
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:  homeScreenController.column.value),
                itemBuilder: (context, index) {
                  // return Text("$rows / $column");
                  return Obx(
                    ()=> Container(
                        width: (screenWidth(context) ~/  homeScreenController.column.value).toDouble(),
                        height: (screenHeight(context) ~/  homeScreenController.rows.value).toDouble(),
                        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color:homeScreenController.highlightedAlphabetsIndexList.contains(index)?Colors.blue:Colors.red,
                        ),
                        child: FittedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Center(
                              child: Text(homeScreenController.generatedChars[index],style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        ),
                      ),
                  );

                },
                itemCount: homeScreenController.generatedChars.length,
              ):Center(
              child: Text("Please Tap on refresh icon"),
            ),
            ),
        ),
      ),

    );
  }
}
