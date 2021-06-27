import './vaccine.dart';

class AllVaccines {
  static List<Vaccine> allVaccines = [
    new Vaccine(
        'Bacillus Calmette–Guérin',
        'BCG',
        'This vaccine protects from so and so disease',
        [new Dose(1, 1, true, true)],
        100),
    new Vaccine(
        'Hepatitis B',
        'Hep-B',
        'This vaccine protects from so and so disease',
        [
          new Dose(1, 1, true, true),
          new Dose(2, 4, true, true),
          new Dose(3, 8, true, true),
          new Dose(4, 12, false, false)
        ],
        1000),
    new Vaccine(
        'Pneumococcal conjugate vaccine',
        'PCV',
        'This vaccine protects from so and so disease',
        [new Dose(1, 1, true, true)],
        1495)
  ];
}
