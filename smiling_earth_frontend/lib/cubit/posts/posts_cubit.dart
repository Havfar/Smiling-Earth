import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smiling_earth_frontend/cubit/posts/post_client.dart';
import 'package:smiling_earth_frontend/models/post.dart';

// class PostsCubit extends Cubit<PostsState> {
class PostsCubit extends Cubit<List<PostDto>> {
  final _client = PostClient();

  // PostsCubit() : super(PostsInitial());
  PostsCubit() : super([]);

  void getPosts() async => emit(await _client.getPosts());
}

class PostDetailedCubit extends Cubit<List<DetailedPostDto>> {
  final _client = PostClient();

  PostDetailedCubit() : super([]);

  void getPost(int id) async => emit(await _client.getPost(id));
}
