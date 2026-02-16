import 'package:flutter/material.dart';

class ApprovalPage extends StatelessWidget {
  final String visitorId;

  const ApprovalPage({
    Key? key,
    required this.visitorId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // 🔝 VISITOR IMAGE
            Container(
              height: 280,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1529156069898-49953e39b3ac',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 🧾 VISITOR DETAILS
            const Text(
              "Visitor at Gate",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Purpose: Delivery",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),

            const SizedBox(height: 4),

            const Text(
              "Flat: A-101",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),

            const Spacer(),

            // ✅ APPROVE BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  await approveVisitor(visitorId);
                  Navigator.pop(context);
                },
                child: const Text(
                  "APPROVE",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ❌ REJECT BUTTON
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  await rejectVisitor(visitorId);
                  Navigator.pop(context);
                },
                child: const Text(
                  "REJECT",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // 🔥 API CALL – APPROVE
  Future<void> approveVisitor(String visitorId) async {
    print("Visitor APPROVED: $visitorId");
    // TODO: call your API
  }

  // 🔥 API CALL – REJECT
  Future<void> rejectVisitor(String visitorId) async {
    print("Visitor REJECTED: $visitorId");
    // TODO: call your API
  }
}
