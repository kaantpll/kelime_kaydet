import 'package:kelime/events/kelime_event.dart';
import 'package:kelime/model/kelime_model.dart';

class UpdateKelime extends KelimeEvent {
  int kelimeIndex;
  Kelime newKelime;

  UpdateKelime(int index, Kelime kelime) {
    kelimeIndex = index;
    newKelime = kelime;
  }
}
