import 'package:flutter/material.dart';

class Assignment4 extends StatefulWidget {
  const Assignment4({super.key});
  @override
  State<Assignment4> createState() => _Assignment4State();
}

class _Assignment4State extends State<Assignment4> {
  @override
  Widget build(BuildContext context) {
    var num = [1212, 121, 525, 555, 3233];
    int rem = 0, temp, count = 0, sum = 0;
    int func() {
      for (int i = 0; i <= num.length; i++) {
        rem = num[i] % 10;
        sum = (sum * 10) + rem;
        num[i] = num[i] ~/ 10;
      }
      temp = sum;
      if (sum == temp) {
        count++;
      }
      return count;
    }

    setState(() {
      print(count);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Checker"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
