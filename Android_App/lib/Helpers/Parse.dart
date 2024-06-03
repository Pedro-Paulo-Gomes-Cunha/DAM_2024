
class Helping {

  static double checkDouble(dynamic value) {
      if (value is String) {
      return double.parse(value);
      } else {
      return double.parse(value.toString());
      }
      }
}