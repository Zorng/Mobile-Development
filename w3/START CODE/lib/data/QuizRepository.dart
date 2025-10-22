import 'dart:io';
import 'dart:convert';

import '../domain/quiz.dart';

class QuizRepository {
  final String filePath;

  QuizRepository(this.filePath);

  Quiz readQuiz(String inputId) {
    final file = File(filePath);
    final content = file.readAsStringSync();
    final Map<String, dynamic> data = jsonDecode(content);

    List<dynamic> quizzes = data['quizzes'] as List;

    Map<String, dynamic> quiz = {};
    quizzes.forEach((q) {
      if (q['id'] == inputId) {
        quiz = q;
      }
    });

    if (quiz.isEmpty) throw ArgumentError("Quiz not found");

    List<dynamic> jsonQuestions = quiz['questions'] as List;

    List<dynamic> jsonSubmissions = quiz['submissions'] as List;

    List<dynamic> jsonPlayers = jsonSubmissions.map((s) {
      return s['player'];
    }).toList();

    List<dynamic> jsonPlayerAnswers =
        jsonPlayers.map((p) => p['answers']).toList();

    // List<List<Answer>> temp = [];
    // jsonPlayerAnswers.forEach((pA){
    //   List<Answer> tempA = [];
    //     pA.forEach((a){
    //       tempA.add(Answer(id: a['id'], questionId: a['questionId'], answerChoice: a['answerChoice']));
    //     });
    //     temp.add(tempA);
    // });
    // var answers = temp;

    final answers = jsonPlayerAnswers
        .map<List<Answer>>((pA) => pA
            .map<Answer>((a) => Answer(
                  id: a['id'],
                  questionId: a['questionId'],
                  answerChoice: a['answerChoice'],
                ))
            .toList())
        .toList();

    // List<Player> players = [];
    // for(int i =0; i < jsonPlayers.length; i++) {
    //   players.add(Player(name: jsonPlayers[i]['name'], answers: answers[i]));
    // }

    final players = [
      for (int i = 0; i < jsonPlayers.length; i++)
        Player.loadPlayer(
          name: jsonPlayers[i]['name'],
          answers: answers[i],
        )
    ];

    // final List<Sub> submissions = [
    //   for (int i = 0; i < jsonSubmissions.length; i++) {
    //     Submission(
    //       id: jsonSubmissions[i]['id'],
    //       player: players[i]
    //     )
    //   }
    // ];

    List<Submission> submissions = [];
    for (int i = 0; i < jsonSubmissions.length; i++) {
        submissions.add(Submission(
          id: jsonSubmissions[i]['id'],
          player: players[i]
        ));
    }


    var questions = jsonQuestions.map((q) {
      return Question(
          id: q['id'],
          title: q['title'],
          choices: List<String>.from(q['choices']),
          goodChoice: q['goodChoice'],
          point: q['point']);
    }).toList();

    return Quiz(id: inputId, questions: questions, submissions: submissions);
  
  }

  //Bonus
  void writeQuiz(Quiz quiz, String path){
    final file = File(path);

    final content = file.readAsStringSync();

    final Map<String, dynamic> data = jsonDecode(content);

    List<dynamic> quizzes = data['quizzes'] as List;

    final Map<String, dynamic> newData = quiz.toJson();

    String targetId = quiz.id;

    final index = quizzes.indexWhere((quiz)=> quiz['id'] == targetId);

    if(index == -1) {
      print("failed to update quiz data");
      return;
    }

    quizzes[index] = newData;

    final updated = const JsonEncoder.withIndent(' ').convert(data);
    file.writeAsStringSync(updated, flush: true);
  }
}
