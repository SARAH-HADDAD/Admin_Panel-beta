import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:responsive_dashboard/component/appBarActionItems.dart';
import 'package:responsive_dashboard/component/barChart.dart';
import 'package:responsive_dashboard/component/header.dart';
import 'package:responsive_dashboard/component/historyTable.dart';
import 'package:responsive_dashboard/component/DetailList.dart';
import 'package:responsive_dashboard/component/sideMenu.dart';
import 'package:responsive_dashboard/config/responsive.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:responsive_dashboard/style/style.dart';
import 'package:flutter_svg/avd.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GestionParking extends StatefulWidget {

  const GestionParking({Key key}) : super(key: key);


  @override
  State<GestionParking> createState() => _Gestionparkingtate();
}

class _Gestionparkingtate extends State<GestionParking> {
  @override
  void initState() {
    super.initState();
  }
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final user=FirebaseAuth.instance.currentUser;

  // text fields' controllers
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _adresseController = TextEditingController();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _longController = TextEditingController();
  final TextEditingController _nbPlaceController = TextEditingController();
  final TextEditingController _prixController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _user_ratings_totalController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final CollectionReference _parking =
  FirebaseFirestore.instance.collection('parking');
  void dispose(){
    _nomController.dispose();
    _adresseController.dispose();
    _latController.dispose();
    _longController.dispose();
    _nbPlaceController.dispose();
    _prixController.dispose();
    _typeController .dispose();
    _user_ratings_totalController.dispose();

    //num-de-téléphone
    super.dispose();
  }
  Future<void> _create([DocumentSnapshot documentSnapshot]) async {

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nomController,
                  decoration: const InputDecoration(labelText: 'nom'),
                ),
                TextField(
                  controller: _adresseController,
                  decoration: const InputDecoration(labelText: 'adresse'),
                ),
                TextField(
                  controller: _typeController,
                  decoration: const InputDecoration(labelText: 'type'),
                ),
                TextField(
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  controller: _nbPlaceController,
                  decoration: const InputDecoration(
                    labelText: 'nombre de place',
                  ),
                ),
                TextField(
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  controller: _prixController,
                  decoration: const InputDecoration(
                    labelText: 'prix',
                  ),
                ),
                TextField(
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  controller: _latController,
                  decoration: const InputDecoration(
                    labelText: 'latitude',
                  ),
                ),
                TextField(
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  controller: _longController,
                  decoration: const InputDecoration(
                    labelText: 'longitude',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.pink, // background
                    onPrimary: Colors.black, // foreground
                  ),

                  child: const Text('Ajouter'),
                  onPressed: () async {

                    if (_latController.text.trim() != null
                        && _longController.text.trim() != null
                        && _adresseController.text.trim() != null
                        && _nbPlaceController.text.trim() != null
                        && _nomController.text.trim() != null
                        && _prixController.text.trim() != null
                        && _typeController.text.trim() != null
                    ) {
                      await FirebaseFirestore.instance.collection('parking').add({
                        'nom':_nomController.text.trim(),
                        'adresse':_adresseController.text.trim(),
                        'lat':double.parse(_latController.text.trim()),
                        'long':double.parse(_longController.text.trim()),
                        'nbPlace':int.parse(_nbPlaceController.text.trim()),
                        'prix':int.parse(_prixController.text.trim()),
                        'type':_typeController.text.trim(),
                        'user_ratings_total':0,
                        'rating':0,
                        'nbPlaceDispo':int.parse(_nbPlaceController.text.trim()),
                      });

                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );

        });
  }
  Future<void> _update([DocumentSnapshot documentSnapshot]) async {
    if (documentSnapshot != null) {

      _nomController.text = documentSnapshot['nom'];
      _adresseController.text=documentSnapshot['adresse'];
      _typeController.text=documentSnapshot['type'];
      _nbPlaceController.text=documentSnapshot['nbPlace'].toString();
      _prixController.text=documentSnapshot['prix'].toString();

    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nomController,
                  decoration: const InputDecoration(labelText: 'nom'),
                ),
                TextField(
                  controller: _adresseController,
                  decoration: const InputDecoration(labelText: 'adresse'),
                ),
                TextField(
                  controller: _typeController,
                  decoration: const InputDecoration(labelText: 'type'),
                ),
                TextField(
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  controller: _nbPlaceController,
                  decoration: const InputDecoration(
                    labelText: 'nombre de place',
                  ),
                ),
                TextField(
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  controller: _prixController,
                  decoration: const InputDecoration(
                    labelText: 'prix',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(

                  child: const Text( 'Update'),
                  onPressed: () async {
                    final String nom = _nomController.text;
                    final double rating =
                    double.tryParse(_ratingController.text);
                    if (_adresseController.text != null
                    && _typeController.text!= null
                    && _nbPlaceController.text!= null
                    && _prixController.text!= null
                    ) {

                      await _parking
                          .doc(documentSnapshot.id)
                          .update({
                        'nom':_nomController.text.trim(),
                        'adresse':_adresseController.text.trim(),
                        'nbPlace':int.tryParse(_nbPlaceController.text.trim()),
                        'prix':int.parse(_prixController.text.trim()),
                        'type':_typeController.text.trim(),

                          });
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _delete(String productId) async {
    await _parking.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _drawerKey,
      drawer: SizedBox(width: 100, child: SideMenu()),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:  PrimaryText(
                    text: 'Gestion des parkings',
                    size: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.w800),


      ),
      body:SafeArea(
        child:
            Expanded(
              flex: 10,
              child: Center(
                child: StreamBuilder(
                  stream: _parking.snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return ListView.builder(
                        itemCount: streamSnapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data.docs[index];
                          return Row(

                            children: [

                              SizedBox(width: 450,),
                              Center(
                                child: Card(

                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),),
                                  margin: const EdgeInsets.all(10),
                                  child: Container(
                                      width: 600,
                                      height:250,
                                      child:


                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,

                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 20, top: 30),
                                                    child: PrimaryText(
                                                      text :documentSnapshot['nom'],
                                                        size: 20,
                                                        fontWeight: FontWeight.w800
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 20, top: 18),
                                                    child: Text(
                                                      documentSnapshot['adresse'],
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 20, top: 18),
                                                        child: Text(
                                                          'Places disponibles : ${documentSnapshot['nbPlaceDispo'].toString()}',
                                                        ),
                                                      ),
                                                      Padding(
                                                          padding: const EdgeInsets.only(left: 20, top: 18),
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons.credit_card_rounded,
                                                                color: Colors.pink,
                                                                size: 24.0,
                                                                semanticLabel:
                                                                'Text to announce in accessibility modes',
                                                              ),
                                                              Text(
                                                                '${documentSnapshot['prix'].toString()}DA/heure',
                                                              ),
                                                            ],
                                                          )),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 20, top: 18),
                                                    child: Row(
                                                      children: <Widget>[
                                                        RatingBarIndicator(
                                                          rating: (documentSnapshot["rating"]).toDouble(),
                                                          itemBuilder: (context, index) => Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                          ),
                                                          itemCount: 5,
                                                          itemSize: 23.0,
                                                          direction: Axis.horizontal,
                                                        ),
                                                        Text(
                                                          " (${documentSnapshot["user_ratings_total"].toString()})                                                              ",
                                                          style: const TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      SizedBox(width: 50,),
                                                      IconButton(
                                                          icon: const Icon(Icons.edit),

                                                          onPressed: () =>
                                                              _update(documentSnapshot)),
                                                      IconButton(
                                                          icon: const Icon(Icons.delete),
                                                          onPressed: () =>
                                                              _delete(documentSnapshot.id)),
                                                      SizedBox(width: 50,),
                                                    ],
                                                  )
                                                ],
                                              ),




                                      /*IconButton(
                                              icon: const Icon(Icons.edit),
                                              onPressed: () =>
                                                  _update(documentSnapshot)),
                                          IconButton(
                                              icon: const Icon(Icons.delete),
                                              onPressed: () =>
                                                  _delete(documentSnapshot.id)),*/
                                    ),



                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),

      ),
// Add new product
        floatingActionButton: FloatingActionButton(
          onPressed: () => _create(),
          child: const Icon(Icons.add
          ),
          backgroundColor: Colors.pink,

        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );

  }
}

