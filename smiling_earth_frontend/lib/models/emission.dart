class EmissionDto {
  final int? id;
  final double emissions;
  final bool isSourceTransport;
  final int year;
  final int month;
  final int weekNo;

  EmissionDto(this.id, this.emissions, this.isSourceTransport, this.year,
      this.month, this.weekNo);

  factory EmissionDto.fromJson(Map<String, dynamic> json) => new EmissionDto(
      json['id'],
      json['emissions'],
      json['isSourceTransport'],
      json['year'],
      json['month'],
      json['weekNo']);

  Map<String, dynamic> toJson() => {
        "emissions": this.emissions,
        'isSourceTransport': this.isSourceTransport,
        'year': this.year,
        'month': this.month,
        'weekNo': this.weekNo
      };
}

class SimpleEmissionDto {
  final double transport;
  final double energy;

  SimpleEmissionDto(this.transport, this.energy);

  factory SimpleEmissionDto.fromJson(Map<String, dynamic> json) {
    return new SimpleEmissionDto(json['transport'], json['energy']);
  }

  double getTotalEmissions() {
    return transport + energy;
  }
}
