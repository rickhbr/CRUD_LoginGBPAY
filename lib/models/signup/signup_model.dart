class SignupModel {
  String? nome;
  String? email;
  String? senha;
  String? endereco;
  String? cpf;

  SignupModel({
    required this.nome,
    required this.email,
    required this.senha,
    required this.endereco,
    required this.cpf,
  });

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(
        nome: json['nome'],
        email: json['email'],
        senha: json['senha'],
        endereco: json['endereco'],
        cpf: json['cpf']);
  }
}
