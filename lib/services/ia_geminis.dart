import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';


class ExamQuestionGenerator {
  final Gemini gemini = Gemini.instance;

  Future<String> generateExamQuestions(String topic, int numberOfQuestions, String questionType) async {
    String examPrompt = "Genera $numberOfQuestions preguntas para un examen sobre el tema: $topic. "
        "Las preguntas deben ser de tipo: $questionType. No incluyas las respuestas, solo numeralas, "
        "no pongas títulos, ni contexto inicial, simplemente preguntas numeradas, solo al final del texto coloca las respuestas y numeradas";

    try {
      final response = await gemini.text(examPrompt);
      return response?.output ?? 'No se pudo generar contenido';
    } catch (e) {
      return 'Error al generar preguntas: $e';
    }
  }
}