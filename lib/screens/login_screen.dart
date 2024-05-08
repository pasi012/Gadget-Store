import 'package:flutter/material.dart';
import 'package:gadget_store_app/screens/register_screen.dart';

import 'home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {

    if(_usernameController.text == "pasindu" && _passwordController.text == "123456"){
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
    }else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid User Name or Password'),
            duration: Duration(seconds: 3),
          )
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gadget Store Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            const SizedBox(height: 20,),
            Row(
              children: [
                const Text("Don't Have an Account"),
                const SizedBox(width: 10,),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
                  },
                    child: Text("Register".toUpperCase(), style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
