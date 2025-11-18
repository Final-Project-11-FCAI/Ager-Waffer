import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/block/modes/cbc.dart';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/padded_block_cipher/padded_block_cipher_impl.dart';

String decrypt(String ciphertext){
  final iv = Uint8List(16);
  final key = utf8.encode("ABCDEFGHIJ0123456789asdfghjklzaa");
  List<int> list = key;
  Uint8List bytes = Uint8List.fromList(list);

  final cipher = PaddedBlockCipherImpl(
    PKCS7Padding(),
    CBCBlockCipher(AESEngine()),
  )..init(
    false, // decrypt
    PaddedBlockCipherParameters(
      ParametersWithIV(KeyParameter(bytes), iv),
      null,
    ),
  );

  // a single call to process converts the ciphertext to plaintext (and removes the padding)
  final pt = cipher.process(base64.decode(ciphertext));
  var result = utf8.decode(pt);
  return result.toString();
}

void main() {
  String encryptedText = 'h5yPpCC+TfrQx4icGtxhlml+wvL3yWpSB5Yuia2/n7iqLjMXrgh8KZrwTgHYzs33R8a6YPsW1XcI8J5nD/CTPt0GeqQacOS35QumqyWK2rgJlDSv2OKBNBA1DIGYPvNnhaSzU6ZdO0wI2REM3Fdz33c8o9g5mJwLG3hN1oJkb7N8h88gsDTRVKROKHWOvWADmPs69uMQXDwEZQ4HbPXPurYLFsdIgkwiF1ZfNfop2j7IbJfN0P7c0bu9gvIB4q6NKHr6+5kvAPbra1oCqsDAlTk8AiOmu3eBRLRNdcYIDMAxCieuRzH4o//4gc9rQxBF4wRNvEpBV+RzIE62seaMN1ovDPHMwmzYFmPq4ipQktTeHoyroALuk3KCSW5tst08ImvGYtqVKn24PxzgwMtZ6QmxYi/WUhbVwHyPJUsUN4jhwphhxvsferZpdGnr17FXnrrugbOSX7JXZHjP+APcqkpDgWB0T8M1ATFj2thJwwfipqb7eM3j4OmDY6eY1wDTkY3/TJssMbHATe/Sw3m5iA3kOdZiegYSlV0JTiCebCleir4pYPnKVt8ZG41XOozbyFLA4LMXEZPRMwGZiAY6iiwXwSHmZoFn0/PFwtJOkwK4NRvrqT24CM70UWaTlgGlj5AbNlYPDJ37Z4QYCAWJQExBg3w9exiY6BqkQ9qX8lacLeMa5GeVN0GuH6ovJPoA6LiRYPCvUGWWKiRfP0DsFX9AseGRbvT3Bbu9Lr9B/nqQZtUOmcmhkrjfhLGRv/51wM57cX/FxYoXLR3/FU/HpotgE/amc3Ud1A2gYncmtuiqBzuQuMZzeDGE9M2Vyxm0qjViZB6Cs7PZBpeZq+W95qSaHMBS1bBpd7X2qe6bgTXvU/cPZXOzhHuAZEgiyfFHD8ClIwhPN/yzG7NHThLt8PCX2XGzQ0fSjPw/MnGcxRWDv/7JterXDBJq7a2JIlTdt343TdiilrwjB+zJ8h37PpaUaw/X1vPfAdH4h5nriFdKpY2qWXxfaQeaZ2Q5izimanywHu3s75VtlLUkJUUmUiGOga5Ny8kN3Fz54Tf0DEXugVLXQP3H5EEbLBGKe68rLznijbYGCkQcYEjedmfA6XVRMOst5JzJ2HixTnawDxK98l3tqWEciCEwbqIFZ9Ptc+S9CeF28TbolJXMbhZjVOexW6GLl5kNN1tv7A8/K+gC1izj4ZXb4wcrxjGMYYnS1nmmDpLXixKYwIeUIMSvCwEye+mKfdWyjYgb5dg59gOupnDlVuXk6pooLwQ/DFuEf650+bv+RityDbt4ZZHvopV9F/639V8PdsK7DAX80qY3oVHNaZPd5oQg70eYEqaL1T0z/8sV6ORb7CJtjN7NKDrahtPzV2imSL/J7O7gxRdm4d3/6+YrJkndTcf/IW6AMvdiKjv5tRtNSyGTzOye4zHuamjMTQiNRJnSmJJWP7aNuy4RCEzgJZxIed++610C'; // Your encrypted text here
  String decryptedText = decrypt(encryptedText);
}