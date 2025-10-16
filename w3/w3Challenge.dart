class Question{
  final String _questionText;
  final List<String> _choices;
  final String _goodChoice;

  Question(
    this._questionText,
    this._choices,
    this._goodChoice
  );

  @override
  String toString() {
    return "$_questionText\n $_choices \n $_goodChoice";
  }

  List<String> get choices => _choices;
  String get goodChoice => _goodChoice;
  String get questionText => _questionText;
}

class Answer {
  String _answerChoice;
  Question _question;

  Answer(this._answerChoice, this._question);

  @override
  String toString() {
    return "$_answerChoice";
  }
  
  bool isGoodAnswer()  => _answerChoice == _question.goodChoice;
  String get answerChoice => _answerChoice;
}

class Quiz{
  List<Question> questions;
  List<Answer> answers;

  Quiz(this.questions, this.answers);

  void addAnswer(Answer answer) {
    answers.add(answer);
  }

  int getScore() {
    int total = 0;
    for(var answer in answers) {
      answer.isGoodAnswer()? total += 1 : total+= 0;
    }
    return total;
  }

  void printResult() {
    for(int i = 0; i < questions.length; i++) {
      String res;
      res = answers[i].isGoodAnswer()? "correct" : "wrong";
      print("Q.${i+1} ${questions[i].questionText}");
      questions[i].choices.forEach(print);
      print("your choice: ${answers[i]._answerChoice}");
      print("$res\n");
    }
    print("\n Total Score: ${getScore()}/${questions.length}");
  }
}

void main() {

  Question q1 = Question("Water boils at 100C under normal pressure", ["True", "False"], "True");
  Question q2 = Question("What is the speed of light", ["300,000Km/s", "3,000,000m/s"], "300,000Km/s");
  Question q3 = Question("What is Vladimir Dracula", ["Ghoul", "Mummy", "Vampire", "Golem"], "Vampire");
  Quiz quiz = Quiz(
    [q1, q2, q3],
    [
      Answer("False", q1),
      Answer("300,000Km/s", q2),
      Answer("Golem", q3),
    ]
  );

  quiz.printResult();

}

