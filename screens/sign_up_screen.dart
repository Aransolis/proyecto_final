import 'package:flutter/material.dart';
import 'package:proyecto_final/firebase/email_authentication.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController txtConName = TextEditingController();
  TextEditingController txtConEmail = TextEditingController();
  TextEditingController txtConPass = TextEditingController();
  EmailAuthentication? _emailAuth;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailAuth = EmailAuthentication();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        color: Colors.blue,
        child: Padding(
          padding: EdgeInsets.only(top: 40),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
              children: [
                TextField(
                  controller: txtConName,
                  decoration: InputDecoration(
                      labelText: 'Nombre Completo',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      hintText: 'Nombre Completo'),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                TextField(
                  controller: txtConEmail,
                  decoration: InputDecoration(
                      labelText: 'Correo',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      hintText: 'ejemplo@correo.com'),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                TextField(
                  style: TextStyle(
                      backgroundColor: Colors.black, color: Colors.black),
                  controller: txtConPass,
                  decoration: InputDecoration(
                      labelText: 'Contraseña',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      hintText: 'Contraseña1234@'),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Container(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      child: const Text(
                        'Save',
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () async  {
                           showDialog(context: context, builder: (context){
                        return Center(child: CircularProgressIndicator());
                      },
                      );
                         _emailAuth!.createUserWithEmailAndPassword(
                //email: '17031150@itcelaya.edu.mx', password: '12345678  ')
                email: txtConEmail.text,
                password: txtConPass.text)
            .then((value) {});
         
           Navigator.pushNamed(context, '/login');
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(70, 70),
                        shape: const CircleBorder(),
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
