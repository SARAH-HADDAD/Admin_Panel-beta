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
import 'package:responsive_dashboard/style/style.dart';
import 'package:flutter_svg/avd.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GestionParking extends StatefulWidget {

  const GestionParking({Key key}) : super(key: key);


  @override
  State<GestionParking> createState() => _Gestionparkingtate();
}

class _Gestionparkingtate extends State<GestionParking> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final user=FirebaseAuth.instance.currentUser;

  // text fields' controllers
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final CollectionReference _parking =
  FirebaseFirestore.instance.collection('parking');

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
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  controller: _ratingController,
                  decoration: const InputDecoration(
                    labelText: 'rating',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Create'),
                  onPressed: () async {
                    final String nom = _nomController.text;
                    final double rating =
                    double.tryParse(_ratingController.text);
                    if (rating != null) {
                      await _parking.add({"nom": nom, "rating": rating});

                      _nomController.text = '';
                      _ratingController.text = '';
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
      _ratingController.text = documentSnapshot['rating'].toString();
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
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  controller: _ratingController,
                  decoration: const InputDecoration(
                    labelText: 'rating',
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
                    if (rating != null) {

                      await _parking
                          .doc(documentSnapshot.id)
                          .update({"nom": nom, "rating": rating});
                      _nomController.text = '';
                      _ratingController.text = '';
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
      appBar: !Responsive.isDesktop(context)
          ? AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        leading: IconButton(
            onPressed: () {
              _drawerKey.currentState.openDrawer();
            },
            icon: Icon(Icons.menu, color: AppColors.black)),
        actions: [
          AppBarActionItems(),
        ],
      )
          : PreferredSize(
        preferredSize: Size.zero,
        child: SizedBox(),
      ),
      body:SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 1,
                child: SideMenu(),
              ),
            Expanded(
              flex: 10,
              child: SafeArea(
                child: StreamBuilder(
                  stream: _parking.snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                    if (streamSnapshot.hasData) {
                      return ListView.builder(
                        itemCount: streamSnapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data.docs[index];
                          return Card(
                            margin: const EdgeInsets.all(10),
                            child: ListTile(
                              title: Text(documentSnapshot['nom']),
                              subtitle: Text(documentSnapshot['rating'].toString()),
                              trailing: SizedBox(
                                width: 100,
                                child: Row(
                                  children: [
                                    IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () =>
                                            _update(documentSnapshot)),
                                    IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () =>
                                            _delete(documentSnapshot.id)),
                                  ],
                                ),
                              ),
                            ),
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
          ],
        ),
      ),
// Add new product
        floatingActionButton: FloatingActionButton(
          onPressed: () => _create(),
          child: const Icon(Icons.add),

        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
    );

  }
}

