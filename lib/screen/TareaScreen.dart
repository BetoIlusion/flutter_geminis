import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_geminis/services/ia_geminis.dart';

class TareaScreen extends StatefulWidget {
  const TareaScreen({Key? key}) : super(key: key);

  @override
  State<TareaScreen> createState() => _TareaScreenState();
}

class _TareaScreenState extends State<TareaScreen> {
  final TextEditingController _controller = TextEditingController();
  final ExamQuestionGenerator examQuestionGenerator = ExamQuestionGenerator();
  String generatedContent = '';
  int numberOfQuestions = 1;
  String selectedQuestionType = 'Solo preguntas';
  bool isLoading = false;

  void generateExamForm() async {
    final inputText = _controller.text;

    setState(() {
      isLoading = true;
    });

    final numberOfQuestionsResult = await showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('¿Cuántas preguntas?'),
          content: TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                hintText: 'Ingresa el número de preguntas'),
            onChanged: (value) {
              setState(() {
                numberOfQuestions = int.tryParse(value) ?? 1;
              });
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(numberOfQuestions);
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );

    if (numberOfQuestionsResult != null) {
      setState(() {
        numberOfQuestions = numberOfQuestionsResult;
      });
    }

    final result = await examQuestionGenerator.generateExamQuestions(
      inputText,
      numberOfQuestions,
      selectedQuestionType,
    );

    setState(() {
      isLoading = false;
      generatedContent = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Generador de Preguntas para Examen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Generar un formulario de preguntas para un examen',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Escribe el tema del examen',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.purple),
                ),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedQuestionType,
              onChanged: (String? newValue) {
                setState(() {
                  selectedQuestionType = newValue!;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.purple),
                ),
              ),
              items: <String>[
                'Solo preguntas',
                'Incisos de selección',
                'Completar enunciado'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors
                      .purple, // Cambiado de 'primary' a 'backgroundColor'
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: generateExamForm,
                child: const Text(
                  'Generar Preguntas',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.purple,
                    ),
                  )
                : Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        generatedContent,
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
