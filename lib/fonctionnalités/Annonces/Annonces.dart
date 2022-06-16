import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/avd.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Annonces extends StatefulWidget {

  const Annonces({Key key}) : super(key: key);


  @override
  State<Annonces> createState() => _Annoncestate();
}

class _Annoncestate extends State<Annonces> {
  @override
  void initState() {
    super.initState();
  }
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final user=FirebaseAuth.instance.currentUser;

  // text fields' controllers
  String _selectedLocation;
  List<String> _locations = ['parking a ', 'parking b '];
  TextEditingController dateinput1= TextEditingController();
  TextEditingController textController1= TextEditingController();
  TextEditingController numtelController= TextEditingController();
  final CollectionReference _declaration_objet_perdu =
  FirebaseFirestore.instance.collection('declaration_objet_perdu');
  void dispose(){
    textController1.dispose();
    numtelController.dispose();
    _selectedLocation;
    dateinput1.dispose();
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
                  controller: textController1,
                  decoration: const InputDecoration(labelText: 'commentaire',hintText: 'exprimez-vous...',),

                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(25, 10, 25, 11),
                  child:
                  DropdownButtonFormField( hint: Text('selectionner le parking '),

                    value: _selectedLocation,

                    decoration: InputDecoration(
                      labelText: ' parking ',
                      hintText: 'selectionnez parking ...',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFDBE2E7),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFDBE2E7),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      filled: true,
                      fillColor: Color(0xFFF4F4F4),
                      contentPadding:
                      EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                      prefixIcon: Icon(
                        Icons.local_library_outlined,
                        color: Color(0xFF6C63FF),
                        size: 26,
                      ),
                    ),
                    // Not necessary for Option 1
                    onChanged: (newValue) { setState(() { _selectedLocation = newValue; }); },
                    items: _locations.map((location) { return DropdownMenuItem( child: new Text(location),
                      value: location, ); }).toList(), ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(25, 10, 25, 11),
                  child:
                  TextField(
                    controller: dateinput1, //editing controller of this TextField
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'date de la perte ',
                      hintText: 'date ...',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFDBE2E7),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFDBE2E7),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      filled: true,
                      fillColor: Color(0xFFF4F4F4),
                      contentPadding:
                      EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
                      prefixIcon: Icon(
                        Icons.date_range,
                        color: Color(0xFF6C63FF),
                        size: 26,
                      ),
                    ),
                    readOnly: true,  //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime pickedDate = await showDatePicker(
                          context: context, initialDate: DateTime.now(),
                          firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101)
                      );

                      if(pickedDate != null ){
                        print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                        setState(() {
                          dateinput1.text = formattedDate; //set output date to TextField value.
                        });
                      }else{
                        print("Date is not selected");
                      }
                    },
                  ),),
                TextField(
                  controller: numtelController,
                  decoration: const InputDecoration(labelText: 'numéro de téléphone'),
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

                    if (textController1.text.trim() != null) {
                      await FirebaseFirestore.instance.collection('declaration_objet_perdu').add({
                        "commentaire": textController1.text.trim(),
                        "parking": _selectedLocation.trim(),
                        "date de perte": dateinput1.text.trim(),
                        "numéro de tel": numtelController.text.trim(),
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
    await _declaration_objet_perdu.doc(productId).delete();

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
              text: 'Les annonces des objets trouvés et perdus',
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
                stream: _declaration_objet_perdu.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    return ListView.builder(
                      itemCount: streamSnapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data.docs[index];
                        return Row(

                          children: [
                            Center(
                              child: Card(

                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),),
                                margin: const EdgeInsets.fromLTRB(200,20,200,0),
                                child: Container(
                                  width: 1000,
                                  height:350,
                                  child:


                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(width:400 ,height: 350,
                                          child: CachedNetworkImage(
                                            imageUrl:documentSnapshot['image'],

                                            fit: BoxFit.fitWidth,
                                          ),),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,

                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 20, top: 30),
                                            child: PrimaryText(
                                                text :documentSnapshot['title'],
                                                size: 25,
                                                fontWeight: FontWeight.w800
                                            ),
                                          ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 20, top: 20),
                                                    child: PrimaryText(
                                                        text :'Nom de parking : ',
                                                        size: 15,fontWeight: FontWeight.w800
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 0, top: 20),
                                                    child: Text(documentSnapshot['parking'],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20, top: 20),
                                        child: PrimaryText(
                                          text :'Adresse de parking : ',
                                          size: 15,fontWeight: FontWeight.w800
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 0, top: 20),
                                        child: Text(documentSnapshot['adresse'],
                                        ),
                                      ),
                                    ],
                                  ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 20, top: 20),
                                                child: PrimaryText(
                                                    text :'Date : ',
                                                    size: 15,fontWeight: FontWeight.w800
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 0, top: 20),
                                                child: Text(documentSnapshot['date de perte'],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 20, top: 20),
                                                child: PrimaryText(
                                                    text :'Numéro de téléphone : ',
                                                    size: 15,fontWeight: FontWeight.w800
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 0, top: 20),
                                                child: Text(documentSnapshot['numéro de tel'],
                                                ),
                                              ),
                                            ],
                                          ),
                                         //description
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 20, top: 20),
                                                child: PrimaryText(
                                                    text :'Description : ',
                                                    size: 15,fontWeight: FontWeight.w800
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 0, top: 20),
                                                child: Text(documentSnapshot['commentaire'],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
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

