import 'dart:io';
import '../domain/quiz.dart';

class QuizConsole {
  Quiz quiz;
  

  QuizConsole({required this.quiz});

  void startQuiz() {
    print('--- Welcome to the Quiz ---\n');
    do {
      String? inputName;
      stdout.write("Your name: ");
      inputName = stdin.readLineSync();
      if(inputName == null || inputName.isEmpty) {
        print("--- Quiz Finished ---");
        return;
      }
      quiz.addPlayer(inputName);

      for (var question in quiz.questions) {
      print('Question: ${question.title} - ( ${question.point} points)');
      print('Choices: ${question.choices}');
      stdout.write('Your answer: ');
      String? userInput = stdin.readLineSync();

      // Check for null input
      if (userInput != null && userInput.isNotEmpty) {
        Answer answer = Answer(id: uuid.v1() ,question: question, answerChoice: userInput);
        quiz.players.firstWhere((p) => p.name == inputName).answers = [];
        quiz.players.firstWhere((p) => p.name == inputName).addAnswer(answer);
      } else {
        print('No answer entered. Skipping question.');
      }

      print('');
    }

    double scoreInPercentage = quiz.players.firstWhere((p) => p.name == inputName).getScoreInPercentage();

    print('${inputName}, your score in percentage: ${scoreInPercentage.toStringAsFixed(2)} %');
    print('${inputName}, your score in point is: ${quiz.players.firstWhere((p) => p.name == inputName).getTotalScore()}');
    quiz.players.forEach((player){
      print("Player: ${player.name}       Score: ${player.getTotalScore()}");
    });
    } while (true);

     
  }
}
 