import 'package:flutter/material.dart';
import 'package:localmarket/widget/app_colors.dart';

class PartnerSignInPage extends StatelessWidget {
  const PartnerSignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
     
      body: Center(
        child: Column(
          children: [
            Container(
              width: 400,
              height:500,
              decoration:BoxDecoration(
                color:AppColors.tertiary,
                borderRadius:BorderRadius.circular(10)
              ),
              child:Column(
                children: [
                  TextField(
                    style: TextStyle(color:AppColors.textPrimary),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color:AppColors.textPrimary),
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 4),
                   TextField(
                    style: TextStyle(color:AppColors.textPrimary),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color:AppColors.textPrimary),
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