import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelime/events/add_event.dart';
import 'package:kelime/events/delete_event.dart';
import 'package:kelime/events/kelime_event.dart';
import 'package:kelime/events/set.dart';
import 'package:kelime/events/update_events.dart';
import 'package:kelime/model/kelime_model.dart';

class KelimeBloc extends Bloc<KelimeEvent, List<Kelime>> {
  KelimeBloc(List<Kelime> initialState) : super(initialState);

  @override
  Stream<List<Kelime>> mapEventToState(KelimeEvent event) async* {
    if (event is SetKelimeler) {
      yield event.kelimeListe;
    } else if (event is KelimeAdd) {
      List<Kelime> newListState = List.from(state);
      if (event.newKelime != null) {
        newListState.add(event.newKelime);
      }
      yield newListState;
    } else if (event is DeleteKelime) {
      List<Kelime> newKelimeList = List.from(state);
      newKelimeList.removeAt(event.kelimeIndex);
      yield newKelimeList;
    } else if (event is UpdateKelime) {
      List<Kelime> yeniKelimeList = List.from(state);
      yeniKelimeList[event.kelimeIndex] = event.newKelime;
      yield yeniKelimeList;
    }
  }
}
