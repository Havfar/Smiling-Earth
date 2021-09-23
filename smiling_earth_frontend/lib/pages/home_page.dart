import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiling_earth_frontend/bloc/login/dao/UserDao.dart';
import 'package:smiling_earth_frontend/cubit/posts/posts_cubit.dart';
import 'package:smiling_earth_frontend/models/post.dart';
import 'package:smiling_earth_frontend/models/user.dart';
import 'package:smiling_earth_frontend/pages/emission_estimation.dart';
import 'package:smiling_earth_frontend/utils/services/activity_recognition.dart';
import 'package:smiling_earth_frontend/widgets/emission_chart.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';
import 'package:smiling_earth_frontend/widgets/post_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    startActivityMonitor();
  }

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

class buildFeed extends StatefulWidget {
  const buildFeed({
    Key? key,
  }) : super(key: key);

  @override
  State<buildFeed> createState() => _buildFeedState();
}

class _buildFeedState extends State<buildFeed> {
  late Future<User?> user;
  late Future<PostDto> postsdto;

  @override
  void initState() {
    super.initState();
    this.user = UserDao().getUser();
    // this.postsdto = fetchPosts();
  }

  List<PostWidget> posts = [];
  @override
  Widget build(BuildContext context) {
    // posts.addAll(demoPosts());
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
        BlocProvider<PostsCubit>(
            create: (context) => PostsCubit()..getPosts(),
            child: buildPostsFeed()),
        Column(children: posts)
      ]),
    );
  }
}

class buildPostsFeed extends StatelessWidget {
  const buildPostsFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100000,
      child: BlocBuilder<PostsCubit, List<PostDto>>(builder: (context, posts) {
        if (posts.isEmpty) {
          return Center(
            child: Text("Loading"),
          );
        }
        return ListView.builder(
            itemCount: 2,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return PostWidget(
                  clickable: true,
                  liked: false,
                  author: posts[index].user,
                  post: posts[index]);
            });
      }),
    );
  }
}

// Future<PostDto> fetchPosts() async {
//   String token = "1ef4424ee40e7f213893ffe0c1da4cff1d8b5797";
//   Uri uri = Uri.parse('http://10.0.2.2:8000/posts');
//   final response =
//       await http.get(uri, headers: {"Authorization": "Token " + token});

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return PostDto.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }

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
