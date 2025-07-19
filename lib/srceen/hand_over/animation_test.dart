import 'package:flutter/material.dart';

class FadeInList extends StatefulWidget {
  @override
  _FadeInListState createState() => _FadeInListState();
}

class _FadeInListState extends State<FadeInList> {
  final List<String> items = ['Item 1', 'Item 2', 'Item 3'];
  final List<bool> showItem = [];

  @override
  void initState() {
    super.initState();
    showItem.addAll(List.filled(items.length, false));
    _startAnimation();
  }

  void _startAnimation() async {
    for (int i = 0; i < items.length; i++) {
      await Future.delayed(Duration(milliseconds: i * 300));
      setState(() {
        showItem[i] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animation"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return AnimatedOpacity(
              duration: Duration(milliseconds: 600),
              opacity: showItem[index] ? 1.0 : 0.0,
              child: AnimatedSlide(
                duration: Duration(milliseconds: 600),
                offset: showItem[index] ? Offset(0, 0) : Offset(0, -0.2),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Card(
                    child: ListTile(title: Text(items[index])),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
