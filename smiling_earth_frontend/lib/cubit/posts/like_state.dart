part of 'like_cubit.dart';

@immutable
abstract class LikeState {}

class LikeInitial extends LikeState {}

class LikeError extends LikeState {}

class CreatingLike extends LikeState {}

class DeletingLike extends LikeState {}

class HasLikedPost extends LikeState {
  final int likeId;

  HasLikedPost(this.likeId);
}

class HasNotLikedPost extends LikeState {}

class CheckingPostHasBeenLiked extends LikeState {}
