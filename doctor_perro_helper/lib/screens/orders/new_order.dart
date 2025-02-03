import 'package:doctor_perro_helper/config/border_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewOrder extends StatefulWidget {
  const NewOrder({super.key});

  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nueva orden"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Sizes().xxl,
          horizontal: Sizes().large,
        ),
        child: const Text("data"),
      ),
    );
  }
}
