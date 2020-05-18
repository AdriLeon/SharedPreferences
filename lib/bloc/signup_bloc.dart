import 'dart:async';

class LoginBloc{


  final _emailController = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast();
  final _userController = StreamController<String>.broadcast();
}