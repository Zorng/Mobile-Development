class BankAccount {
    // TODO
    final _name;
    double _balance;

    BankAccount(
      {double balance = 0, required String name}
    ): this._balance = balance, this._name = name, assert(balance >= 0, "Negative Balance not allowed");

    double get balance => _balance;

    void withdraw(double amount) {
      if (amount <= 0) {
        throw Exception("Negative withdrawal not allowed");
      } else {
        _balance -= amount;
      }
    }

    void credit(amount) {
      if (amount <= 0) {
        throw Exception("Negative credit not allowed");
      } else {
        _balance += amount;
      }
    }

}

class Bank {
    // TODO
    String _name;
    Map<int, BankAccount> _registeredAccount = {};


    Bank({required String name}) : this._name = name;

    BankAccount createAccount(int id, String accountName) {
        if (_registeredAccount.containsKey(id)) {
          throw Exception("Id is taken. Cannot create account");
        }
        BankAccount temp = BankAccount(name: accountName);
        _registeredAccount.addAll({id : temp});
        return temp;
    }
}

void main() {

  Bank myBank = Bank(name: "CADT Bank");
  BankAccount ronanAccount = myBank.createAccount(100, 'Ronan');

  print(ronanAccount.balance); // Balance: $0
  ronanAccount.credit(100);
  print(ronanAccount.balance); // Balance: $100
  ronanAccount.withdraw(50);
  print(ronanAccount.balance); // Balance: $50

  try {
    ronanAccount.withdraw(75); // This will throw an exception
  } catch (e) {
    print(e); // Output: Insufficient balance for withdrawal!
  }

  try {
    myBank.createAccount(100, 'Honlgy'); // This will throw an exception
  } catch (e) {
    print(e); // Output: Account with ID 100 already exists!
  }
}