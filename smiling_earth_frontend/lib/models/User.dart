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
  final int id;
  final String first_name;
  final String last_name;
  final int user_id;
  String image =
      "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80";

  UserProfileDto(
      {required this.id,
      required this.first_name,
      required this.last_name,
      required this.user_id});

  factory UserProfileDto.fromJson(Map<String, dynamic> json) {
    return new UserProfileDto(
        id: json['id'],
        first_name: json['first_name'],
        last_name: json['last_name'],
        user_id: json['user']);
  }

  String getName() {
    return first_name + " " + last_name;
  }
}

class UserProfileDetailedDto {
  final String id;
  final String first_name;
  final String last_name;
  final String user_id;
  final int follower_count;
  final String email;

  UserProfileDetailedDto({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.user_id,
    required this.follower_count,
    required this.email,
  });
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
