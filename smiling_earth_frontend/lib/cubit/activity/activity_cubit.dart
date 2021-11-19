import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:smiling_earth_frontend/cubit/activity/activity_client.dart';
import 'package:smiling_earth_frontend/models/activity.dart';

part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  final _activityClient = ActivityClient();
  ActivityCubit() : super(ActivityInitial());

  void publishActivity(ActivityDto activity) {
    try {
      emit(CreatingActivity());
      _activityClient.newActivity(activity).then((created) {
        if (created) {
          emit(ActivityPosted());
        } else {
          emit(Error('Failed to publish. Try again later'));
        }
      });
    } catch (e) {
      emit(Error("Failed to publish activity. " + e.toString()));
    }
  }
}
