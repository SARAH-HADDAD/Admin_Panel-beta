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
import 'package:responsive_dashboard/style/colors.dart';
import 'package:responsive_dashboard/style/style.dart';
import 'fonctionnalités/GestionDesParkings/gestionDesParkings.dart';
import 'package:flutter_svg/avd.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Dashboard extends StatelessWidget {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
final user=FirebaseAuth.instance.currentUser;
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
      body: SafeArea(
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
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Header(),
                        SizedBox(
                          height: 30,
                        ),
                        // à modifier

                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {

                                      Navigator.pushReplacement(
                                          context, MaterialPageRoute(builder: (BuildContext context) => GestionParking()));
                                    print('onTap');
                                  },
                                child:
                                SizedBox(
                                    height: 220,
                                    width: 300,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: Center(
                                          child: Column(

                                            children: [
                                              SizedBox(
                                                height: SizeConfig.blockSizeVertical * 2,
                                              ),

                                                  Image.asset('assets/2.png',
                                                    width: 70,
                                                    height: 70,
                                                    fit: BoxFit.cover,),
                                              SizedBox(
                                                height: SizeConfig.blockSizeVertical * 2,
                                              ),
                                                  PrimaryText(
                                                    text: 'Gestion des parkings',
                                                    size: 18,
                                                    fontWeight: FontWeight.w700,
                                                  ),




                                              SizedBox(
                                                height: SizeConfig.blockSizeVertical * 2,
                                              ),
                                              PrimaryText(
                                                  text: 'ajout, modification\n ou suppression',
                                                  color: AppColors.secondary,
                                                  size: 16),
                                            ],
                                          ),
                                        ),
                                      ),

                                    )
                                ),
                                //
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print('onTap');
                                  },
                                  child:
                                  SizedBox(
                                      height: 220,
                                      width: 300,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Card(
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          child: Center(
                                            child: Column(

                                              children: [
                                                SizedBox(
                                                  height: SizeConfig.blockSizeVertical * 2,
                                                ),

                                                Image.asset('assets/4.png',
                                                  width: 70,
                                                  height: 70,
                                                  fit: BoxFit.cover,),
                                                SizedBox(
                                                  height: SizeConfig.blockSizeVertical * 2,
                                                ),
                                                PrimaryText(
                                                  text: 'Statistique',
                                                  size: 18,
                                                  fontWeight: FontWeight.w700,
                                                ),




                                                SizedBox(
                                                  height: SizeConfig.blockSizeVertical * 2,
                                                ),
                                                PrimaryText(
                                                    text: 'ajout, modification ',
                                                    color: AppColors.secondary,
                                                    size: 16),
                                              ],
                                            ),
                                          ),
                                        ),

                                      )
                                  ),
                                  //
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print('onTap');
                                  },
                                  child:
                                  SizedBox(
                                      height: 220,
                                      width: 300,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Card(
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          child: Center(
                                            child: Column(

                                              children: [
                                                SizedBox(
                                                  height: SizeConfig.blockSizeVertical * 2,
                                                ),

                                                Image.asset('assets/3.png',
                                                  width: 70,
                                                  height: 70,
                                                  fit: BoxFit.cover,),
                                                SizedBox(
                                                  height: SizeConfig.blockSizeVertical * 2,
                                                ),
                                                PrimaryText(
                                                  text: 'Utilisateur',
                                                  size: 18,
                                                  fontWeight: FontWeight.w700,
                                                ),




                                                SizedBox(
                                                  height: SizeConfig.blockSizeVertical * 2,
                                                ),
                                                PrimaryText(
                                                    text: 'test',
                                                    color: AppColors.secondary,
                                                    size: 16),
                                              ],
                                            ),
                                          ),
                                        ),

                                      )
                                  ),
                                  //
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    print('onTap');
                                  },
                                  child:
                                  SizedBox(
                                      height: 200,
                                      width: 450,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Card(
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          child: Center(
                                            child: Column(

                                              children: [
                                                SizedBox(
                                                  height: SizeConfig.blockSizeVertical * 2,
                                                ),

                                                Image.asset('assets/1.png',
                                                  width: 70,
                                                  height: 70,
                                                  fit: BoxFit.cover,),
                                                SizedBox(
                                                  height: SizeConfig.blockSizeVertical * 2,
                                                ),
                                                PrimaryText(
                                                  text: 'Les reclamations',
                                                  size: 18,
                                                  fontWeight: FontWeight.w700,
                                                ),




                                                SizedBox(
                                                  height: SizeConfig.blockSizeVertical * 2,
                                                ),
                                                PrimaryText(
                                                    text: 'les résclamations de l\'application et les parkings',
                                                    color: AppColors.secondary,
                                                    size: 16),
                                              ],
                                            ),
                                          ),
                                        ),

                                      )
                                  ),
                                  //
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print('onTap');
                                  },
                                  child:
                                  SizedBox(
                                      height: 200,
                                      width: 450,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Card(
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          child: Center(
                                            child: Column(

                                              children: [
                                                SizedBox(
                                                  height: SizeConfig.blockSizeVertical * 2,
                                                ),

                                                Image.asset('assets/5.png',
                                                  width: 70,
                                                  height: 70,
                                                  fit: BoxFit.cover,),
                                                SizedBox(
                                                  height: SizeConfig.blockSizeVertical * 2,
                                                ),
                                                PrimaryText(
                                                  text: 'Les annonces des objets trouvés et perdus',
                                                  size: 18,
                                                  fontWeight: FontWeight.w700,
                                                ),




                                                SizedBox(
                                                  height: SizeConfig.blockSizeVertical * 2,
                                                ),
                                                PrimaryText(
                                                    text: 'Signaler un objet trouvé',
                                                    color: AppColors.secondary,
                                                    size: 16),
                                              ],
                                            ),
                                          ),
                                        ),

                                      )
                                  ),
                                  //
                                ),
                              ],
                            ),

                            // Widget to display the list of project
                          ],
                        ),

                              /*


                              InfoCard(
                                  icon: 'assets/4.svg',
                                  label: '',
                                  amount: 'Statistique'),
                              InfoCard(
                                  icon: 'assets/3.svg',
                                  label: 'Utilisateur',
                                  amount: 'voir les utilisateur'),
                              */



                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PrimaryText(
                                  text: 'Balance',
                                  size: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.secondary,
                                ),
                                PrimaryText(
                                    text: '\$1500',
                                    size: 30,
                                    fontWeight: FontWeight.w800),
                              ],
                            ),
                            PrimaryText(
                              text: 'Past 30 DAYS',
                              size: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondary,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 3,
                        ),
                        Container(
                          height: 180,
                          child: BarChartCopmponent(),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PrimaryText(
                                text: 'History',
                                size: 30,
                                fontWeight: FontWeight.w800),
                            PrimaryText(
                              text: 'Transaction of lat 6 month',
                              size: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondary,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 3,
                        ),
                        HistoryTable(),
                        if (!Responsive.isDesktop(context)) DetailList()
                      ],
                    ),
                  ),
                )),
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 4,
                child: SafeArea(
                  child: Container(
                    width: double.infinity,
                    height: SizeConfig.screenHeight,
                    decoration: BoxDecoration(color: AppColors.secondaryBg),
                    child: SingleChildScrollView(
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                      child: Column(
                        children: [
                          AppBarActionItems(),
                          DetailList(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
