import 'package:test/test.dart';
import '../lib/domain/quiz.dart';
import '../lib/data/QuizRepository.dart';

//run from root directory of repo 
// dart test w3/START\ CODE/test/quiz_test.dart

void main() {
  QuizRepository qr = QuizRepository("w3/START CODE/lib/data/Quiz.json");
  Quiz q1 = qr.readQuiz("2072f172-af03-11f0-8de9-0242ac120002");

  test("test 1: test existing player data", (){
  
    expect(q1.playerScore("Zorng"), (score: 70, percentageScore: (70/70)*100));
  }); 


  test("test 2: test existing player data", (){
    expect(q1.playerScore("Loki"), (score: 60, percentageScore: (60/70)*100));

  }); 

  test("test 3: same player 'Loki', multiple attempts. Last attempts override",(){
    Player p = q1.addPlayer("Loki");
    p.addAnswer(Answer(id: uuid.v1(), questionId: "1", answerChoice: "Paris"));
    p.addAnswer(Answer(id: uuid.v1(), questionId: "2", answerChoice: "Bad at Math"));

    expect(q1.playerScore("Loki"), (score: 10, percentageScore: (10/70)*100));
  });



}