import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:exponential_back_off/exponential_back_off.dart';

const openAIApiKey = "YOUR_OPENAI_API_KEY_HERE";

class ResponseError {
  ResponseError(this.response, this.errorMessage);
  http.Response? response;
  String? errorMessage;
}

class CountTokens {
  CountTokens();
  int totalTokens = 0;
  int promptTokens = 0;
  int completionTokens = 0;
}

class ExceptionMsg implements Exception {
  const ExceptionMsg(this.message) : super();
  final String message;
  @override
  String toString() => message;
}

Future<String> gptConnect(
  List<Map<String, String>> messages,
  CountTokens countTokens, {
  String addr = 'https://api.openai.com',
  String endPoint = 'v1/chat/completions',
  double temperature = 0.8,
  bool jsonMode = true,
  String model = 'gpt-4o-2024-08-06',
}) async {
  //const url = 'https://api.openai.com/v1/chat/completions';
  final url = '$addr/$endPoint';

  var client = http.Client();
  try {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $openAIApiKey',
      'Accept-Charset': 'UTF-8',
    };

    // Set up the request body
    //       'model': 'gpt-3.5-turbo',

    final data = {
      // 'model': 'gpt-3.5-turbo-1106',
      // 'model': 'gpt-3.5-turbo',
      'model': model,
      'messages': messages,
      'temperature': temperature,
      if (jsonMode) 'response_format': {"type": "json_object"},
      'n': 1,
    };

    int attempts = 0;
    final exponentialBackOff = ExponentialBackOff(
      interval: const Duration(seconds: 1),
      maxAttempts: 20,
      maxElapsedTime: const Duration(hours: 3),
      maxDelay: const Duration(hours: 3),
    );
    final result = await exponentialBackOff.start<http.Response>(() {
      ++attempts;
      if (attempts > 10) {
        print('Attempt $attempts in gptConnect');
      }
      return client.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      );
    });
    if (result.isLeft()) {
      var ss = result.getLeftValue();
      throw ExceptionMsg(
        'Error in chatGPT connection after $attempts: ${ss.toString()}',
      );
    } else {
      http.Response response = result.getRightValue();
      if (response.statusCode == 200) {
        var bodyBytes = response.bodyBytes;
        var bodyString = utf8.decode(bodyBytes);
        final jsonResponse = jsonDecode(bodyString);
        final answer = jsonResponse['choices'][0]['message']['content'];
        var usage = jsonResponse['usage'];
        if (usage != null) {
          var promptTokens = usage['prompt_tokens'];
          var completionTokens = usage['completion_tokens'];
          var tokens = usage['total_tokens'];
          if (tokens != null) {
            countTokens.totalTokens += tokens as int;
          }
          if (promptTokens != null) {
            countTokens.promptTokens += promptTokens as int;
          }
          if (completionTokens != null) {
            countTokens.completionTokens += completionTokens as int;
          }
        }
        //print('Answer: $jsonResponse');

        if (answer is! String) {
          throw const ExceptionMsg('Answer is not a string');
        } else {
          return answer;
        }
      } else {
        throw ExceptionMsg(
          'Error in chatGPT connection. Status code: ${response.statusCode}',
        );
      }
    }
  } finally {
    client.close();
  }
}
