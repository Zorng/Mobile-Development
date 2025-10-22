import 'package:uuid/uuid.dart';
var uuid = Uuid();

class Player{
  final String _name;
  List<Answer> answers = [];
  Player.loadPlayer({required name, required this.answers}): _name = name;
  Player.createPlayer({required name}): _name = name;

  void addAnswer(Answer asnwer) {
     this.answers.add(asnwer);
  }


  // int getTotalScore() {
  //   int correctScore =0;
  //   for(Answer answer in answers){
  //     if (answer.isGood()) {
  //       correctScore += answer.question.point;
  //     }
  //   }
  //   return correctScore;
  // }

  // double getScoreInPercentage(){
  //   int totalSCore =0;
  //   for(Answer answer in answers){
  //     totalSCore += answer.question.point;
  //   }
  //   return ((getTotalScore()/ totalSCore)*100);
  // }

  Map<String, dynamic> toJson() => {
    "name": name,
    "answers": answers.map((a) => a.toJson()).toList()
  };


  String get name => _name;

  @override
  String toString() {
    
    return "($_name, $answers)";
  }

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

  Map<String, dynamic> toJson() => {
    "id":id,
    "title": title,
    "choices": choices,
    "goodChoice": "Paris",
    "point": point
  };

}

class Answer{
  final String id;
  final String questionId;
  final String answerChoice;
  

  Answer({required this.id, required this.questionId, required this.answerChoice});

  Map<String, dynamic> toJson() => {
    "id": id,
    "questionId": questionId,
    "answerChoice": answerChoice
  };

  @override
  String toString() {
    return "($id, $questionId, $answerChoice)";
  }
  
}

class Submission {
  final id;
  Player player;
  Submission({required this.id, required this.player});


  Map<String, dynamic> toJson() => {
    "id":id,
    "player":player.toJson()
  };
  
  @override
  String toString() {
    return "$id, $player";
  }
}

class Quiz{
  final String id;
  List<Question> questions;
  List<Submission> submissions;

  Quiz({required this.id, required this.questions, required this.submissions});

  void addSubmission(Player player) {
    for(int i = 0; i < submissions.length; i++) {
      if(submissions[i].player.name == player.name) {
        print("Duplicated xxxxxx");
        //overwrite duplicated submission
        submissions.removeAt(i);
        submissions.insert(i, Submission(id: uuid.v1(), player: player));
        
        return;
      }
    }
    print("not here");
    submissions.add(Submission(id: uuid.v1(), player: player));
  }

  Player addPlayer(String inputName) {
    for(int i = 0; i < submissions.length; i++) {
      if(submissions[i].player.name == inputName) {
        print("Duplicated input name");
        submissions[i].player.answers=[];
        return submissions[i].player;
      }
    }
    print("bad");
    return Player.createPlayer(name:inputName);
  }

  ({double score, double percentageScore}) playerScore(String name) {
    double totalScore = 0;
    double availableScore = 0;
    Submission s = submissions.firstWhere((s) => s.player.name == name);
    
    s.player.answers.forEach((a){
      questions.forEach((q){
          if(q.id == a.questionId){
            availableScore += q.point;
            if(q.goodChoice == a.answerChoice){
              totalScore += q.point;
            } 
          } 
      });
    });
    
    return (score: totalScore,  percentageScore: (totalScore/availableScore) * 100);
  }



  Map<String, dynamic> toJson() => {
    "id":id,
    "questions": questions.map((e) => e.toJson()).toList(),
    "submissions": submissions.map((e) => e.toJson()).toList()
  };
}
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



