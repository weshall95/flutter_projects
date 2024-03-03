import 'package:flutter/material.dart';

class ContainerDemo extends StatelessWidget {
  const ContainerDemo({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
              color: Colors.blue,
              // boxShadow: [
              //   BoxShadow(
              //       color: Colors.red, offset: Offset(10, 10), blurRadius: 10)
              // ],
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
              border: Border.all(color: Colors.red)),
          child: const Text("Container"),
        ),
      ),
    );
  }
}
