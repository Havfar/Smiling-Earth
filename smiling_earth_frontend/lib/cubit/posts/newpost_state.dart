part of 'newpost_cubit.dart';

@immutable
abstract class NewPostState {}

class NewPostInitial extends NewPostState {}

class CreatingNewPost extends NewPostState {}

class NewPostCreated extends NewPostState {
  final PostDto post;

  NewPostCreated(this.post);
}

class NewPostError extends NewPostState {
  final String errorMessage;

  NewPostError(this.errorMessage);
}
