import 'package:flutter/material.dart';

class CurrencyConverterMaterialPage extends StatelessWidget {
  const CurrencyConverterMaterialPage({super.key});
  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
        borderSide: const BorderSide(
          width: 1.5,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(10));
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '0',
              style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255) //default size is 14
                  ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: 'Please enter the amount in USD',
                  hintStyle: const TextStyle(color: Colors.black),
                  prefixIcon: const Icon(Icons.monetization_on_outlined),
                  prefixIconColor: Colors.white60,
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: border,
                  enabledBorder: border,
                ),
                keyboardType: const TextInputType.numberWithOptions(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
