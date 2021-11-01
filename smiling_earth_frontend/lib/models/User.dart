import 'package:smiling_earth_frontend/models/avatar.dart';

UserProfile mockUser = UserProfile(
    name: "John Doe",
    image:
        "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80");

class UserProfile {
  final String name;
  final String image;
  UserProfile({required this.name, required this.image});
}

class UserProfileDto {
  final String firstName;
  final String lastName;
  final int userId;
  final Avatar? avatar;
  String image =
      "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80";

  UserProfileDto(
      {required this.firstName,
      required this.lastName,
      required this.userId,
      required this.avatar});

  factory UserProfileDto.fromJson(Map<String, dynamic> json) {
    return new UserProfileDto(
        firstName: json['first_name'],
        lastName: json['last_name'],
        userId: json['user_id'],
        avatar: Avatar.fromJson(json['avatar']));
  }

  String getName() {
    return firstName + " " + lastName;
  }
}

class MyProfileDetailedDto {
  final int? userId;
  final String firstName;
  final String lastName;
  final int followerCount;
  final int followingCount;
  final String bio;

  final String image =
      "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80";

  MyProfileDetailedDto(
      {this.userId,
      required this.firstName,
      required this.lastName,
      required this.followerCount,
      required this.followingCount,
      required this.bio});

  factory MyProfileDetailedDto.fromJson(Map<String, dynamic> json) {
    return new MyProfileDetailedDto(
        firstName: json['first_name'],
        lastName: json['last_name'],
        userId: json['user_id'],
        followerCount: json['followers_count'],
        followingCount: json['followingCount'],
        bio: json['bio']);
  }

  String getName() {
    return firstName + " " + lastName;
  }
}

class UserProfileDetailedDto {
  final int? userId;
  final String firstName;
  final String lastName;
  final int? followerCount;
  final int? followingCount;
  final String bio;
  final String image =
      "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80";

  UserProfileDetailedDto(
      {this.userId,
      this.followerCount,
      this.followingCount,
      required this.firstName,
      required this.lastName,
      required this.bio});

  factory UserProfileDetailedDto.fromJson(Map<String, dynamic> json) {
    return new UserProfileDetailedDto(
        firstName: json['first_name'],
        lastName: json['last_name'],
        userId: json['user_id'],
        followerCount: json['followers_count'],
        followingCount: json['following_count'],
        bio: json['bio']);
  }

  String getName() {
    return firstName + " " + lastName;
  }
}

class User {
  int id;
  String username;
  String token;

  User({required this.id, required this.username, required this.token});

  factory User.fromDatabaseJson(Map<String, dynamic> data) => User(
        id: data['id'],
        username: data['username'],
        token: data['token'],
      );

  Map<String, dynamic> toDatabaseJson() =>
      {"id": this.id, "username": this.username, "token": this.token};

  // static Future<User> fromJson(Map elementAt) {}
}

class FollowerDto {
  final bool isFollowing;
  final UserProfileDto user;

  FollowerDto({required this.isFollowing, required this.user});
}
