import 'package:kelime/events/kelime_event.dart';
import 'package:kelime/model/kelime_model.dart';

class SetKelimeler extends KelimeEvent {
  List<Kelime> kelimeListe;

  SetKelimeler(List<Kelime> kelimeler) {
    kelimeListe = kelimeler;
  }
}
