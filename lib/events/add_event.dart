import 'package:kelime/events/kelime_event.dart';
import 'package:kelime/model/kelime_model.dart';

class KelimeAdd extends KelimeEvent {
  Kelime newKelime;

  KelimeAdd(Kelime kelime) {
    newKelime = kelime;
  }
}
