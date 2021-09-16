User mockUser = User(
    name: "John Doe",
    image:
        "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80");

class User {
  final String name;
  final String image;
  User({required this.name, required this.image});
}
