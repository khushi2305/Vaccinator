class Dose {
  int position;
  int week;
  bool isNormal;
  bool setReminder;

  Dose(int position, int week, bool isNormal, bool setReminder) {
    this.isNormal = isNormal;
    this.week = week;
    this.setReminder = setReminder;
    this.position = position;
  }
}

class Vaccine {
  String name;
  String code;
  String description;
  // List of doses where each dose is described by the number of weeks after which it should be given
  // and boolean variable which denotes special prescription is required or not
  // True - normal , False = Only for specific children
  List<Dose> doses;
  int price;

  Vaccine(String name, String code, String description, List<Dose> doses,
      int price) {
    this.name = name;
    this.code = code;
    this.doses = doses;
    this.description = description;
    this.price = price;
  }
}
