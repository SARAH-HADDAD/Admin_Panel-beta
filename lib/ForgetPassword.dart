import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'creerUnCompte.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _emailController=TextEditingController(text: "");
  @override
  void dispose(){
    _emailController.dispose();
    super.dispose();
}
  @override
  Future passwordReset () async{
try{
  await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
  showDialog(context: context,
      builder: (context){
        return AlertDialog(
          content: Text("Lien de réinitialisation de mot de passe envoyé! vérifier votre e-mail"),
        );
      }
  );

}on FirebaseAuthException catch(e){
  print(e);
 showDialog(context: context,
     builder: (context){
   return AlertDialog(
     content: Text(e.message.toString()),
   );
     }
 );
}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
              ),
            ],
          ),
          Center(
            child: Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Container(
                padding: EdgeInsets.all(42),
                width: MediaQuery.of(context).size.width / 2.5,
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 40.0),
                    Center(
                        child: Text(
                          "Réinitialisation de mot de passe",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink
                          ),
                        )

                    ),
                    SizedBox(height: 40.0),
                    TextFormField(
                      controller: _emailController,
                      autofocus: false,
                      decoration: InputDecoration(
                        hintText: 'Adresse e-mail',
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      ),
                    ),
                    SizedBox(height: 25.0),
                    Center(
                        child: Text(
                          "Nous vous enverrons un lien de réinitialisation de mot de passe",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        )

                    ),
                    SizedBox(height: 25.0),
                    Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: MediaQuery.of(context).size.height / 15,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: Text('Réinitialiser', style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15),),

                            onPressed: () {
                              passwordReset();

                            }))
                  ],
                ),


              ),
            ),
          ),
        ],
      ),
    );
  }
}
