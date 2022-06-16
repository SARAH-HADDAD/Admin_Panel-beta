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
                                      Container(width:400 ,height: 350,
                                        child: Image.network('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAQEAAADECAMAAACoYGR8AAAAaVBMVEX///+Wlpbx8fGPj4+Tk5Pw8PD19fWoqKiNjY23t7e7u7v8/PyXl5f39/dmZmbAwMDn5+fV1dWenp7g4OCurq6lpaXe3t7IyMidnZ3Pz8/X19dsbGzFxcWysrJxcXF1dXWAgIBgYGB+fn6POUtpAAAO1UlEQVR4nO1dCZajIBBFQZOIW1zinu3+h5wCNIKa3SQ6bb3XM92JInw/BdQCCC2yyCKLLLLIIossskgrpkl/XYXfCtV1w/l1JX4qugEQ/GkaOIAAyF+mAWUsWGjw52lgcgj0P08D408PCtTkGCw0MBZt8FkalCkh2utCiO19rnJMPj0oRPiN5gvB0acqV4vJp4gfokH2PgAAQfaRurXC50efGRScMQAACMwP1E0R0zA+MzeI3lEBrZAV+vSA5XCFaIwN9XYcCmgEb0eu2YCMPyhQZI7DAI7BF0bserU05pNG6gMcgU+PB1x4V9CN0WgwVh/g8o1+wG1HfNE8TmnOeAxg8o1+gDgNjLHmRyP2AY7AV/rBmLaTfMw+wATnI7TvERHT5Le1wch9gMmX+kGrDd7DYOQ+wBH4Uj9AnAa1NqCI5p71glTjAwAQbFjRiY8+PkOUtEFCMHlJPgAAWyozwSvj0wAgRgOGgbldf6QlbwrB/udZwLWBoZt+8Jm3+aaQjy8WmXBtYDolniAGxPoGAogabLlk+vHYI/sIQr6CAIpKvlQwk+nRYP0dBFY49idKg28hAENP6TAMnORD49ur8jUEoMMFvsNpsJoUDb6IAAy+Hu8JTjYlGnwTAUaDkNPAGMH2P5Z8FwGggWVybTAeDWBuC0LSIAhSjf/6XMlfRgAqnO5GpAG0PraysF2BO35eRuQZFL6OgKYxGsAU0dxqb9KA4NTaDa70jWyFHwX4BwhoxK5pUL1DA6xZ/o0nOln82OzrFwhA7Tc61wa5/SoNcLC9u6bzN49g8BsEgAY5p4H+Gg1wsHvosaZ1H4MfIQCNqIxXaUC0xy3+9xXuzxCAdtQ02DxJA2w9ZdPY3YH4dwhcaGDu0idoQOzwyWfT2xD/EgFGZ0ED62Ea4OgFo1Z+a3rwSwSYqTIS2uBBGtg4eenxxo3if4cAXnkbZq8VNHhEa1939lDTD/M83/nXHNZOfLX0340FO14xxmtBg/C+JRUPTYGcnRez2TGu1wdVNmgBv+p3+RUCpBTVZ3YDkgkaeHdoQPoA0DzquhSga6VeDwSKrnlefoSAjes68leDV8KEdpsGfQaYHhkGjeBVf8p0hQW/4gCuO+yGiPdW06C8rrVxt03OLdVBcNwbNYd1wc84UDsqNvUXQAOGgeNfU1m9SMDtnRUwjDMdZ4gzODf6GQc6CECNE5NFZF7xq5CNWqCpGhuFmYRpQuXDzuzZH5p2TAcB7ZZBnaRqeaFEAGh9sMlgJDR1f1eqT9mo86ehuNQJIQC8LZkJzTT7BvWOFszW0k1xpktfqSqfxOoEYUAbTgkBVuGaBh2DOi6V0srLtwRXCjaG112Gp4oycPrKY1oINDToWFI7faAFAGZT8hf5gFmI2AoL+nF5E0OAGT/Cnl8FKwNbgu2mccoAmdnDOjRVdEFA7IkjYGvY69BAjfrZNcjgSH672/Ta+pKs5Nt748HkENBav4pf23cUNag3N2A5YeSmQ5Z4t6oyRQQav0rtXlMpEDcFyDOkO7EZSi/qkmCSCHC/iln7VWyl/gnuA2DcXVXasirozDonigCzBgqD+pYEUjlmA4A0POb3DQtKP+iEqE4Wgda9Jiv8er5DqvYj7xELG5ZHzZlwQLv4Vcx2TmPUc0GJ1Y+5H5VlhaU8c8oINH6VNm2JU8CWBgc6bIIdQFMiQaiANmkEuEFdSluqtUD7Qul1818XTFkTKN9MHAGNaCJAnfvHE3ExvvSBhwEAkWqjrJ6mjoBmS6HJqQDl8jqfiTqXTUzbOSHAGS+UgV7rwUvSpPUEAIouNGRFMHkE+MxH0MAMmePjMhI+mYZrS9XB0upo6gg0ap9vcMD9Kg2djWcdrtJoIOuPySPQrP9EvooTputaD6bPAaD4m6wZISDFPZvChJb1G/GQyONhMiMEpEWBX5vQeNrSoNn3NgJRm0shLw0mjoBs3cgxSZwmbemFdA0JzHA+HJCXQKD7uUHdMF7L2ZEGA39GHJAQSLiXNeGjgl7irr3vrpB2OTUnBKR5TMkvXTtiYHw+UUFCwJgzAtAORyjEZxMVZoqArAf4pWyCkIcOz157MlGhLWpOvUCykor1DNZhIBCJCvpTNCAz1YRxW4YwbMA02V+3BvXHaSAPrLv5ICAPYaLzkq2YDgq/CkwR+zSwmS+997GsUrL5zAdk9UX5+GentXOUpNfyVfAq8/0w6UTQEcm+7s0IgYEVXXMHaQzqKg2I1thCEqVs2e1QzQcBWzbtdD3jrV9FiVBvMVM8A1jyMsqTqYkj0ETdcdn1tV6TqNDmqygeJhkzSac6c7KQyBqcDnlZ23wV0r1euYNI8bjhnKxksiocDopU81U6wVNt8bJCKedkKdWIxOpwcPBv8lUMFkXfDTi6qE2ZG4F8+/QRkF0dV0LERaKCaQINsBpPe7GLyxrVnJPPSFNtvNfMw8Te8pWCvlmrHLgMiEop8/EbiiulNtGrNoFL2lIy8Fxb3YssVu6cPgKK2/faFm22VicqqPuAXVbBwdCHc0FA3UAqvn5dnaggbwDVPFbRj52J1RwQkIl9y09SR6i3+6Q2FnWFRt1ZxQwQUKOAklvL4TpRQdCgWTnbmhJRmMwQAaIE1t9wGNsNDQAEq40vVfpAb2I5BwQ0TdYE9LargNHAABaEwSXyUknPKmeJgLprknnTTG4T5lcBCMy6rWqCnj79uOLBVqlzXfPOxgV1ooLDDOp2Jyy9H3c0CwSUpS2D4E5+JuH5Ktygvk6UndcGtrucCQLwJuWG0HsG0gsN1BTNoW2PZ4JAJ8D+fhwlISJRwVSyC4Yir+aCgKZ1EsfCe/sW4CDk46I0ReyZ2X6IQC/b7q4o4cVM6I3cRI5A7HcO1hheVMyHA/3dVU3rKgYEx8wgoJyvEg6H4P8MgbpfB0OVutKqqlesk6QDzSKEVI3aEFvpMxr4MDROCYHaHbbFT0QB4M1AyX4ZiC1gm8Zjrcol9VfTwPTXV/jys+x7At1UL59z/pJqcAMKJ8ysKEjTNIg3Zd5LO3f40SJXN4D64R4UnRzZhyCIX9lsmpoDfpUpIPCKEPvWPlRXJRFbvgzu/DMzBAZy0O+LEeDGoD5Ag9khAMtf/f7zZOGmYby5tgHU/BBg6x70+H7jTcQVsXNzcAOoGSIALzR9bFsymDRJ7W0M6p2df2aJgPbI1mxAEsPqRBZsHbO3889MEWA8SO7sOB5WvdF2iAazRYBvNJJfA4H63tB8mVtSTbEPWPPtjBFglmEce7vu0ED9rNKuTrYuG0A1NJgxAkIIxjZMhrM83+3ybeJFwZ19WtsNoMRls0dANIoQsS/XQ0de1H4VRxjU/wsEGnl0ncm1gcEM6pjY/xUCj8tlA6iA/FEE2MRSbKVf/lUE2g2gwu8cUTxBBJgTghsOvnNS9dO5cV8Qu6HBVw4sHwgHnYIwv4r+pQPLp3mYEQtNFqc0f54Gz2dIfkdw1RzI+XEa+O/u1f8JIWtmgG8M6p+mAS3TZhvFqQiJascKP5DzG+fWO+a0RHrpnz+3fvLyLW0wZRHpvH+aBmKThy9ogwmLmB79bRpwL+uiDRZtoI93YPk8pRN+9BdloUFzYPmiDXT9b9OAK4M/rg2+s2iestTa4D0aUJ+JcyfkI8qQ7lMavXZaETJXO/7zkOirEBmXi/PVrfZRdqaEbrzFAnoqXJD4diHFClUnnx77UaMPiXHykH54MMTKgAv9U4O1dbr9hp23R0Xqxog6VVFJkT/08k/z2T5C/lkOhbxcolx2jUmG6w193N7fvdl3GwQ8lyJKO18rhZhPBm71CnBXrPDzkT239MSxjGHp5c0TncTbMQToHtFtCD8GysoQLvYS/nb8xMuc+sIc7ZhZy8nqj5gYSembgICz9eFBmZew/7aGk1gi0bZ5aO6j3GM0ceAJvpvBBTuOAOuhO6+8Hqf4piasETgCAvEpjQ4HQDR207g4ioLDokiPq0OEwozzxXGr4/Hglkmxdg/QzOpEqvMequfv4cLgbCO0dc/x0a0tfFv3kB5WhQc9wULG/hyvTyVyTtHBXrsYsYce7eIA958D+3x04amsB/hFdEiPblAjsHbT9BRfbcMICKDEraB6G3gBbgT1S9hZawL0I29mwSPn6X6F6KEAIhwPKUKlWyLzwG7fw194D9h5RQAlshMt4oMofw/QohQQ0IEHmz38YcETij10KcvN4MHwLMoYuN6X8CD4yIAfvzjAC4jcHUdgVcDVofv4sZHPIVAczoe9K3aS8Hcha0xxvJy9ortM+TktAoi1HW1cxmX+HbvpuOb8AAEEtm4Co0siSBDyDu27AoHEFcZfhjN7dIwwB8qC4tZnxBSGJRDgioP9xRA4EMP3jcOHSEALbZtlrD00AEKmrIE+cU8HkULouzwZbt8isK94lU32J/y6cs9wE4YG8tD6Y4qS/YELf2Vbl6VSmTUHkHd2T8QHBHipZ4KO3DeeAVxHtgOBeUEg43WruCYUBZ47BwaNhoDbbH+xKVhlC/EcfyW0MXsNKgckBKCCnMWIc2DFdDZwICukpKsdNIVeOMCKyo97CsoEPmUcYG+ecg4cNQUBwYEN58D+Q23vIrAqHNaRU+QHrEuId4oOR9bgPgKOQKByoYtmxZr1Y1PoAZMpMJREfAxzCraVa1xzwGLtSk6Ow7t5Ceh5nCNHwEFFoGCP3dR6IC2gU5r9c9BGQuCiY7fuscIx2Ve0OG+sYyE0YQafatqew8ReGuVgbE6m0AMhfE3soKgoGzTWAfQCmMTgyj5txChluetqndZjgXUKrAgwdtz4HAUu6wHEjaszY82RQaXDRXwsgAuq1LXFjMg4HKJof/7MOpBSr1axFOVRtEWGZSHHi1Zl87ywgilxyS+iZc5/gNwe40C5q7/WLYsip7RydAgY6Terjd8M03kV5cgLoVBo5m6zqrZME1pGFSX8im218tiQn/C5AFxkej4yPMNnBVMUeg6lTrmKng/a/7b4DKRaH94T57HLZibVqfJ3x/1DVP0/EUDlen+IB48w7YlTWPcvmp38ZTvFIossssgiiyyyyCKLLLLIIossssgiiywyQfkHNGbtYCZ4nJkAAAAASUVORK5CYII='),
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

