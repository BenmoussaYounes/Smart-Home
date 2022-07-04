class module {
  // id 	integer Unique identifier representing a specific device
  late int id;
  //typ_komponentu Type of device
  late String type;
  // opis_menu Name of device
  late String name;
  //opis_rozwiniety Extended name of device
  String? full_name;
// Minimal value of temperature controller (unused in other objects)
  int? min;
  // Maximal value of temperature controller (unused in other objects)
  int? max;
  // State of device
  String? state;
  //
  module({
    required this.id,
    required this.type,
    required this.name,
    this.full_name,
    this.min,
    this.max,
    this.state,
  });
}
