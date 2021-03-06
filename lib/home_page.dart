import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseReference databaseReference;

  Future getSensorValue() async {
    databaseReference = FirebaseDatabase.instance.reference();

    DataSnapshot dataSnapshot = await databaseReference.once();
    print(dataSnapshot.value);

    return dataSnapshot.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: getSensorValue(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data['slot4']);

            return Column(
              children: [
                Expanded(
                    child: Row(
                  children: [
                    Expanded(
                        child: ParkingSpot(
                      color: snapshot.data["slot1"] != '1'
                          ? Colors.green
                          : Colors.red,
                    )),
                    Expanded(
                        child: ParkingSpot(
                      color: snapshot.data["slot2"] != '1'
                          ? Colors.green
                          : Colors.red,
                    )),
                  ],
                )),
                Expanded(
                    child: Row(
                  children: [
                    Expanded(
                        child: ParkingSpot(
                      color: snapshot.data["slot3"] != '1'
                          ? Colors.green
                          : Colors.red,
                    )),
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: snapshot.data["slot4"] != '1'
                              ? Colors.green
                              : Colors.red),
                    )),
                  ],
                )),
                RaisedButton(
                  onPressed: () {
                    print(snapshot.data["slot2"]);
                    setState(() {});
                  },
                  child: Container(
                    child: Center(
                      child: Text(
                        'Refresh',
                        style: TextStyle(color: Colors.black, fontSize: 27.0),
                      ),
                    ),
                    height: 100.0,
                    color: Colors.white,
                  ),
                ),
              ],
            );
          }
          return Center(
            child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}

class ParkingSpot extends StatelessWidget {
  final Color color;
  ParkingSpot({this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0), color: color),
    );
  }
}
