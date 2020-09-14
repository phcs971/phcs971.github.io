import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  final int currentPage;
  final Widget child;
  const BasePage(this.currentPage, this.child);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Scaffold(
        body: Row(
          children: [
            SizedBox(width: 50),
            Expanded(
              child: Column(
                children: [
                  Container(height: 125, color: Colors.orange),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(children: [
                        Container(
                          child: child,
                          constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height - 125,
                          ),
                        ),
                        Container(height: 75, color: Colors.blue)
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            Container(color: Colors.green, width: 75, height: double.infinity),
          ],
        ),
      ),
    );
  }
}
