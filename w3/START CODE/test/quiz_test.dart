import 'package:test/test.dart';
import '../lib/domain/quiz.dart';
import '../lib/data/QuizRepository.dart';

//run from root directory of repo 
// dart test w3/START\ CODE/test/quiz_test.dart

void main() {
  QuizRepository qr = QuizRepository("w3/START CODE/lib/data/quiz.json");
  Quiz q1 = qr.readQuiz();

  test("test 1: ", (){
    q1.addPlayer("bro");
    q1.players.last.addAnswer(Answer(id: uuid.v1(), question: q1.questions[0], answerChoice: "Paris"));
    q1.players.last.addAnswer(Answer(id: uuid.v1(), question: q1.questions[1], answerChoice: "4"));

    expect(q1.players.last.getTotalScore(), 70);
    expect(q1.players.last.getScoreInPercentage().toStringAsFixed(2), (70/70 * 100).toStringAsFixed(2));

  }); 


  test("test 2: ", (){
    q1.addPlayer("Aahhaha");
    q1.players.last.addAnswer(Answer(id: uuid.v1(), question: q1.questions[0], answerChoice: "Rome"));
    q1.players.last.addAnswer(Answer(id: uuid.v1(), question: q1.questions[1], answerChoice: "4"));

    expect(q1.players.last.getTotalScore(), 60);
    expect(q1.players.last.getScoreInPercentage().toStringAsFixed(2), (60/70 * 100).toStringAsFixed(2));

  }); 

  test("test 3: same player 'Aahhaha', multiple attempts. Last attempts override",(){
    q1.addPlayer("Dragona");
    
    q1.players.firstWhere((p) => p.name == "Dragona").addAnswer(Answer(id: uuid.v1(), question: q1.questions[0], answerChoice: "Rome"));
    q1.players.firstWhere((p) => p.name == "Dragona").addAnswer(Answer(id: uuid.v1(), question: q1.questions[1], answerChoice: "2"));
    
    q1.addPlayer("Aahhaha");
    q1.players.firstWhere((p) => p.name == "Aahhaha").answers = [];
    q1.players.firstWhere((p) => p.name == "Aahhaha").addAnswer(Answer(id: uuid.v1(), question: q1.questions[0], answerChoice: "Paris"));
    q1.players.firstWhere((p) => p.name == "Aahhaha").addAnswer(Answer(id: uuid.v1(), question: q1.questions[1], answerChoice: "4"));

    expect(q1.players.firstWhere((p) => p.name == "Aahhaha").getTotalScore(), 70);
    expect(q1.players.firstWhere((p) => p.name == "Aahhaha").getScoreInPercentage().toStringAsFixed(2), (70/70 * 100).toStringAsFixed(2));
  });



}