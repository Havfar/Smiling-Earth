import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiling_earth_frontend/cubit/pledge/pledge_cubit.dart';
import 'package:smiling_earth_frontend/pages/registration/pledge_registration.dart';
import 'package:smiling_earth_frontend/pages/settings_page.dart';
import 'package:smiling_earth_frontend/widgets/navigation_drawer_widget.dart';
import 'package:smiling_earth_frontend/widgets/pledge_widget.dart';

class PledgeSettings extends StatelessWidget {
  const PledgeSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.green),
      ),
      drawer: NavigationDrawerWidget(),
      body: ListView(
        children: [
          _BuildHeader(),
          BuildMyPledges(),
          EditPledgesPage(),
        ],
      ));
}

class BuildMyPledges extends StatelessWidget {
  const BuildMyPledges({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('My pledges'),
        BlocProvider(
          create: (context) => PledgeCubit()..getMyUserPledges(),
          child: Container(child:
              BlocBuilder<PledgeCubit, PledgeState>(builder: (context, state) {
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
                        .map((pledge) => MyPledgeWidget(
                              pledge: pledge,
                            ))
                        .toList(),
                  ),
                ],
              );
            } else if (state is ErrorRetrievingPledges) {
              return Text(' Error: ');
            } else if (state is PledgesMade) {}
            return Center(child: Text('Loading..'));
          })),
        ),
      ],
    );
  }
}

class EditPledgesPage extends StatefulWidget {
  @override
  State<EditPledgesPage> createState() => _EditPledgesPageState();
}

class _EditPledgesPageState extends State<EditPledgesPage> {
  List<int> selectedPledges = [];

  bool sendtPledgeRequest = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Select other',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text('Select the pledges you want to make and hit Add'),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    child: ElevatedButton(
                        onPressed: selectedPledges.isNotEmpty
                            ? () {
                                PledgeCubit()..makePledge(selectedPledges);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Pledges Updated')));
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SettingsPage()));
                              }
                            : null,
                        child: Text('Add')),
                  ),
                ],
              ),
              BlocProvider(
                create: (context) => PledgeCubit()..getNotJoinedPledges(),
                child: Container(child: BlocBuilder<PledgeCubit, PledgeState>(
                    builder: (context, state) {
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
                                    onSelect: () =>
                                        _updateSelectedPledges(pledge.id!),
                                  ))
                              .toList(),
                        ),
                      ],
                    );
                  } else if (state is ErrorRetrievingPledges) {
                    return Text(' Error: ');
                  } else if (state is PledgesMade) {
                    return Text('yuhu');
                  }
                  return Center(child: Text('Loading..'));
                })),
              ),
            ],
          )
        ],
      ),
    );
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

  void submitPledges(BuildContext context) {
    PledgeCubit()..makePledge(selectedPledges);
    setState(() {
      sendtPledgeRequest = true;
    });
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
