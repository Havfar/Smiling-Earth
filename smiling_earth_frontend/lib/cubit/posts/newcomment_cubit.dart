import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:smiling_earth_frontend/cubit/posts/post_client.dart';
import 'package:smiling_earth_frontend/models/post.dart';

part 'newcomment_state.dart';

class NewcommentCubit extends Cubit<NewCommentState> {
  NewcommentCubit() : super(NewcommentInitial());
  final _client = PostClient();

  void newComment(CommentDto comment) {
    emit(AddingNewComment());

    _client.postComment(comment).then((newComment) {
      emit(NewCommentAdded());
    });
  }
}
