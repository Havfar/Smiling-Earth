import 'package:flutter/material.dart';

class EmissionEstimatePage extends StatefulWidget {
  @override
  _EmissionEstimatePageState createState() => _EmissionEstimatePageState();
}

class _EmissionEstimatePageState extends State<EmissionEstimatePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
          child: Column(
            children: [buildHeaderToolbar()],
          ),
        ),
      );
}

class buildHeaderToolbar extends StatelessWidget {
  const buildHeaderToolbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "123",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "km",
              style: TextStyle(color: Colors.black87),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "123",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "km",
              style: TextStyle(color: Colors.black87),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "123",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "km",
              style: TextStyle(color: Colors.black87),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "123",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "km",
              style: TextStyle(color: Colors.black87),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "123",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "km",
              style: TextStyle(color: Colors.black87),
            )
          ],
        )
      ]),
    );
  }
}
