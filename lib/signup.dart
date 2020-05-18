import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyCustomForm extends StatefulWidget{
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm>{
  final _formKey = GlobalKey<FormState>();
  final _controllerEmail = new TextEditingController();
  final _controllerPassword = new TextEditingController();
  final _controllerUser = new TextEditingController();

  String _user;
  String _password;
  String _email;

  String user = '';
  String password = '';
  String email = '';

  String saveUser = '';
  String saveEmail = '';

  @override
  Widget build(BuildContext context) {
    setState( () {
      obtenerPreferencias( );
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[600],
        centerTitle: true,
        title: Text('Crea tu cuenta', style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(25),
            child: Center(
              child: Container(
                width: 90.0,
                height: 90.0,
                child: Image.network('https://images.vexels.com/media/users/3/137704/isolated/preview/87530af576941eeea98d685ae40c4d66-logotipo-de-formas-poligonales-geom--tricas-by-vexels.png'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon( Icons.person_pin, size: 30, color: Colors.white,
                              ),
                              onPressed: null),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 20.0, left: 20.0),
                              child: TextFormField(
                                validator: (valor) => valor.length < 3
                                    ? 'El nombre es muy corto'
                                    : null,
                                controller: _controllerUser,
                                onSaved: (valor) => _user = valor,
                                decoration:
                                InputDecoration(labelText: 'Usuario'),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.lock_outline, size: 30, color: Colors.white), onPressed: null),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 20.0, left: 20.0),
                              child: TextFormField(
                                controller: _controllerPassword,
                                validator: (valor) => valor.length < 3 ? 'La contraseña es muy corta' : null,
                                onSaved: (valor) => _password = valor,
                                decoration:
                                InputDecoration(labelText: 'Contraseña'),
                                obscureText: true,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.alternate_email, size: 30, color: Colors.white), onPressed: null),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 20.0, left: 20.0),
                              child: TextFormField(
                                controller: _controllerEmail,
                                validator: (valor) => !valor.contains('@') ? 'Ingresa un email valido (Debe contener @)' : null,
                                onSaved: (valor) => _email = valor,
                                decoration: InputDecoration(labelText: 'Email'),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Text('¿Ya tienes cuenta?'),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          height: 60,
                          child: RaisedButton(
                            onPressed: () {
                              final form = _formKey.currentState;
                              if (form.validate()) {
                                setState(() {
                                  user = _controllerUser.text;
                                  email = _controllerEmail.text;
                                  guardarPreferencias();
                                });
                                pushPage();
                              }
                            },
                            color: Colors.deepPurple[600],
                            child: Text(
                              'Registarse',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future _checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool('_sesion')) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return new Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurple[600],
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              'Bievenido',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: ListView(
            children: <Widget>[
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Los datos ingresados son:',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text('$saveUser'),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text('$saveEmail'),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: 60,
                    child: MaterialButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Cerrar sesión'),
                            content: Text(
                                '¿Estas seguro de querer cerrar la sesión?'),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('SI'),
                                onPressed: () {
                                  Navigator.of(context).pop('SI');
                                },
                              ),
                              FlatButton(
                                child: Text('NO'),
                                onPressed: () {
                                  Navigator.of(context).pop('NO');
                                },
                              )
                            ],
                          ),
                        ).then((result) {
                          if (result == 'SI') {
                            cerrarSesion();
                          }
                        });
                      },
                      color: Colors.deepPurple[600],
                      child: Text(
                        'Cerrar Sesión',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }));
    }
  }

  void pushPage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('_sesion', true);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[600],
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Bievenido',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Los datos ingresados son:',
                style: TextStyle(fontSize: 25),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(user),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(email),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  height: 60,
                  child: MaterialButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Cerrar sesión'),
                          content:
                          Text('¿Estas seguro de querer cerrar la sesión'),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('SI'),
                              onPressed: () {
                                Navigator.of(context).pop('SI');
                              },
                            ),
                            FlatButton(
                              child: Text('NO'),
                              onPressed: () {
                                Navigator.of(context).pop('NO');
                              },
                            )
                          ],
                        ),
                      ).then((result) {
                        if (result == 'SI') {
                          cerrarSesion();
                        }
                      });
                    },
                    color: Colors.deepPurple,
                    child: Text(
                      'Cerrar Sesión',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }));
  }

  Future<void> guardarPreferencias() async {
    SharedPreferences datos = await SharedPreferences.getInstance();
    datos.setString('usuario', _controllerUser.text);
    datos.setString('correo', _controllerEmail.text);
  }

  Future<void> obtenerPreferencias() async {
    SharedPreferences datos = await SharedPreferences.getInstance();
    setState(() {
      saveUser = datos.get('usuario') ?? user;
      saveEmail = datos.get('correo') ?? email;
    });
  }

  Future<void> cerrarSesion() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('_sesion', false);
    setState(() {
      saveUser = '';
      saveEmail = '';
    });
    Navigator.pop(context);
  }
}
