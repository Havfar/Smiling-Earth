import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:smiling_earth_frontend/cubit/posts/post_client.dart';
import 'package:smiling_earth_frontend/models/post.dart';

part 'like_state.dart';

class LikeCubit extends Cubit<LikeState> {
  LikeCubit() : super(LikeInitial());
  final _client = PostClient();

  void getLiked(int postId) {
    emit(CheckingPostHasBeenLiked());

    _client.getLike(postId).then((likeId) {
      if (likeId != -1) {
        emit(HasLikedPost(likeId));
      } else {
        emit(HasNotLikedPost());
      }
    });
  }

  void newLike(LikeDto like) {
    emit(CreatingLike());

    _client.postLike(like.post!.id).then((likeId) {
      if (likeId != null) {
        emit(HasLikedPost(likeId));
      } else {
        emit(HasNotLikedPost());
      }
    });
  }

  void deleteLike(int likeId) {
    emit(DeletingLike());
    _client.deleteLike(likeId).then((sucess) {
      if (sucess) {
        emit(HasNotLikedPost());
      }
    });
  }
}
