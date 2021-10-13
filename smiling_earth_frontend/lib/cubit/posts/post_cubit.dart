import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smiling_earth_frontend/cubit/posts/post_client.dart';
import 'package:smiling_earth_frontend/models/post.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostInitial());
  final _client = PostClient();

  void getPosts() {
    try {
      _client.getPosts().then((posts) => emit(PostRetrived(posts)));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  void getUserPosts(int userId) {
    try {
      _client.getUserPosts(userId).then((posts) => emit(PostRetrived(posts)));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  void getTeamPosts(int teamId) {
    try {
      _client.getTeamPosts(teamId).then((posts) => emit(PostRetrived(posts)));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }
}

class PostDetailedCubit extends Cubit<List<DetailedPostDto>> {
  final _client = PostClient();

  PostDetailedCubit() : super([]);

  void getPost(int id) async => emit(await _client.getPost(id));
}
