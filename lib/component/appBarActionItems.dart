import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AppBarActionItems extends StatelessWidget {
   AppBarActionItems({
    Key key,
  }) : super(key: key);
  final user=FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(width: 5,),
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
            'https://cdn.shopify.com/s/files/1/0045/5104/9304/t/27/assets/AC_ECOM_SITE_2020_REFRESH_1_INDEX_M2_THUMBS-V2-1.jpg?v=8913815134086573859',
          ),
        ),
        SizedBox(width: 40,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,

             mainAxisSize : MainAxisSize.max,

          verticalDirection : VerticalDirection.down,
            children: [

//here i need to ndir la photo ta3 sah w name ta3 sah i have to check 9bel ila null sinon i print the shit
              Text('Sarah Haddad',
                style: TextStyle( fontSize: 15,color: Colors.black)),
              SizedBox(width: 30,),

              Text(''+user.email,
                style: TextStyle( fontSize: 10,color: Colors.black38),
              ),
            ],
          ),
        SizedBox(width: 40,),
        IconButton(onPressed: (){FirebaseAuth.instance.signOut();},
          color: Colors.pink,
          icon: const Icon(Icons.logout),

        )
      ],
    );
  }
}
