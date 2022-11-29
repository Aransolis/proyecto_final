import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_final/firebase/teams_firebase.dart';

class TeamsScreen extends StatefulWidget {
  const TeamsScreen({ Key? key }) : super(key: key);

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  TeamsFirebase? _placesFirebase;
  bool isChecked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _placesFirebase = TeamsFirebase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciones que participan'),
        backgroundColor: Theme.of(context).backgroundColor,
        
      ),
      body: StreamBuilder(
        stream: _placesFirebase!.getAllTeams(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var place = snapshot.data!.docs[index];
                return ListTile(
                  leading: Image.network(place.get('TeamLogo')),
                  title: Text(place.get('TeamName')+ '    '+ place.get('IdTeam').toString()),
                  subtitle: Text(place.get('TeamShort')),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                        children: [
                         
                        ]
                      ),
                  ),
                  
                );
              },
              
            ); 
            
            //Text(snapshot.data!.docs.first.get('titlePlace'));
          }else{
            if(snapshot.hasError){
              return const Center(
                child: Text('Error'),
              );
            }else{
              return const CircularProgressIndicator();
            }
          }
        },
      ),
      
    );
  }
}