import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiling_earth_frontend/cubit/pledge/pledge_cubit.dart';
import 'package:smiling_earth_frontend/models/pledge.dart';
import 'package:smiling_earth_frontend/widgets/circle_icon.dart';

class MyPledgeWidget extends StatefulWidget {
  final PledgeDto pledge;
  MyPledgeWidget({Key? key, required this.pledge}) : super(key: key);

  @override
  _MyPledgeWidgetState createState() => _MyPledgeWidgetState();
}

class _MyPledgeWidgetState extends State<MyPledgeWidget> {
  bool removed = false;
  @override
  Widget build(BuildContext context) {
    if (removed) {}
    return BlocProvider(
      create: (context) => PledgeCubit(),
      child: BlocBuilder<PledgeCubit, PledgeState>(
        builder: (context, state) {
          if (state is PledgesDeleted) {
            return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0)),
                child: Center(child: Text('removed')));
          } else if (state is PledgesDeleting) {
            return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0)),
                child: Center(child: CircularProgressIndicator()));
          } else if (state is PledgesDeletingError) {
            return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0)),
                child: Center(child: Text('An errror occured')));
          }
          return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0)),
              child: InkWell(
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
                                  emoji: widget.pledge.icon),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: 60,
                                child: Text(widget.pledge.title,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(widget.pledge.description)
                        ],
                      ),
                      Positioned(
                        left: 110,
                        child: Container(
                          height: 30,
                          width: 30,
                          color: Colors.red,
                          child: IconButton(
                              padding: EdgeInsets.all(0.0),
                              onPressed: () {
                                BlocProvider.of<PledgeCubit>(context)
                                    .deletePledge(widget.pledge.id!);
                              },
                              icon: Icon(Icons.close, color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
