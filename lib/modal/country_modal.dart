class CountryModal {
  Map<String, dynamic>? name;
  Map<String, dynamic>? flagsUrl;
  String? region;
  String? subRegion;
  bool? isIndependent;
  String? startOfWeek;
  bool isSaved = false;

  CountryModal({
    this.name,
    this.flagsUrl,
    this.region,
    this.subRegion,
    this.startOfWeek,
    this.isIndependent = false,
  });

  factory CountryModal.fromJson({required Map<String, dynamic> map}) {
    return CountryModal(
      name: map['name'],
      flagsUrl: map['flags'],
      region: map['region'],
      subRegion: map['subregion'],
      isIndependent: map['independent'] ?? false,
      startOfWeek: map['startOfWeek'],
    );
  }
}
