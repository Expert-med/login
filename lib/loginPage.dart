import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teste_login/homepage.dart';

import 'cadastroPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          TextFormField(controller: _emailController, decoration: InputDecoration(label: Text("Email"))),
          TextFormField(controller: _passwordController, decoration: InputDecoration(label: Text("Senha"))),
          ElevatedButton(onPressed: (){
            login();
          }, child: Text("Entrar")),
          TextButton(
            onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => cadastroPage(),
                ),
              );
          }, 
          child: Text("Criar conta"),
          ),
        ],
      ),
    );
}

  login()async{
    try{
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: _emailController.text, 
        password: _passwordController.text,
        );
        if(userCredential != null){
          Navigator.pushReplacement(
            context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
                ),
              );
        }
      }on FirebaseAuthException catch(e){
        if(e.code == 'user-not-found'){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Usuario não encontrado"),
            backgroundColor: Colors.redAccent,
            ),
          );
        }else if(e.code == "wrong-password"){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Senha incorreta"),
            backgroundColor: Colors.redAccent,
            ),
          );
        };
      }
  }
}