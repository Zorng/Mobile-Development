enum Skill { FLUTTER, DART, DATA_SCIENCE, AI_TRAINER, MANAGEMENT, ACCOUNTING }

class Address {
  String street;
  String city;
  String zipCode;

  Address(this.street, this.city, this.zipCode);

  @override
  String toString() {
    return "$street, $city, $zipCode";
  }
}

class Employee {
  final String _name;
  double _baseSalary;
  List<Skill> _skills;
  Address _address;
  int _yearOfExperience;

  Employee(this._name, this._baseSalary, this._skills, this._address, this._yearOfExperience);

  Employee.mobileDeveloper(
    this._name, 
    this._baseSalary,  
    this._address, 
    this._yearOfExperience
  ): _skills = [Skill.FLUTTER, Skill.DART];

  Employee.AI_Specialist(
    this._name, 
    this._baseSalary,  
    this._address, 
    this._yearOfExperience
  ): _skills = [Skill.DATA_SCIENCE, Skill.AI_TRAINER];

   Employee.humanResource(
    this._name, 
    this._baseSalary,  
    this._address, 
    this._yearOfExperience
  ): _skills = [Skill.MANAGEMENT, Skill.ACCOUNTING];

  String get name => _name;
  double get baseSalary => _baseSalary;
  List<Skill> get skills => _skills;
  Address get address => _address;
  int get yearOfExperience => _yearOfExperience;

  double computeSalary() {
    double total = 0;
    total += this._baseSalary;
    total += this._yearOfExperience * 2000;
    this._skills.forEach((skill) {
      switch(skill) {
        case Skill.FLUTTER: total += 5000;
        case Skill.DART: total += 3000;
        case Skill.DATA_SCIENCE: total += 4000;
        case Skill.AI_TRAINER: total += 4000;
        case Skill.MANAGEMENT: total += 2500;
        case Skill.ACCOUNTING: total += 3000;
      }
    });
    return total;
  }

  void printDetails() {
    print(
'''
name: $_name
skils: $_skills
base salary: \$$_baseSalary
salary: \$${computeSalary()}
address: $_address
yeaar of experience: $_yearOfExperience
'''
);
  }
}

void main() {
  var emp1 = Employee.AI_Specialist(
    'Sokea', 
    40000, 
    Address("1500", "Phnom Penh", "AB-100"),
    5
    );
  emp1.printDetails();

  var emp2 = Employee(
    'Ronan',
    45000,
    [Skill.FLUTTER, Skill.DART],
    Address("dartMaster", "une papier", "CR-1000"),
    10
  );
  emp2.printDetails();
  var emp3 = Employee.mobileDeveloper(
    "Jean Lim",
    20000,
    Address("dartRookie", "nom pang", "AA-0001"),
    1
  );
  emp3.printDetails();
}