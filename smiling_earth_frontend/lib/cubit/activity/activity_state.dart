part of 'activity_cubit.dart';

@immutable
abstract class ActivityState {}

class ActivityInitial extends ActivityState {}

class CreatingActivity extends ActivityState {}

class ActivityCreated extends ActivityState {
  final ActivityDto activityDto;

  ActivityCreated(this.activityDto);
}

class CreatingPost extends ActivityState {}

class ActivityPosted extends ActivityState {
  ActivityPosted();
}

class Error extends ActivityState {
  final String error;

  Error(this.error);
}
