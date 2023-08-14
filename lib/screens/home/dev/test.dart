import 'package:flutter/material.dart';

class SharedValue extends ValueNotifier<int> {
  SharedValue(int value) : super(value);
}

class Test extends StatefulWidget {
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final SharedValue sharedValue = SharedValue(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Value Sharing Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Child1(sharedValue: sharedValue),
            Child2(sharedValue: sharedValue),
          ],
        ),
      ),
    );
  }
}

class Child1 extends StatefulWidget {
  final SharedValue sharedValue;

  Child1({required this.sharedValue});

  @override
  State<Child1> createState() => _Child1State();
}

class _Child1State extends State<Child1> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: widget.sharedValue,
      builder: (context, value, child) {
        return Text('Child 1 Value: $value');
      },
    );
  }
}

class Child2 extends StatelessWidget {
  final SharedValue sharedValue;

  Child2({required this.sharedValue});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        sharedValue.value++; // Increment the shared value
      },
      child: Text('Increment Child 1 Value'),
    );
  }
}
