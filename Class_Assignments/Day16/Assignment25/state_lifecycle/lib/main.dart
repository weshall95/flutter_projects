import 'package:flutter/material.dart';

void main() {
  runApp(const WidgetLifeCycle());
}

class WidgetLifeCycle extends StatefulWidget {
  const WidgetLifeCycle({super.key});

  @override
  State<WidgetLifeCycle> createState() => _WidgetLifeCycleState();
}

class _WidgetLifeCycleState extends State<WidgetLifeCycle> {
  @override
  void initState() {
    super.initState;
    debugPrint("In initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint("Dependencies Changed");
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("Disposed");
  }

  @override
  void didUpdateWidget(covariant Column) {
    super.didUpdateWidget(Column);
    print("Updated");
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("In build method");

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Widget LifeCycle"),
        ),
        body: const Row(
          children: [
            SizedBox(
              child: Text("j"),
            )
          ],
        ),
      ),
    );
  }
}
