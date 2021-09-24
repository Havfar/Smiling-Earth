import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:smiling_earth_frontend/cubit/activity/activity_client.dart';
import 'package:smiling_earth_frontend/cubit/posts/post_client.dart';
import 'package:smiling_earth_frontend/models/activity.dart';
import 'package:smiling_earth_frontend/models/post.dart';

part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  final _activityClient = ActivityClient();
  final _postClient = PostClient();
  ActivityCubit() : super(ActivityInitial());

  void PublishActivity(ActivityDto activity) {
    try {
      emit(CreatingActivity());
      _activityClient.newActivity(activity).then((newActivity) {
        PostDto newPost = PostDto(
            likes_count: 0,
            comments_count: 0,
            id: 0,
            content: '',
            timestamp: '');
        return _postClient
            .newPostWithActivity(newActivity)
            .then((post) => emit(ActivityPosted(post)));
      });
    } catch (e) {
      emit(Error("Failed to publish activity. " + e.toString()));
    }
  }
}
