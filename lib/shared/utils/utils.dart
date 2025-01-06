import 'package:uuid/uuid.dart';

class Utils {

  static String getUuid() {
    Uuid uuid = const Uuid();
    return uuid.v4();
  }
}