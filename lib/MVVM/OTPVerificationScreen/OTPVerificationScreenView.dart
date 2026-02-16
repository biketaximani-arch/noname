import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:noname/MVVM/Security/Dashboard/DashboardView.dart';
import 'package:noname/core/AppTextStyles.dart';
import 'package:noname/MVVM/OTPVerificationScreen/OTPVerificationScreenViewModel.dart';
import 'package:noname/MVVM/AdminAndUser/Dashboard/DashboardView.dart';


class OtpVerifyScreen extends StatefulWidget {
  final String mobile;

  const OtpVerifyScreen({
    super.key,
    required this.mobile,
  });

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {

  // ⏱️ RESEND TIMER
  int _resendSeconds = 60;
  Timer? _timer;

  bool get canResend => _resendSeconds == 0;

  // 🔢 OTP CONFIG
  final int otpLength = 6;

  final List<TextEditingController> _otpControllers =
  List.generate(6, (_) => TextEditingController());

  final List<FocusNode> _focusNodes =
  List.generate(6, (_) => FocusNode());

  // ✅ OTP COMPLETE CHECK
  bool get isOtpComplete =>
      _otpControllers.every((c) => c.text.isNotEmpty);

  String get enteredOtp =>
      _otpControllers.map((e) => e.text).join();

  // ▶️ START TIMER
  void startResendTimer() {
    _resendSeconds = 60;
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendSeconds == 0) {
        timer.cancel();
        setState(() {});
      } else {
        setState(() {
          _resendSeconds--;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startResendTimer();
  }

  @override
  void dispose() {
    for (final c in _otpControllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const SizedBox(height: 40),

          // 🔙 HEADER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(width: 8),
                Text(
                  "OTP Verification",
                  style: AppTextStyles.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const Divider(),
          const SizedBox(height: 40),

          // 📝 TITLE
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Enter the 6-Digit code",
              style: AppTextStyles.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 5),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "sent to you at +91 ${widget.mobile}",
              style: AppTextStyles.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // 🔢 OTP BOXES
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(otpLength, (index) {
                return SizedBox(
                  width: 45,
                  height: 55,
                  child: TextField(
                    controller: _otpControllers[index],
                    focusNode: _focusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    style: AppTextStyles.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: InputDecoration(
                      counterText: "",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                        const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                        const BorderSide(color: Colors.green, width: 2),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < otpLength - 1) {
                        _focusNodes[index + 1].requestFocus();
                      }
                      if (value.isEmpty && index > 0) {
                        _focusNodes[index - 1].requestFocus();
                      }
                      setState(() {});
                    },
                  ),
                );
              }),
            ),
          ),

          const Spacer(),
          const Divider(),
          const SizedBox(height: 10),

          // 🔁 RESEND OTP BUTTON
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: canResend
                    ? () {
                  startResendTimer();
                  print("Resend OTP");
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  canResend ? Colors.orange : Colors.grey.shade400,
                ),
                child: Text(
                  canResend
                      ? "Resend OTP"
                      : "Resend OTP in $_resendSeconds s",
                  style: AppTextStyles.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // ✅ VERIFY OTP BUTTON
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: isOtpComplete
                    ? () async {
                  print("Entered OTP = $enteredOtp");

                  final otpVM = Provider.of<OTPVerificationViewModel>(
                    context,
                    listen: false,
                  );

                  bool isVerified = await otpVM.VerfiOTP(
                    mobile: widget.mobile,
                    otp: enteredOtp,
                  );

                  if (isVerified) {


                    print("✅ OTP Verified");

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Dashboardview(),
                      ),
                          (route) => false,
                    );


                  } else {
                    print("❌ Invalid OTP");
                  }
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isOtpComplete
                      ? Colors.green
                      : Colors.grey.shade400,
                ),

                child: Text(
                  "Verify OTP",
                  style: AppTextStyles.poppins(
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