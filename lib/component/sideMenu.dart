import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_dashboard/config/size_config.dart';
import 'package:responsive_dashboard/style/colors.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        width: double.infinity,
        height: SizeConfig.screenHeight,
        decoration: BoxDecoration(color: AppColors.secondaryBg),
        child: SingleChildScrollView(
                  child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             Container(
               height: 100,
               alignment: Alignment.topCenter,
               width: double.infinity,
               padding: EdgeInsets.only(top: 20),
               child: SizedBox(
                    width: 35,
                    height: 20,
                    child: SvgPicture.asset('assets/mac-action.svg'),
                  ),
             ),

              IconButton(
                  iconSize: 35,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  icon: Image.asset(
                    'assets/0.png',

                  ),
                  onPressed: () {}),
              IconButton(
                  iconSize: 35,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  icon: Image.asset(
                    'assets/1.png',

                  ),
                  onPressed: () {}),
              IconButton(
                  iconSize: 35,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  icon: Image.asset(
                    'assets/2.png'
                  ),
                  onPressed: () {}),
              IconButton(
                  iconSize: 35,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  icon: Image.asset(
                    'assets/3.png',

                  ),
                  onPressed: () {}),
              IconButton(
                  iconSize: 35,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  icon:Image.asset(
                    'assets/4.png',

                  ),
                  onPressed: () {}),
              IconButton(
                  iconSize: 35,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  icon: Image.asset(
                    'assets/5.png',

                  ),
                  onPressed: () {}),
              IconButton(
                  iconSize: 35,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  icon: Image.asset(
                    'assets/6.png',

                  ),
                  onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}