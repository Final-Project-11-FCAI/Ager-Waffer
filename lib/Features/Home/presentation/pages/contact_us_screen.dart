import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Us"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📞 Phone
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.green),
              title: const Text("Call us"),
              subtitle: const Text("+20 100 000 0000"),
              onTap: () {},
            ),

            const Divider(),

            // 📧 Email
            ListTile(
              leading: const Icon(Icons.email, color: Colors.blue),
              title: const Text("Email"),
              subtitle: const Text("support@app.com"),
              onTap: () {},
            ),

            const SizedBox(height: 20),

            const Text(
              "Send Message",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // 💬 Message
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Write your message...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const Spacer(),

            // 🔘 Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text("Send"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
//
// import 'package:flutter/material.dart';
//
// class ContactUsScreen extends StatelessWidget {
//   const ContactUsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Contact Us"),
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 "We’re here to help 👋",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8),
//               const Text(
//                 "Feel free to contact us anytime",
//                 style: TextStyle(color: Colors.grey),
//               ),
//
//               const SizedBox(height: 20),
//
//               // 🔹 Contact options
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   _buildContactCard(Icons.phone, "Call", Colors.green),
//                   _buildContactCard(Icons.email, "Email", Colors.blue),
//                   _buildContactCard(Icons.chat, "Chat", Colors.orange),
//                 ],
//               ),
//
//               const SizedBox(height: 25),
//
//               const Text(
//                 "Send us a message",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//               ),
//
//               const SizedBox(height: 10),
//
//               // 🔹 Name
//               TextField(
//                 decoration: InputDecoration(
//                   hintText: "Your name",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 10),
//
//               // 🔹 Email
//               TextField(
//                 decoration: InputDecoration(
//                   hintText: "Your email",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 10),
//
//               // 🔹 Message
//               TextField(
//                 maxLines: 5,
//                 decoration: InputDecoration(
//                   hintText: "Write your message...",
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
//               // 🔥 Send Button
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: const Text("Send Message"),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildContactCard(IconData icon, String title, Color color) {
//     return Expanded(
//       child: Container(
//         margin: const EdgeInsets.symmetric(horizontal: 5),
//         padding: const EdgeInsets.symmetric(vertical: 16),
//         decoration: BoxDecoration(
//           color: color.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Column(
//           children: [
//             Icon(icon, color: color),
//             const SizedBox(height: 5),
//             Text(title),
//           ],
//         ),
//       ),
//     );
//   }
// }