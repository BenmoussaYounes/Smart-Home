class Scenario {
  late int id_provider;
  late String title;
  late int color;
  late int? id_scenario;
  Scenario({
    required this.id_provider,
    required this.title,
    required this.color,
    this.id_scenario,
  });
}
