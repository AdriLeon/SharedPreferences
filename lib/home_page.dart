import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<bool> saveNamePreference(String name) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("name", name);
  return prefs.commit();
}

Future<String> getNamePreference() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String name = prefs.getString("name");
  return name;
}

class HomePage extends StatefulWidget{
  static String routeName = "/homePage";

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage>{
  String _name = "";

  @override
  void initState() {
    getNamePreference().then(updateName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home"),
      ),
      body: new ListTile(
        title: new Text(_name),
      ),
    );
  }

  void updateName(String name){
    setState(() {
      this._name = name;
    });
  }
}