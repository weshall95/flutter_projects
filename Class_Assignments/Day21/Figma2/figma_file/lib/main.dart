import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color.fromRGBO(111, 81, 255, 1)),
      home: ToDoApp(),
    );
  }
}

class ToDoApp extends StatefulWidget {
  const ToDoApp({super.key});

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(111, 81, 255, 1),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 35),
              child: Text(
                "Good Morning",
                style: GoogleFonts.quicksand(
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w400)),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 35),
                child: Text("Vishal",
                    style: GoogleFonts.quicksand(
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w600))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 496,
              // color: Colors.white,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Color.fromRGBO(217, 217, 217, 1)),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Create To Do List"),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Container(
                      // height: 466,
                      // width: double.infinity,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40)),
                          color: Color.fromRGBO(255, 255, 255, 1)),
                      child: ListView.builder(itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20, top: 20),
                          child: Card(
                            // width: double.infinity,
                            elevation: 5,
                            // height: 50,
                            color: Color.fromRGBO(255, 255, 255, 1),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      height: 52,
                                      width: 52,
                                      decoration: const BoxDecoration(
                                        // color: Colors.white,
                                        shape: BoxShape.circle,
                                        // borderRadius: BorderRadius.all(
                                        //     Radius.circular(46))
                                      ),
                                      child: Image.asset(
                                        fit: BoxFit.fill,
                                        // scale: 1,
                                        'assets/images/Group 51.png',

                                        width: 52, height: 52,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Lorem",
                                        style: GoogleFonts.inter(
                                            textStyle: const TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                      Text(
                                        "description",
                                        style: GoogleFonts.inter(
                                            textStyle: TextStyle(
                                                fontSize: 9,
                                                fontWeight: FontWeight.w400)),
                                      ),
                                      Text(
                                        "10 July 2023",
                                        style: GoogleFonts.inter(
                                            textStyle: TextStyle(
                                                fontSize: 8,
                                                fontWeight: FontWeight.w400)),
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  Image.asset('assets/images/Group 49.png')
                                ],
                              ),
                            ),
                          ),
                        );
                      })),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
