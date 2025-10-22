import 'dart:io';
import 'dart:convert';
import '../domain/quiz.dart';

void main() {
  QuizRepository qr = QuizRepository('quiz.json');
  Quiz quiz = qr.readQuiz();

  print(quiz.toJson());
  // quiz.questions.forEach((question){
  //   print(question.toJson());
  // });

  //qr.writeQuiz();
  
}

class QuizRepository{
  final String filePath;

  QuizRepository(this.filePath);

  Quiz readQuiz(){
    final file = File(filePath);
    final content = file.readAsStringSync();
    final Map<String, dynamic>data = jsonDecode(content);

    var questionsJson = data['questions'] as List;
    var questions = questionsJson.map((q){
      return Question(
        id: uuid.v1(),
        title: q['title'],
        choices: List<String>.from(q['choices']),
        goodChoice: q['goodChoice'],
        point: q['point']
      );
    }).toList();

    return Quiz(id: uuid.v1(), questions: questions);
  }

  //Bonus
  void writeQuiz(Quiz quiz, String filePath) {
    final file = File(filePath);
    final content = file.readAsStringSync();
    //if the json is a list of objects, we need to use list to cotain the read data
    var data = jsonDecode(content);

    String quizContent = quiz.toJson().toString();
    
    List<dynamic>?newData;
    try {
      newData = jsonDecode(quizContent);
      data.addAll([newData]);
      file.writeAsString(jsonEncode(data), flush: true);
    } catch (e) {
      print(e);

      print(newData);
      print("=========");
      print(quizContent);
    }
  }

}