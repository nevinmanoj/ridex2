import 'package:flutter/material.dart';
import 'package:googleapis/forms/v1.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  List colors = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Center(
            child: SizedBox(
              height: 100,
              width: 300,
              child: TextField(
                keyboardType: TextInputType.phone,
                onChanged: (val) {
                  if (val.isNotEmpty) {
                    int n = int.parse(val);
                    setState(() {
                      colors = generateDistinctColors(n);
                    });
                  }
                },
              ),
            ),
          ),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: colors.map((color) {
              return Container(
                width: 50,
                height: 50,
                color: color,
              );
            }).toList(),
          ),
        ],
      )),
    );
  }
}

List generateDistinctColors(int numColors) {
  List distinctColors = [];
  for (int i = 0; i < numColors; i++) {
    double hue = i / numColors;
    Color color = HSVColor.fromAHSV(1.0, hue * 360, 0.7, 0.9).toColor();
    distinctColors.add(color);
  }
  return distinctColors;
}
