
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:responsive_dashboard/dashboard.dart';
import 'package:responsive_dashboard/style/colors.dart';
import 'package:provider/provider.dart';
import 'auth_services.dart';

class Login extends StatefulWidget {


  @override
  _LoginState createState() => _LoginState();


}

class _LoginState extends State<Login> {
  TextEditingController emailController=new TextEditingController();
  TextEditingController passwordController=new TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final email = TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Adresse e-mail',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    );

    final password = TextFormField(
      initialValue: '',
      controller: passwordController,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Mot de passe',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    );

    final loginButton = Container(
        width: MediaQuery.of(context).size.width / 2.5,
        height: MediaQuery.of(context).size.height / 15,
        child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)),
            child: Text('Se connecter', style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15),),

            onPressed: () {
              final String email = emailController.text.trim();
              final String password = passwordController.text.trim();
              if(email.isEmpty){
                print("entrez votre email");
              }
              else{
                if(password.isEmpty){
                  print("entrez votre mot de passe");
                }
                else{
                  context.read<AuthService>().login(email,password);
                }
              }
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Dashboard()),
              );
            }));





    final forgotLabel = FlatButton(
      child: Text(
        'Mot de passe oublié?',
          style: TextStyle(
              color: Colors.pink,
              fontWeight: FontWeight.bold,
              fontSize: 15)
      ),
      onPressed: () {},
    );
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
                height: MediaQuery.of(context).size.height / 1.5,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 62.0),
                    Center(
                        child: Text(
                          "Admin",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    SizedBox(height: 48.0),
                    email,
                    SizedBox(height: 8.0),
                    password,
                    SizedBox(height: 12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        forgotLabel,
                      ],
                    ),
                    SizedBox(height: 18.0),
                    loginButton,
                    SizedBox(height: 20.0),

                        Center(
                          child: FlatButton(
                            child: Text(
                              'Créer un compte',
    style: TextStyle(
    color: Colors.pink,
    fontWeight: FontWeight.bold,
    fontSize: 15)

                            ),
                            onPressed: () {},
                          ),
                        ),
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
