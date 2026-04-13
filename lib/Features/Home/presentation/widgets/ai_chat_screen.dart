import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final TextEditingController controller = TextEditingController();

  List<Map<String, String>> messages = [];

  final String apiKey = "AIzaSyCFrziwVgtrsRAoH355VbB2sQrmgdM0cak";

  final String instruction = """
أنت مساعد ذكي لتطبيق اسمه 'أجر ووفر'.
رد بلهجة مصرية ودودة جداً وبأسلوب حبايبي وأهلي.
لو السؤال خارج التأجير اعتذر بلطف.
شجع على التوفير والاستدامة.
""";

  // 🔥 Send Message
  Future<void> sendMessage(String prompt) async {
    setState(() {
      messages.add({"role": "user", "content": prompt});
      messages.add({"role": "assistant", "content": "..."}); // loading
    });

    controller.clear();

    try {
      final url =
          "https://generativelanguage.googleapis.com/v1/models/gemini-pro:generateContent?key=$apiKey";

      // تحويل الرسائل
      List contents = messages
          .where((m) => m["content"] != "...")
          .map((msg) {
        return {
          "role": msg["role"] == "user" ? "user" : "model",
          "parts": [
            {"text": msg["content"]}
          ]
        };
      }).toList();

      // إضافة instruction
      contents.insert(0, {
        "role": "user",
        "parts": [
          {"text": instruction}
        ]
      });

      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "contents": contents,
        }),
      );

      final data = jsonDecode(response.body);

      if (kDebugMode) {
        print("Response: ${response.body}");
      }
      print(response.statusCode);
      print(response.body);
      String reply;

      if (data["candidates"] != null &&
          data["candidates"].isNotEmpty &&
          data["candidates"][0]["content"] != null &&
          data["candidates"][0]["content"]["parts"] != null &&
          data["candidates"][0]["content"]["parts"].isNotEmpty) {
        reply =
        data["candidates"][0]["content"]["parts"][0]["text"];
      } else {
        throw Exception("Invalid response: ${response.body}");
      }

      setState(() {
        messages.removeLast(); // remove loading
        messages.add({"role": "assistant", "content": reply});
      });
    } catch (e) {
      String errorMessage;

      if (kDebugMode) {
        errorMessage =
        "❌ Error: ${e.runtimeType}\n${e.toString()}";
      } else {
        errorMessage = "حصلت مشكلة بسيطة 😅 حاول تاني";
      }

      setState(() {
        messages.removeLast(); // remove loading
        messages.add({"role": "assistant", "content": errorMessage});
      });
    }
  }

  // 💬 Message Bubble
  Widget buildMessage(Map<String, String> msg) {
    bool isUser = msg["role"] == "user";

    return Align(
      alignment:
      isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUser ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          msg["content"]!,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  // 🧱 UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🤖 أجر ووفر AI"),
      ),

      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text("أسئلة سريعة")),
            ListTile(
              title: const Text("إزاي أقدر أأجر؟"),
              onTap: () {
                Navigator.pop(context);
                sendMessage("إزاي أقدر أأجر؟");
              },
            ),
            ListTile(
              title: const Text("إيه الضمانات؟"),
              onTap: () {
                Navigator.pop(context);
                sendMessage("إيه الضمانات؟");
              },
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          // الرسائل
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (_, i) =>
                  buildMessage(messages[messages.length - 1 - i]),
            ),
          ),

          // input
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: "اسألني أي حاجة...",
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  if (controller.text.trim().isNotEmpty) {
                    sendMessage(controller.text.trim());
                  }
                },
              )
            ],
          )
        ],
      ),
    );
  }
}