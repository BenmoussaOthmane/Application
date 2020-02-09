import 'package:flutter/material.dart';

class UPdateusers extends StatefulWidget {
  static final String id = 'updateusers';
  @override
  _UPdateusersState createState() => _UPdateusersState();
}

class _UPdateusersState extends State<UPdateusers> {
  final _formKey = GlobalKey<FormState>(); 
  String _users ,_name,_email ,_phone;
  _submit(){
     if(_formKey.currentState.validate()){
       _formKey.currentState.save();
       


     }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Update Users',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height:200 ,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(
                  Radius.circular(200)
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 30,
                    color: Colors.black26
                  )
                ],
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/72377054_2431601263788855_84064381272326144_n (1).jpg'),
                )
              ),
            ),
            SizedBox(height: 10,),
            Form(
              key: _formKey,
               child:Column(
                 children: <Widget>[
                   Container(
              child: FlatButton(
                    onPressed: null,
                    child:Text(
                      'Update Image',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5
                        ),
                    )),
            ),
            Container(
              // height: 20,
              width: MediaQuery.of(context).size.width/1.2,
              // color: Colors.black,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'User Name',
                  icon: Icon(Icons.person),
                ),
                // validator: (input) => input.isEmpty ? 'Format non valid' : null,
                onSaved: (input) => _users= input,
              ),
            ),
            SizedBox(height: 18,),
            Container(
              // height: 20,
              width: MediaQuery.of(context).size.width/1.2,
              // color: Colors.black,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Name',
                  icon: Icon(Icons.person),
                ),
                // validator: (input) => input.isEmpty ? 'Format non valid' : null,
                onSaved: (input) => _name= input,
              ),
            ),
            SizedBox(height: 18,),
            Container(
              // height: 20,
              width: MediaQuery.of(context).size.width/1.2,
              // color: Colors.black,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Eamail',
                  icon: Icon(Icons.alternate_email),
                ),
                // validator: (input) => !input.contains('@') ? 'Format non valid' : null,
                onSaved: (input) => _email= input,
              ),
            ),
            SizedBox(height: 18,),
            Container(
              // height: 20,
              width: MediaQuery.of(context).size.width/1.2,
              // color: Colors.black,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Telephone',
                  icon: Icon(Icons.phone),
                ),
                // validator: (input) => input.isEmpty ? 'Format non valid' : null,
                onSaved: (input) => _phone= input,
              ),
            ),
            SizedBox(height: 30,),
                 ],
               ),
            ),
            
            Container(
              height: MediaQuery.of(context).size.height/14,
              width: MediaQuery.of(context).size.width/1.4,
              // color: Colors.black,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.1,1.0],
                  colors: [
                    Color(0xFF058416),
                    Color(0xFF4DC15C),
                  ]
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(20)
                )
              ),
              child: FlatButton(
                onPressed: _submit,
                child:Text(
                  'Update',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2
                  ),
                )
                ),
            )
          ],
        ),
      ),
    );
  }
}