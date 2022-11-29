import 'package:flutter/material.dart';
import 'package:proyecto_final/screens/databaseuser_helper.dart';
import 'package:proyecto_final/screens/theme_screen.dart';
import 'package:proyecto_final/models/users_model.dart';
import 'dart:io';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({ Key? key }) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
DatabaseHelper? _database;
String? emailU="",imageU="",nameU="",gitU="",phoneU="";
  bool ban=false;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _database = DatabaseHelper();
  }
  @override
  Widget build(BuildContext context) {
    if(ModalRoute.of(context)!.settings.arguments != null){
      final User = ModalRoute.of(context)!.settings.arguments as Map;
      
      ban=true;
      emailU = User['usuarioEmail'];
      phoneU = User['phoneUser'];
      imageU = User['imageUser'];
      nameU= User['nameUser'];
      
    }
      return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 46, 95, 174),
        child: ListView(
          children: [
            ban==true?
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://i0.wp.com/nayaritnoticias.com/wp-content/uploads/2022/11/62a53aaba796d.jpg?resize=696%2C392&ssl=1'),
                    fit: BoxFit.cover
                  ),
                ),
                currentAccountPicture: 
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context, 
                        '/addUser',
                        arguments:{
                          'idUser': 1,
                          'imagen': imageU,
                          'nombre': nameU,
                          'correo': emailU,
                          'numero': phoneU,
                          'urlGit': '',
                        } 
                      ).then((value) {
                        setState(() {});      
                      });
                    },
                    child: Hero(
                      tag: 'profile',
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(imageU!)
                      ),
                      
                    ),
                  ),
                accountName: Text(
                  nameU!,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                accountEmail: Text(
                  emailU!,
                  style: TextStyle(color: Colors.white),
                ),
              )
            :
            FutureBuilder(
              future: _database!.getUser(),
              builder: (context, AsyncSnapshot<List<UsersDAO>> snapshot) {
                if(snapshot.hasData&&snapshot.data?.length!=0){
                  return UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('https://i0.wp.com/nayaritnoticias.com/wp-content/uploads/2022/11/62a53aaba796d.jpg?resize=696%2C392&ssl=1'),
                        fit: BoxFit.cover
                      ),
                    ),
                    currentAccountPicture: 
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context, 
                            '/profile',
                            arguments:{

                              'idUser': snapshot.data![0].idUsuario,
                              'imagen': snapshot.data![0].imagen,
                              'nombre': snapshot.data![0].nombre,
                              'correo': snapshot.data![0].correo,
                              'numero': snapshot.data![0].numero,
                              'urlGit': snapshot.data![0].urlGit,
                            } 
                          ).then((value) {
                            setState(() {});      
                          });
                        },
                        child: Hero(
                          tag: 'profile',
                          child: CircleAvatar(
                            backgroundImage: FileImage(File(snapshot.data![0].imagen!)),
                          ),
                          
                        ),
                      ),
                    accountName: Text(
                      snapshot.data![0].nombre!,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    accountEmail: Text(
                      snapshot.data![0].correo!,
                      style: TextStyle(color: Colors.white),
                    ),
                  ); 
                }else{
                  return UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('https://i0.wp.com/nayaritnoticias.com/wp-content/uploads/2022/11/62a53aaba796d.jpg?resize=696%2C392&ssl=1'),
                        fit: BoxFit.cover
                      ),
                    ),
                    
                    currentAccountPicture: 
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/profile').then((value){setState(() {
                            
                          });});
                        },
                        child: Hero(
                          tag: 'profile',
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/default-user-image.jpg',),
                            
                          ),
                          
                        ),
                      ),
                      accountName: Text(
                      'No definido',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    accountEmail: Text(
                      'No definido',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
              } 
            )
            ,

            ListTile(
              leading: Image.asset('assets/balon.png'),
              trailing: Icon(Icons.chevron_right),
              title: Text('Equipos'),
              onTap: () async {
                
               Navigator.of(context).pushNamedAndRemoveUntil(
                    '/teams', (Route<dynamic> route) => false);
              
              },
            ),

            ListTile(
              leading: Image.asset('assets/balon.png'),
              trailing: Icon(Icons.chevron_right),
              title: Text('Cerrar Sesión'),
              onTap: () async {
                /*SharedPreferences _prefs =
                    await SharedPreferences.getInstance();
                _prefs.setBool('login', true);
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login', (Route<dynamic> route) => false);*/
              
              
              },
            ),
            
          ],
        ),
      ),
      body: ThemeScreen(),
    );
  }
}