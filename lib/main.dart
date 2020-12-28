import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kelime/bloc/kelime_bloc.dart';
import 'package:kelime/events/set.dart';
import 'package:kelime/screen/kelime_list.dart';

import 'model/kelime_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<KelimeBloc>(
      create: (context) => KelimeBloc(List<Kelime>()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Sqflite Tutorial",
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: KelimeListe(),
      ),
    );
  }
}
