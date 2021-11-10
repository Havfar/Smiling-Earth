import 'package:flutter/material.dart';

class NotImplementedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.green),
        ),
        // drawer: NavigationDrawerWidget(),
        body: Text("Unnfortunatly, this feature is not implemented yet :("),
      );
}
