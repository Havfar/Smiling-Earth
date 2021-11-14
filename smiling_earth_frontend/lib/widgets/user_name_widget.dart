import 'package:flutter/material.dart';
import 'package:smiling_earth_frontend/utils/services/settings_db_manager.dart';

class BuildLocalName extends StatelessWidget {
  const BuildLocalName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: SettingsDatabaseManager.instance.getName(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    snapshot.data!,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            );
          }
          return Text(
            'Loading.. ',
            style: TextStyle(fontSize: 20),
          );
        });
  }
}
