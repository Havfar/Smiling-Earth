import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:smiling_earth_frontend/cubit/posts/post_client.dart';
import 'package:smiling_earth_frontend/models/post.dart';

part 'newpost_state.dart';

class NewPostCubit extends Cubit<NewPostState> {
  final _client = PostClient();
  NewPostCubit() : super(NewPostInitial());

  void NewPost(PostDto post) {
    emit(CreatingNewPost());

    try {
      _client.newPost(post).then((newPost) => emit(NewPostCreated(newPost)));
    } catch (e) {
      emit(NewPostError("Failed to create new post. " + e.toString()));
    }
  }
}
