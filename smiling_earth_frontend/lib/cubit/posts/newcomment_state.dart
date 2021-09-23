part of 'newcomment_cubit.dart';

@immutable
abstract class NewCommentState {}

class NewcommentInitial extends NewCommentState {}

class NewCommentError extends NewCommentState {}

class AddingNewComment extends NewCommentState {}

class NewCommentAdded extends NewCommentState {}
