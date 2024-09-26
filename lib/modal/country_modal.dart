class CountryModal {
  Map<String, dynamic>? name;
  Map<String, dynamic>? flagsUrl;
  String? region;
  bool? isIndependent;
  bool? isSaved = false;

  CountryModal({
    this.name,
    this.flagsUrl,
    this.region,
    this.isIndependent,
  });

  factory CountryModal.fromJson({required Map<String, dynamic> map}) {
    return CountryModal(
      name: map['name'],
      flagsUrl: map['flags'],
      region: map['region'],
      isIndependent: map['independent'],
    );
  }
}
