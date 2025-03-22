import 'package:flutter/material.dart';

class InputOrderDirection extends StatefulWidget {
  const InputOrderDirection({super.key, required this.onSubmitted});

  final Function(String text) onSubmitted;

  @override
  State<InputOrderDirection> createState() => _InputOrderDirectionState();
}

class _InputOrderDirectionState extends State<InputOrderDirection> {
  String text = "";
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        label: Text("Dirección"),
      ),
      onTapOutside: (event) {
        widget.onSubmitted(text);
      },
      onChanged: (String value) {
        setState(() {
          text = value;
        });
      },
    );
  }
}
