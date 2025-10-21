import 'data/QuizRepository.dart'; 
import 'domain/quiz.dart';
import 'ui/quiz_console.dart';

void main() {
  // must be run from the root directory of the repo
  // dart run w3/START\ CODE/lib/main.dart

  QuizRepository qr = QuizRepository('w3/START CODE/lib/data/quiz.json');
  Quiz quiz = qr.readQuiz();

  QuizConsole console = QuizConsole(quiz: quiz);
  console.startQuiz();

  qr.writeQuiz(quiz, 'w3/START CODE/lib/data/quizAttempts.json');


  // List<Question> questions = [
  //   Question(
  //       title: "Capital of France?",
  //       choices: ["Paris", "London", "Rome"],
  //       goodChoice: "Paris",
  //       point: 10
  //       ),
  //   Question(
  //       title: "2 + 2 = ?", 
  //       choices: ["2", "4", "5"], 
  //       goodChoice: "4",
  //       point: 60
  //       ),
  // ];

  // Quiz quiz = Quiz(questions: questions);
  // QuizConsole console = QuizConsole(quiz: quiz);

  // console.startQuiz();
}
