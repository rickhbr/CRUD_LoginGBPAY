class PaymentCardModel{
  String? paymentId;
  String? status;
  String? nsu;
  String? returnCode;
  String? authorizationCode;
  String? orderNumber;
  int? retryAfter;
  int? createAt;
  int? amount;
  String? description;
  String? id;
  String? document;

  PaymentCardModel({
    this.paymentId,
    this.status,
    this.nsu,
    this.returnCode,
    this.authorizationCode,
    this.orderNumber,
    this.retryAfter,
    this.createAt,
    this.amount,
    this.description,
    this.id,
    this.document,
  });

  factory PaymentCardModel.fromJson(Map<String,dynamic> json){
    return PaymentCardModel(
      paymentId: json['paymentId'],
      status: json['status'],
      nsu: json['nsu'],
      returnCode: json['returnCode'],
      authorizationCode: json['authorizationCode'],
      orderNumber: json['orderNumber'],
      retryAfter: json['retryAfter'],
      createAt: json['createAt'],
      amount: json['amount'],
      description: json['description'],
      id: json['id'],
      document: json['document']
    );
  }
}