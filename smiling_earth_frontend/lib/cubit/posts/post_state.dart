part of 'post_cubit.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostError extends PostState {
  final String error;

  PostError(this.error);
}

class PostRetrived extends PostState {
  final List<PostDto> posts;

  PostRetrived(this.posts);
}
