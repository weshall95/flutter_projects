import 'package:flutter/material.dart';

class Assignment4 extends StatefulWidget {
  const Assignment4({super.key});
  @override
  State<Assignment4> createState() => _Assignment4State();
}

class _Assignment4State extends State<Assignment4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "Instagram",
            style: TextStyle(
                fontStyle: FontStyle.italic, color: Colors.black, fontSize: 30),
          ),
          actions: [
            const Icon(
              Icons.favorite_rounded,
              color: Colors.red,
            ),
          ],
        ),
        body: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  "https://images.pexels.com/photos/346529/pexels-photo-346529.jpeg?cs=srgb&dl=pexels-bri-schneiter-346529.jpg&fm=jpg",
                  width: double.infinity,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_outline_outlined,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.comment_outlined,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.send,
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ));
  }
}
