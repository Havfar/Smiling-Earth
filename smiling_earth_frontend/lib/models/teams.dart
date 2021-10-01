class TeamsDto {
  final int? id;
  final String name;
  final int? memeberCount;
  final String symbol;

  TeamsDto(this.id, this.name, this.memeberCount, this.symbol);

  factory TeamsDto.fromJson(Map<String, dynamic> json) => new TeamsDto(
      json['id'], json['name'], json['memeber_count'], json['symbol']);
}

class TeamDetailedDto {
  final int? id;
  final String name;
  final String symbol;
  final String? description;
  final String? location;

  TeamDetailedDto(
      this.id, this.name, this.symbol, this.description, this.location);

  factory TeamDetailedDto.fromJson(Map<String, dynamic> json) =>
      new TeamDetailedDto(json['id'], json['name'], json['symbol'],
          json['description'], json['location']);
}
