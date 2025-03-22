import 'package:flutter/material.dart';

class InputOrderDirection extends StatelessWidget {
  const InputOrderDirection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        label: Text("Dirección"),
      ),
      onChanged: (String text) {
        print(text);
      },
    );
  }
}
