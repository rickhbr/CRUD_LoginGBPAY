class TicketQuery {
  String? assignor;
  Null? registerData;
  String? settleDate;
  Null? dueDate;
  String? endHour;
  String? initeHour;
  String? nextSettle;
  String? digitable;
  int? transactionId;
  int? type;
  double? value;
  Null? maxValue;
  Null? minValue;
  String? errorCode;
  Null? message;
  int? status;

  TicketQuery({
    this.assignor,
    this.registerData,
    this.settleDate,
    this.dueDate,
    this.endHour,
    this.initeHour,
    this.nextSettle,
    this.digitable,
    this.transactionId,
    this.type,
    this.value,
    this.maxValue,
    this.minValue,
    this.errorCode,
    this.message,
    this.status,
  });

  factory TicketQuery.fromJson(Map<String, dynamic> json) {
    return TicketQuery(
      assignor: json['assignor'],
      registerData: json['registerData'],
      settleDate: json['settleDate'],
      dueDate: json['dueDate'],
      endHour: json['endHour'],
      initeHour: json['initeHour'],
      nextSettle: json['nextSettle'],
      digitable: json['digitable'],
      transactionId: json['transactionId'],
      type: json['type'],
      value: json['value'],
      maxValue: json['maxValue'],
      minValue: json['minValue'],
      errorCode: json['errorCode'],
      message: json['message'],
      status: json['status'],
    );
  }
}
