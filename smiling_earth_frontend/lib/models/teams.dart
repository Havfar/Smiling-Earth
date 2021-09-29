class TeamsDto {
  final int? id;
  final String name;
  final int? memeber_count;
  final String symbol;

  TeamsDto(this.id, this.name, this.memeber_count, this.symbol);

  factory TeamsDto.fromJson(Map<String, dynamic> json) => new TeamsDto(
      json['id'], json['name'], json['memeber_count'], json['symbol']);
}
