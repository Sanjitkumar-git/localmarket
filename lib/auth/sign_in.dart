import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
     
      body: Center(
        child: Column(
          children: [
            Container(
              width: 300,
              height:300,
              decoration:BoxDecoration(
                color:Colors.white,
                borderRadius:BorderRadius.circular(10)
              ),
              child:Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 4),
                   TextField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                   ),
                ],
              )
            )
          ],
        ),
      )
    );
  }
}