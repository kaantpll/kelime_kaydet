import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kelime/bloc/kelime_bloc.dart';
import 'package:kelime/db/database_provider.dart';
import 'package:kelime/events/add_event.dart';
import 'package:kelime/model/kelime_model.dart';
import 'package:kelime/screen/kelime_list.dart';

class KelimeForm extends StatefulWidget {
  final Kelime kelime;
  final int kelime_index;

  KelimeForm({this.kelime, this.kelime_index});

  @override
  _KelimeFormState createState() => _KelimeFormState();
}

class _KelimeFormState extends State<KelimeForm> {
  String _turkce;
  String _ingilizce;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.kelime != null) {
      _turkce = widget.kelime.turkce;
      _ingilizce = widget.kelime.ingilizce;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMethod(),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              _buildTurkce(),
              SizedBox(
                height: 10,
              ),
              _buildIngilizce(),
              SizedBox(
                height: 40,
              ),
              _saveButton(),

              /*RaisedButton(child: Text("Kaydet") ,onPressed: (){
                if(!_formKey.currentState.validate()){
                  return;
                }
                _formKey.currentState.save();

                Kelime kelime = Kelime(turkce: _turkce,ingilizce: _ingilizce);

                DatabaseProvider.db.insert(kelime).then((value) => BlocProvider.of<KelimeBloc>(context).add(KelimeAdd(value)));
                
                Navigator.pop(context);
             
              },)/* :Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: Text("Update"),
                    onPressed: (){
                      if(!_formKey.currentState.validate()){
                        print("form");
                        return;
                      };
                    },
                  )
                ],
              )*/*/
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBarMethod() {
    return AppBar(
      title: Text(
        "Kelimeler",
        style: TextStyle(fontSize: 36),
      ),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.home_filled,
            color: Colors.white,
            size: 32,
          ),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => KelimeListe())),
        ),
      ],
      backgroundColor: HexColor("#1F9DB1"),
    );
  }

  _buildTurkce() {
    return TextFormField(
      initialValue: _ingilizce,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        labelText: 'Türkçe',
        labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        fillColor: HexColor("#74A9F8"),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      maxLength: 30,
      style: TextStyle(fontSize: 24, color: Colors.white),
      validator: (String value) {
        if (value.isEmpty) {
          return "Boş Olamaz";
        }
        return null;
      },
      onSaved: (String value) {
        _turkce = value;
      },
    );
  }

  _buildIngilizce() {
    return TextFormField(
      initialValue: _ingilizce,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        labelText: 'Ingilizce',
        labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        fillColor: HexColor("#74A9F8"),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      maxLength: 30,
      style: TextStyle(fontSize: 24, color: Colors.white),
      validator: (String value) {
        if (value.isEmpty) {
          return "Boş Olamaz";
        }
        return null;
      },
      onSaved: (String value) {
        _ingilizce = value;
      },
    );
  }

  _saveButton() {
    return ButtonTheme(
      height: 61,
      minWidth: 166,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: RaisedButton(
        color: HexColor("#FF0404").withOpacity(0.60),
        child: Text(
          "Kaydet",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 32),
        ),
        onPressed: () {
          if (!_formKey.currentState.validate()) {
            return;
          }
          _formKey.currentState.save();

          Kelime kelime = Kelime(turkce: _turkce, ingilizce: _ingilizce);
          DatabaseProvider.db.insert(kelime).then(
                (value) => BlocProvider.of<KelimeBloc>(context).add(
                  KelimeAdd(value),
                ),
              );
          Navigator.pop(context);
        },
      ),
    );
  }
}
