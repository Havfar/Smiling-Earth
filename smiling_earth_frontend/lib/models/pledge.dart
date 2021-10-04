class PledgeDto {
  final int? id;
  final String icon;
  final String title;
  final String description;
  final String backgroundColor;

  PledgeDto(
      {this.id,
      required this.icon,
      required this.title,
      required this.description,
      required this.backgroundColor});

  Map<String, dynamic> toJson() => {
        "icon": this.icon,
        "title": this.title,
        "color:": this.backgroundColor.toString()
      };

  factory PledgeDto.fromJson(Map<String, dynamic> json) => new PledgeDto(
        id: json['id'],
        icon: json['icon'],
        title: json['title'],
        description: json['description'],
        backgroundColor: json['color'],
      );
}
