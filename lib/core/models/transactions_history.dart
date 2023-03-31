class TransactionsHistory {
  List? periods;
  Transactions? transactions;

  TransactionsHistory({this.periods, this.transactions});

  TransactionsHistory.fromJson(Map<String, dynamic> json) {
    if (json['periods'] != null) {
      periods = <String?>[];
      json['periods'].forEach((v) {
        periods!.add(v);
      });
    }
    transactions = json['transactions'] != null
        ? new Transactions.fromJson(json['transactions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.periods != null) {
      data['periods'] = this.periods!.map((v) => v.toJson()).toList();
    }
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.toJson();
    }
    return data;
  }
}

class Transactions {
  int? count;
  List? rows;

  Transactions({this.count, this.rows});

  Transactions.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = [];
      json['rows'].forEach((v) {
        rows!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.rows != null) {
      data['rows'] = this.rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
