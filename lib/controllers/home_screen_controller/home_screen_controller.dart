import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:mobigic_project/screens/home_screen/home_screen.dart';

class HomeScreenController extends GetxController {
  RxBool matched = false.obs;
  final TextEditingController searchController = TextEditingController();
  RxList<String> generatedChars = List<String>.empty().obs;
  final highlightedAlphabetsIndexList = List<int>.empty().obs;
  RxString generatedString = "".obs;
  RxBool clear = false.obs;
  RxInt rows = 0.obs;
  var column = 0.obs;

  List<String> alphabets = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];

  String getRandomString() {
    return alphabets[Random().nextInt(alphabets.length)];
  }

  @override
  void onInit() {
    searchController.addListener(performSearch);
    for (var element in generatedChars) {
      generatedString.value = element;
    }
    generateCars();
    super.onInit();
  }

  generateCars(){
    generatedChars.value = List.generate( rows.value *column.value, (index) => getRandomString(),);
    alphabets.shuffle();
  }

  performSearch() {
    String searched = searchController.text.toString();
    highlightedAlphabetsIndexList.value = findTextInGrid(grid: generatedChars, text: searched.toUpperCase(), m: rows.value, n: column.value);
    // for (int i = 0; i < searched.length; i++) {
    //   var s = generatedChars.where((p0) => p0 == (searched[i].toUpperCase()));
    //   var index = s.map((element) => generatedChars.indexOf(element)).toList();
    //   print(index);
    //   for (int j = 0; j < index.length; j++) {
    //     if (generatedChars.indexOf(generatedChars[index[j]]) == index[j]) {
    //       highlightedAlphabetsList.add(index[j]);
    //     }
    //   }
    // }
  }
  List<int> findTextInGrid({
    required List<String> grid,
    required String text,
    required int m,
    required int n,
  }) {
    if (text.isEmpty) {
      return [];
    }

    // Define the eight directions to search
    List<List<int>> directions = [
      [0, 1],  // Right
      [1, 0],  // Down
      // [1, 1],  // Diagonal (top-left to bottom-right)
      [-1, 1], // Diagonal (top-right to bottom-left)
      // [0, -1], // Left
      // [-1, 0], // Up
      // [-1, -1],// Reverse diagonal (bottom-right to top-left)
      // [1, -1]  // Reverse diagonal (bottom-left to top-right)
    ];

    for (int row = 0; row < m; row++) {
      for (int col = 0; col < n; col++) {
        int index = row * n + col;

        if (grid[index] != text[0]) {
          continue;
        }

        // Check in all eight directions
        for (var dir in directions) {
          int r = row, c = col;
          bool found = true;
          List<int> remainingIndices = [index];

          // Check each character in the direction
          for (int i = 1; i < text.length; i++) {
            r += dir[0];
            c += dir[1];
            int nextIndex = r * n + c;

            // Check if next index is within bounds
            if (r < 0 || r >= m || c < 0 || c >= n) {
              found = false;
              break;
            }

            // Check if character matches
            if (grid[nextIndex] != text[i]) {
              found = false;
              break;
            }
            remainingIndices.add(nextIndex);
          }

          // If text found in this direction, return indices
          if (found) {
            return remainingIndices;
          }
        }
      }
    }
  return[];
  }

}

