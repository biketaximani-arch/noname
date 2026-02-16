

import 'package:flutter/material.dart';

import 'package:noname/MVVM/AdminAndUser/HomePage/HomePageViewModel.dart';
import 'package:provider/provider.dart';

class Homepageview extends StatefulWidget {
  const Homepageview({super.key});

  @override
  State<Homepageview> createState() => _HomepageviewState();
}

class _HomepageviewState extends State<Homepageview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async{
            // button click logic

            final VM = Provider.of<Homepageviewmodel>(
              context,
              listen: false,
            );


            bool isVerified = await VM.sendNotification(
              mobile: "6379927606"
            );

            if (isVerified) {
              print("✅ OTP Verified");

            } else {
              print("❌ Invalid OTP");
            }

            print("Button pressed");
          },
          child: const Text("Click Me"),
        ),
      ),
    );
    ;
  }
}
