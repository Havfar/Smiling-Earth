import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/pages/emission_estimation.dart';
import 'package:smiling_earth_frontend/widgets/emission_chart.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';
import 'package:smiling_earth_frontend/widgets/post.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
      //drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.green),
        backgroundColor: Colors.white,
      ),
      drawer: NavigationDrawerWidget(),
      body: Container(
        height: 800,
        margin: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            buildHeaderToolbar(),
            buildChart(),
            buildEmissionEstimation(),
            buildFeed(),
          ],
        ),
      ),
    ));
  }
}

class buildChart extends StatelessWidget {
  const buildChart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Row(
          children: [
            Text("Emissions",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                )),
          ],
        ),
        Center(
          child: SmilingEarthEmissionChart(
            energyEmissionPercentage: 0.15,
            transportEmissionPercentage: 0.33,
          ),
        ),
        Text("134 kg Co2",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            )),
      ]),
    );
  }
}

class buildFeed extends StatelessWidget {
  const buildFeed({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            "Feed",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          TextButton.icon(
              onPressed: () => (print("add")),
              icon: Icon(Icons.add),
              label: Text("Add"))
        ]),
        Column(children: demoPosts())
      ]),
    );
  }

  List<PostWidget> demoPosts() {
    var output = <PostWidget>[];
    for (var i = 0; i < 20; i++) {
      String url =
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';
      Post post = new Post(url,
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam libero neque ultrices praesent purus varius curabitur. ");
      output.add(PostWidget(
        post: post,
        liked: false,
      ));
    }
    return output;
  }
}

class buildEmissionEstimation extends StatelessWidget {
  const buildEmissionEstimation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30, bottom: 10),
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: Colors.black12),
              bottom: BorderSide(color: Colors.black12))),
      child: ListTile(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EmissionEstimatePage()),
        ),
        title: Text("Emission estimation"),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }
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
