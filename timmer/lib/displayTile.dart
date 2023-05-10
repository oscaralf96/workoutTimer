// ignore_for_file: file_names

import 'package:flutter/material.dart';

class DisplayTile extends StatelessWidget {
  const DisplayTile({super.key, required this.number});
  final int number;
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        //color: Colors.orange,
        width: 50,
        child: Text(
          number.toString().padLeft(2, '0'),
          style: const TextStyle(
              fontWeight: FontWeight.w300, color: Colors.black, fontSize: 30),
        ));
  }
}

class DisplayTileDouble extends StatelessWidget {
  const DisplayTileDouble(
      {super.key, required this.number1, required this.number2});
  final int number1;
  final int number2;
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        //color: Colors.orange,
        width: 110,
        child: Text(
          "${number1.toString().padLeft(2, '0')}:${number2.toString().padLeft(2, '0')}",
          style: const TextStyle(
              fontWeight: FontWeight.w300, color: Colors.black, fontSize: 30),
        ));
  }
}
