import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatefulWidget {


  @override
  _SignUpState createState() => _SignUpState();


}

class _SignUpState extends State<SignUp> {
  @override
  void initState() {
    super.initState();
  }
//text controllers
  final _emailController=TextEditingController(text: "");
  final _passwordController=TextEditingController(text: "");
  final _confirmpasswordController=TextEditingController(text: "");
  final _codeController=TextEditingController(text: "");
  final _firstnameController=TextEditingController(text: "");
  final _lastnameController=TextEditingController(text: "");
  final _phoneNumberController=TextEditingController(text: "");

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _codeController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    _phoneNumberController.dispose();

    //num-de-téléphone
    super.dispose();
  }
  @override
  Future signUp() async{
    if(ConfirmAdmin()){
      //creat user
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
       email: _emailController.text.trim(),
        password: _passwordController.text.trim());
    // add user details
addUserDetails(
    _firstnameController.text.trim(),
    _lastnameController.text.trim(),
    _emailController.text.trim(),
    int.parse(_phoneNumberController.text.trim()));
/*
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _codeController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
    _phoneNumberController.dispose();
*/
   }

  }
  Future addUserDetails(String firstName, String lastName, String email, int phoneNumber ) async{
    await FirebaseFirestore.instance.collection('users').add({
      'first name':firstName,
      'last name':lastName,
      'admin':true,
      'email':email,
      'phone_number':phoneNumber,
    });
  }
  bool ConfirmAdmin(){
    if(_codeController.text.trim()=="7D17D2"){
      if(_passwordController.text.trim()==_confirmpasswordController.text.trim()){
        return true;
      }
    }
    return false;
  }
  @override
  Widget build(BuildContext context) {
    final email = TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Adresse e-mail',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    );

    final password = TextFormField(
      controller: _passwordController,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Mot de passe',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    );

    final SignUpButton = Container(
        width: MediaQuery.of(context).size.width / 2.5,
        height: MediaQuery.of(context).size.height / 15,
        child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)),
            child: Text('S’inscrire', style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15),),

            onPressed: () {
              signUp();
             /*
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (BuildContext context) => Dashboard()));
             */

            }));






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
                height: MediaQuery.of(context).size.height / 1.2,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 30.0),
                    Center(
                        child: Text(
                          "Créer un compte d’administrateur",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink,
                          ),
                        )),
                    SizedBox(height: 30.0),
                    TextFormField(
                      controller: _firstnameController,
                      autofocus: false,
                      decoration: InputDecoration(
                        hintText: 'Prénom',
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      controller: _lastnameController,
                      autofocus: false,
                      decoration: InputDecoration(
                        hintText: 'Nom',
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      controller: _phoneNumberController,
                      autofocus: false,
                      decoration: InputDecoration(
                        hintText: 'numéro de téléphone',
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    email,
                    SizedBox(height: 8.0),
                    password,
                    SizedBox(height: 8.0),
                    TextFormField(
                      controller: _confirmpasswordController,
                      autofocus: false,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Confirmer le mot de passe',
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      controller: _codeController,
                      autofocus: false,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Entrez le code special des administrateurs',
                        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      ),
                    ),
                    SizedBox(height: 40.0),
                    SignUpButton,


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