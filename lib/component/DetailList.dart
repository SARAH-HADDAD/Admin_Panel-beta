import 'package:flutter/material.dart';
import 'package:responsive_dashboard/component/paymentListTile.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/data.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class DetailList extends StatefulWidget {
  const DetailList({Key key}) : super(key: key);

  @override
  State<DetailList> createState() => _DetailListState();
}

class _DetailListState extends State<DetailList> {
  //document IDs
  List<String> docIDs=[];

  //get docIDs
  Future getDocId()async{
    await FirebaseFirestore.instance.collection('users').get().then((snapchot) => snapchot.docs.forEach((document) {
      print(document.reference);
      docIDs.add(document.reference.id);
    },),);

  }
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

      SizedBox(
        height: SizeConfig.blockSizeVertical * 5,
      ),
      PrimaryText(
          text: 'Utilisateurs', size: 18, fontWeight: FontWeight.w800),
      SizedBox(
        height: SizeConfig.blockSizeVertical * 2,
      ),

      SizedBox(
        height: SizeConfig.blockSizeVertical * 5,
      ),
    ]);
  }

  }





