class AppLanguageModel {
  const AppLanguageModel({
    this.countryCode = '',
    this.languageCode = '',
  });

  factory AppLanguageModel.fromJson(Map<String, dynamic> json) =>
      AppLanguageModel(
        countryCode: json['country_code'] ?? '',
        languageCode: json['language_code'] ?? '',
      );

  final String countryCode;
  final String languageCode;

  Map<String, dynamic> toJson() => {
        'country_code': countryCode,
        'language_code': languageCode,
      };

  @override
  String toString() {
    return 'AppLanguageModel(country_code: $countryCode, language_code: $languageCode)';
  }
}
