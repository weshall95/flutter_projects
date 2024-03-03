import 'package:flutter/material.dart';

class ContainerDemo4 extends StatefulWidget {
  const ContainerDemo4({super.key});

  @override
  State<ContainerDemo4> createState() => _ContainerDemo4State();
}

class _ContainerDemo4State extends State<ContainerDemo4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 100,
          width: 100,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: const Text("Vishal"),
        ),
      ),
    );
  }
}
