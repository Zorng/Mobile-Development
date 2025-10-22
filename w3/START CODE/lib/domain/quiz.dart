import 'package:uuid/uuid.dart';
var uuid = Uuid();

class Player{
  final String _name;
  List <Answer> answers =[];
  Player(this._name);

  void addAnswer(Answer asnwer) {
     this.answers.add(asnwer);
  }

  int getTotalScore() {
    int correctScore =0;
    for(Answer answer in answers){
      if (answer.isGood()) {
        correctScore += answer.question.point;
      }
    }
    return correctScore;
  }

  double getScoreInPercentage(){
    int totalSCore =0;
    for(Answer answer in answers){
      totalSCore += answer.question.point;
    }
    return ((getTotalScore()/ totalSCore)*100);
  }

  String get name => _name;


  @override
  bool operator ==(Object other) =>
      other is Player &&
      other.name == name;

  @override
  int get hashCode => Object.hash( _name , _name, _name);
}

class Question{
  final String id;
  final String title;
  final List<String> choices;
  final String goodChoice;
  final int point;

  Question({required this.id ,required this.title, required this.choices, required this.goodChoice, this.point = 1});

  @override
  String toString() {
    return
'''
Question: ${this.title} - ( ${this.point} points)
Choices: ${this.choices}''';
  }

//holy nightmare T-T
  String toJson(){
    return 
'''
{
  "id": "$id",
  "title": "$title",
  "choices": ${choices.map((c) => "\"$c\"").toList()},
  "goodChoice": "$goodChoice",
  "point": "$point"
}''';
  }
}

class Answer{
  final String id;
  final Question question;
  final String answerChoice;
  

  Answer({required this.id, required this.question, required this.answerChoice});

  bool isGood(){
    return this.answerChoice == question.goodChoice;
  }
  
}

class Quiz{
  final String id;
  List<Question> questions;
  Set<Player> players = {};

  Quiz({required this.id, required this.questions});

  void addPlayer(String playerName) {
    // if(players.contains(Player(playerName))) {
    //   throw ArgumentError("Duplicated player name not allowed");
    // }


    players.addAll({Player(playerName)});
  
  }

  String toJson(){

    String res = "";
    players.forEach((p){
      if(p != players.last) {
        res += '''

{
  "id": "$id",
  "name": "${p.name}",
  "questions":
  ${questions.map((q) =>"${q.toJson()}").toList()}
,
  "answer":
  
      ${p.answers.map((a) =>"\{\"${a.id}\" :\"${a.answerChoice}\"\}").toList()}
  
},
''';
      }
      else {
        res += '''
{
  "id": "$id",
  "name": "${p.name}",
  "questions":
  ${questions.map((q) =>"${q.toJson()}").toList()}
,
  "answer":
  
      ${p.answers.map((a) =>"\{\"${a.id}\" :\"${a.answerChoice}\"\}").toList()}
  
}
''';
      }
    });
    return "[" + res + "]";


//this works but it is not really efficient. a lot of manual work and no type checking

//the wrote file are list of list of players during each session, instead of list of all players ever played.

//learned: a better way to do this would be to follow the good practice of dart <-> json conversion by using encoding function.

//yikes i spent 3.5 hours on this bonus :/ still not the best result


// '''
// {
//   "id": "$id",
//   "name": "${players.last.name}",
//   "questions":
//   ${questions.map((q) => q == questions.last? "${q.toJson()}": "${q.toJson()}").toList()}
// ,
//   "answer":
  
//       ${players.last.answers.map((a) => players.last.answers.last == a? "\{\"${a.id}\" :\"${a.answerChoice}\"\}" : "\{\"${a.id}\" :\"${a.answerChoice}\"\} ").toList()}
  
// }
// ''';
  }
}

