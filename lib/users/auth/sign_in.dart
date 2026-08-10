import 'package:flutter/material.dart';
import 'package:localmarket/widget/app_colors.dart';
import 'package:localmarket/widget/app_fontweight.dart';
import 'package:localmarket/widget/app_padding.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
     appBar: AppBar(
        leading: Row(
          children: [
            Icon(Icons.storefront_outlined, color:AppColors.primary),
            const SizedBox(width: 6,),
            Text('LocalMarket', style: TextStyle(color:AppColors.primary, fontSize: 20, fontWeight: AppFontWeights.bold),)
          ],
        )
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.sizeOf(context).height,
          ),
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: AppPadding.card,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 300,
                  height:300,
                  decoration:BoxDecoration(
                    color:AppColors.tertiary,
                    borderRadius:BorderRadius.circular(10)
                  ),
                  child:Column(
                    
                    children: [
                      Text('Welcome Back!', style: TextStyle(color:AppColors.textPrimary, fontSize: 20, fontWeight: AppFontWeights.bold),),
                      const SizedBox(height: 6,),
                      Text('Please log in to continue to your account.',style: TextStyle(color:AppColors.textPrimary, fontSize: 14, fontWeight: AppFontWeights.regular),),
                       const SizedBox(height: 10,),
                      TextField(
                        style: TextStyle(color:AppColors.textPrimary),
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color:AppColors.textPrimary),
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
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
                ),
              ),
            ),
          )
        ],
      )
      )
      )
    );
  }
}