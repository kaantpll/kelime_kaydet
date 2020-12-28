import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kelime/bloc/kelime_bloc.dart';
import 'package:kelime/db/database_provider.dart';
import 'package:kelime/events/delete_event.dart';
import 'package:kelime/events/set.dart';
import 'package:kelime/model/kelime_model.dart';
import 'package:kelime/screen/kelime_form.dart';

class KelimeListe extends StatefulWidget {
  KelimeListe({Key key}) : super(key: key);

  @override
  _KelimeListeState createState() => _KelimeListeState();
}

class _KelimeListeState extends State<KelimeListe> {
  @override
  void initState() {
    super.initState();
    DatabaseProvider.db.getKelime().then((value) =>
        BlocProvider.of<KelimeBloc>(context).add(SetKelimeler(value)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: Container(
        child: BlocConsumer<KelimeBloc, List<Kelime>>(
          builder: (context, kelimeList) {
            return ListView.builder(
              itemCount: kelimeList.length,
              itemBuilder: (BuildContext context, int index) {
                Kelime kelime = kelimeList[index];
                if (kelimeList.isEmpty) {
                  return Center(
                    child: Text("List Boş"),
                  );
                }
                return FlipCard(
                  front: Column(
                    children: [
                      SizedBox(
                        height: 25.0,
                      ),
                      Container(
                        height: 150,
                        width: 340,
                        decoration: BoxDecoration(
                          color: HexColor("#F8A974"),
                        ),
                        child: Center(
                          child: Text(
                            kelime.turkce,
                            style:
                                TextStyle(fontSize: 36.0, color: Colors.white),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          DatabaseProvider.db.delete(kelime.id).then((value) =>
                              BlocProvider.of<KelimeBloc>(context)
                                  .add(DeleteKelime(value)));
                        },
                      ),
                    ],
                  ),
                  back: Column(
                    children: [
                      SizedBox(
                        height: 25.0,
                      ),
                      Container(
                        height: 150,
                        width: 340,
                        decoration: BoxDecoration(
                          color: HexColor("#33A489"),
                        ),
                        child: Center(
                          child: Text(
                            kelime.ingilizce,
                            style:
                                TextStyle(fontSize: 36.0, color: Colors.white),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          DatabaseProvider.db.delete(kelime.id).then((value) =>
                              BlocProvider.of<KelimeBloc>(context)
                                  .add(DeleteKelime(value)));
                        },
                      ),
                    ],
                  ),
                );

                /*ListTile(
                  title: Text(
                    kelime.turkce,
                    style: TextStyle(fontSize: 30),
                  ),
                  subtitle: Text(kelime.ingilizce),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  Divider(color: Colors.black),*/
              },
            );
          },
          listener: (BuildContext context, kelimeList) {},
        ),
      ),
    );
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
      backgroundColor: HexColor("#1F9DB1"),
      centerTitle: true,
      title: Text(
        "Kelimeler",
        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
      ),
      leading: Icon(
        Icons.menu,
        size: 32,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.note_add,
            size: 32,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => KelimeForm(),
              ),
            );
          },
        ),
      ],
    );
  }
}
