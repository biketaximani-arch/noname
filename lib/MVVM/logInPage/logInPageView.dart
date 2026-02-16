import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:noname/MVVM/OTPVerificationScreen/OTPVerificationScreenView.dart';
import 'package:noname/MVVM/logInPage/logInPageViewModel.dart';


class OtpLoginScreen extends StatefulWidget {
  const OtpLoginScreen({super.key});

  @override
  State<OtpLoginScreen> createState() => _OtpLoginScreenState();
}

class _OtpLoginScreenState extends State<OtpLoginScreen> {

  final TextEditingController _mobileController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LoginViewModel>().getUserById();
    });
  }

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  bool get isValidMobile => _mobileController.text.length == 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const SizedBox(height: 50),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Welcome to gate in Hand",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const Divider(),

          const SizedBox(height: 40),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Enter your mobile number",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 5),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "We'll send you a verification code",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),

          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400, width: 1.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [

                  Image.asset('assets/flag.png', width: 24, height: 24),

                  const SizedBox(width: 8),

                  const Text(
                    "+91",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(width: 8),

                  Container(
                    height: 24,
                    width: 1,
                    color: Colors.grey.shade400,
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: TextField(
                      controller: _mobileController,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      onChanged: (_) => setState(() {}),
                      decoration: const InputDecoration(
                        hintText: "Mobile number",
                        border: InputBorder.none,
                        counterText: "",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Spacer(),

          const Divider(),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "By continuing I agree to Red Gate Terms of Service and Privacy Policy",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: isValidMobile
                    ? () async {
                  final mobile = _mobileController.text.trim();

                  final success = await context
                      .read<LoginViewModel>()
                      .sendOTP(mobile: mobile);

                  if (success) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => OtpVerifyScreen(
                          mobile: mobile,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("OTP send failed")),
                    );
                  }
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  isValidMobile ? Colors.green : Colors.grey.shade400,
                ),
                child: const Text(
                  "Send OTP",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 50),
        ],
      ),
    );
  }
}



//
//
// class OtpLoginScreen extends StatefulWidget {
//   const OtpLoginScreen({super.key});
//
//   @override
//   State<OtpLoginScreen> createState() => _OtpLoginScreenState();
// }
//
// class _OtpLoginScreenState extends State<OtpLoginScreen> {
//
//   @override
//   void initState() {
//     super.initState();
// print("ok ");
//     // ✅ iOS viewDidAppear / onAppear equivalent
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<LoginViewModel>().getUserById();
//     });
//
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//   //  final viewModel = context.watch<LoginViewModel>();
//
//     return Scaffold(
//       backgroundColor: const Color(0xFFF6D9C8),
//       body: SafeArea(
//         child: Center(
//           child: Container(
//             margin: const EdgeInsets.all(20),
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const SizedBox(height: 20),
//
//                 // 🔐 Icon
//                 CircleAvatar(
//                   radius: 40,
//                   backgroundColor: const Color(0xFFFDE3D3),
//                   child: Icon(
//                     Icons.verified_user,
//                     size: 40,
//                     color: Colors.orange.shade400,
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 const Text(
//                   "OTP Verification",
//                   style: TextStyle(
//                     fontFamily: 'Poppins',
//                     fontSize: 22,
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//
//                 const SizedBox(height: 8),
//
//                 const Text(
//                   "Enter email and phone number to\nsend one time Password",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontFamily: 'Poppins',
//                     fontSize: 16,
//                   ),
//                 ),
//
//                 const SizedBox(height: 25),
//
//                 // Email Field
//                 TextField(
//                   decoration: InputDecoration(
//                     labelText: "Email",
//                     hintText: "Enter Your Email",
//                     suffixIcon: const Icon(Icons.edit),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 15),
//
//                 // Phone Field
//                 TextField(
//                   keyboardType: TextInputType.phone,
//                   decoration: InputDecoration(
//                     labelText: "Phone Number",
//                     hintText: "Enter Your Mobile Number",
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: BorderSide(color: Colors.orange.shade400),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: BorderSide(color: Colors.orange.shade400),
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 30),
//
//                 SizedBox(
//                   width: double.infinity,
//                   height: 50,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.orange.shade400,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                     ),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const OtpVerifyScreen(),
//                         ),
//                       );
//                     },
//                     child: const Text(
//                       "Continue",
//                       style: TextStyle(
//                         fontFamily: 'Poppins',
//                         fontSize: 16,
//                         fontWeight: FontWeight.w800,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
