import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/models/pledge.dart';
import 'package:smiling_earth_frontend/pages/pledges/edit_my_pledges.dart';
import 'package:smiling_earth_frontend/pages/registration/pledge_registration.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';

class DetailedPledgePage extends StatelessWidget {
  final PledgeDto pledge;

  const DetailedPledgePage({Key? key, required this.pledge}) : super(key: key);
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
        drawer: NavigationDrawerWidget(),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 50, left: 30, right: 30),
              child: PledgeWidget(
                pledge: pledge,
                onSelect: null,
                selected: false,
              ),
            ),
            TextButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PledgeSettings())),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Edit my pledges'),
                    SizedBox(width: 10),
                    Icon(Icons.chevron_right)
                  ],
                ))
          ],
        ),
      );
}
