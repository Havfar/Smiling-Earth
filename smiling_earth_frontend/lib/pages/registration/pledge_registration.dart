import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiling_earth_frontend/cubit/pledge/pledge_cubit.dart';
import 'package:smiling_earth_frontend/models/pledge.dart';
import 'package:smiling_earth_frontend/pages/registration/climate_action.dart';
import 'package:smiling_earth_frontend/pages/registration/registration_completed.dart';
import 'package:smiling_earth_frontend/widgets/circle_icon.dart';
import 'package:smiling_earth_frontend/widgets/page_indicator.dart';

class PledgeRegistrationPage extends StatefulWidget {
  @override
  State<PledgeRegistrationPage> createState() => _PledgeRegistrationPageState();
}

class _PledgeRegistrationPageState extends State<PledgeRegistrationPage> {
  List<int> selectedPledges = [];
  bool sendtPledgeRequest = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        // appBar: AppBar(),
        // drawer: NavigationDrawerWidget(),
        body: Container(
          margin: EdgeInsets.only(top: 20),
          child: ListView(
            shrinkWrap: true,
            children: [
              BlocProvider(
                create: (context) => PledgeCubit()..getPledes(),
                child: Container(child: BlocBuilder<PledgeCubit, PledgeState>(
                    builder: (context, state) {
                  if (state is RetrievedPledges) {
                    if (sendtPledgeRequest) {
                      return FinishedPage();
                    }
                    return Column(
                      children: [
                        _BuildHeader(),
                        GridView.count(
                          shrinkWrap: true,
                          primary: false,
                          padding: const EdgeInsets.all(20),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 2,
                          children: state.pledges
                              .map((pledge) => PledgeWidget(
                                    pledge: pledge,
                                    selected: _isSelected(pledge.id!),
                                    onSelect: () =>
                                        _updateSelectedPledges(pledge.id!),
                                  ))
                              .toList(),
                        ),
                        ElevatedButton(
                            onPressed: () =>
                                PledgeCubit()..makePledge(selectedPledges),
                            child: Text('submit'))
                      ],
                    );
                  } else if (state is ErrorRetrievingPledges) {
                    return Text(' Error: ');
                  } else if (state is PledgesMade) {
                    return Text('yuhu');
                  }
                  return Center(child: Text('Loading..'));
                })),
              )
            ],
          ),
        ),
        bottomNavigationBar: sendtPledgeRequest
            ? null
            : PageIndicator(
                index: 4,
                previousPage: MaterialPageRoute(
                    builder: (context) => ClimateActionPage()),
                nextPage:
                    MaterialPageRoute(builder: (context) => FinishedPage()),
                formSumbissionFunction: () => submitPledges(context)),
      );

  bool _isSelected(int index) {
    return selectedPledges.contains(index);
  }

  void _updateSelectedPledges(int index) {
    if (_isSelected(index)) {
      setState(() {
        selectedPledges.remove(index);
      });
    } else {
      setState(() {
        selectedPledges.add(index);
      });
    }
  }

  void submitPledges(BuildContext context) {
    PledgeCubit()..makePledge(selectedPledges);
    setState(() {
      sendtPledgeRequest = true;
    });
    // var route = MaterialPageRoute(builder: (context) => FinishedPage());

    // Navigator.of(context).push(route);
  }
}

class _BuildHeader extends StatelessWidget {
  const _BuildHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '  Make a pledge',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Text(
            'Tell the world how you will help mitigate climate change. Commit to one or more pledges below!',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class BuildPledges extends StatefulWidget {
  const BuildPledges({
    Key? key,
  }) : super(key: key);

  @override
  State<BuildPledges> createState() => _BuildPledgesState();
}

class _BuildPledgesState extends State<BuildPledges> {
  List<int> selectedPledges = [];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocBuilder<PledgeCubit, PledgeState>(builder: (context, state) {
      if (state is RetrievedPledges) {
        return Column(
          children: [
            GridView.count(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: state.pledges
                  .map((pledge) => PledgeWidget(
                        pledge: pledge,
                        selected: _isSelected(pledge.id!),
                        onSelect: () => _updateSelectedPledges(pledge.id!),
                      ))
                  .toList(),
            ),
            ElevatedButton(
                onPressed: () => PledgeCubit()..makePledge(selectedPledges),
                child: Text('submit'))
          ],
        );
      } else if (state is ErrorRetrievingPledges) {
        return Text(' Error: ');
      }
      return Center(child: Text('Loading..'));
    }));
  }

  bool _isSelected(int index) {
    return selectedPledges.contains(index);
  }

  void _updateSelectedPledges(int index) {
    if (_isSelected(index)) {
      setState(() {
        selectedPledges.remove(index);
      });
    } else {
      setState(() {
        selectedPledges.add(index);
      });
    }
  }
}

class PledgeWidget extends StatelessWidget {
  final PledgeDto pledge;
  final bool selected;
  final void Function()? onSelect;
  PledgeWidget(
      {Key? key,
      required this.pledge,
      required this.onSelect,
      required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selected) {
      return Card(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.green, width: 2),
              borderRadius: BorderRadius.circular(4.0)),
          child: InkWell(
            onTap: () {
              if (onSelect != null) {
                onSelect!();
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleIcon(
                              onTap: null,
                              backgroundColor: Colors.lightBlue.shade100,
                              emoji: pledge.icon),
                          SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 60,
                            child: Text(pledge.title,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(pledge.description)
                    ],
                  ),
                  Icon(Icons.check_circle, color: Colors.green)
                ],
              ),
            ),
          ));
    }
    return Card(
        child: InkWell(
      onTap: () {
        if (onSelect != null) {
          onSelect!();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleIcon(
                        onTap: null,
                        backgroundColor: Colors.lightBlue.shade100,
                        emoji: pledge.icon),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      width: 60,
                      child: Text(pledge.title,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(pledge.description)
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
