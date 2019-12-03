import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:geo_diagnostique_app/Ouvrage.dart';
import 'package:geo_diagnostique_app/Config.dart';

class Localisation extends StatefulWidget {
  final Ouvrage selectedOuvrage;
  Localisation(this.selectedOuvrage);
  @override
  LocalisationState createState() => LocalisationState();
}

class LocalisationState extends State<Localisation> {
  Ouvrage ouvrage;
  Config size = new Config();
  TextStyle textSize = new TextStyle(fontSize: Config.fontSize);
  EdgeInsetsGeometry textPadding = EdgeInsets.all(Config.screenPadding);
  List<TextEditingController> controllerList = new List(4);
  @override
  void initState(){
    super.initState();
    for(int i=0;i<controllerList.length;i++){
      controllerList[i] = new TextEditingController();
    }
    controllerList[1].text = "Sélectionner";
    if(widget.selectedOuvrage.implantation!="") controllerList[1].text = widget.selectedOuvrage.implantation;
    controllerList[2].text = "Sélectionner";
    if(widget.selectedOuvrage.nomRue != "") controllerList[0].text = widget.selectedOuvrage.nomRue;
    if(widget.selectedOuvrage.typeReseau!='séparatif EU'&& widget.selectedOuvrage.typeReseau.isNotEmpty &&
    widget.selectedOuvrage.typeReseau!='séparatif EP'&&widget.selectedOuvrage.typeReseau!='unitaire'){
      controllerList[3].text=widget.selectedOuvrage.typeReseau;
      controllerList[2].text = 'autre : ';
    }
    else if(widget.selectedOuvrage.typeReseau != "") controllerList[2].text = widget.selectedOuvrage.typeReseau;
  }
  
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return new Scaffold(
        body: Builder(
      builder: (context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Config.screenPadding),
          child: Center(
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Text("Nom de la rue :"),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(Config.screenPadding),
                        child: TextField(
                          controller: controllerList[0],
                          decoration: InputDecoration(
                            labelText: 'Nom de la rue',
                            labelStyle: TextStyle(color: Config.textColor),
                            focusColor: Config.color,
                            fillColor: Colors.white,
                            focusedBorder: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(color: Config.color),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          onChanged:(String text){ 
                            setState(() {
                              widget.selectedOuvrage.nomRue = text;
                            });
                          }
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Implantation :"),
                    Padding(
                      padding: EdgeInsets.all(Config.screenPadding),
                      child: DropdownButton<String>(
                        hint: SizedBox(
                          width: 320.0,
                          child: Text(
                            controllerList[1].text,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: Config.fontSize, color: Colors.black),
                          ),
                        ),
                        style: TextStyle(fontSize: Config.fontSize, color: Colors.black),
                        items: <String>[
                          'chaussée',
                          'trottoir',
                          'accotement',
                          'terrain naturel',
                          'domaine privé'
                        ].map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: SizedBox(
                              width: 320.0,
                              child: Text(
                                value,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: Config.fontSize,color: Colors.black),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            controllerList[1].text=newValue;
                            widget.selectedOuvrage.implantation = newValue;
                          });
                        }
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Type de réseau"),
                    Padding(
                      padding: EdgeInsets.all(Config.screenPadding),
                      child: DropdownButton<String>(
                        hint: SizedBox(
                          width: 320.0,
                          child: Text(
                            controllerList[2].text,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: Config.fontSize, color: Colors.black),
                          ),
                        ),
                        style: TextStyle(
                            fontSize: Config.fontSize, color: Colors.black),
                        items: <String>[
                          'séparatif EU',
                          'séparatif EP',
                          'unitaire',
                          'autre : '
                        ].map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: SizedBox(
                              width: 320.0,
                              child: Text(
                                value,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: Config.fontSize,
                                    color: Colors.black),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String newValue) {
                          setState(() {
                            controllerList[2].text = newValue;
                            if (controllerList[2].text != 'autre : ') {
                             widget.selectedOuvrage.typeReseau = newValue;
                            }
                          });
                        },
                      ),
                    ),
                    Visibility(
                      child: Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(Config.screenPadding),
                          child: TextField(
                            controller: controllerList[3],
                            decoration: InputDecoration(
                              labelText: 'Type de Reseau',
                              labelStyle: TextStyle(color: Config.textColor),
                              focusColor: Config.color,
                              fillColor: Colors.white,
                              focusedBorder: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(color: Config.color),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            onChanged: (String text){
                              setState(() {
                                widget.selectedOuvrage.typeReseau=text;
                              });
                            },
                          ),
                        ),
                      ),
                      visible:  controllerList[2].text == 'autre : ',
                    ),
                  ],
                ),
              ], //Children
            ),
          ),
        ),
      ),
    ));
  }
}
