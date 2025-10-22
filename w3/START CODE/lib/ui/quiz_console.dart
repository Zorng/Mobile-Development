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
      Player p = quiz.addPlayer(inputName);

      for (var question in quiz.questions) {
      print('Question: ${question.title} - ( ${question.point} points)');
      print('Choices: ${question.choices}');
      stdout.write('Your answer: ');
      String? userInput = stdin.readLineSync();

      // Check for null input
      if (userInput != null && userInput.isNotEmpty) {
        Answer answer = Answer(id: uuid.v1() ,questionId: question.id, answerChoice: userInput);
        p.addAnswer(answer);
      } else {
        print('No answer entered. Skipping question.');
      }

      print('');
    }

    quiz.addSubmission(p);

    ({double score, double percentageScore}) playerResult = quiz.playerScore(inputName);

    print('${inputName}, your score in percentage: ${playerResult.percentageScore.toStringAsFixed(2)}');
    print('${inputName}, your score in point is: ${playerResult.score}');
    print("=======");
    quiz.submissions.forEach((s){
      ({double score, double percentageScore}) playerResult = quiz.playerScore(s.player.name);
      print("PLAYER: ${s.player.name}       Score: ${playerResult.score}");
    });
    print("=======");

    } while (true);

     
  }
}
 