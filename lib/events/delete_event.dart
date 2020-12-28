import 'package:kelime/events/kelime_event.dart';

class DeleteKelime extends KelimeEvent {
  int kelimeIndex;

  DeleteKelime(int index) {
    kelimeIndex = index;
  }
}
