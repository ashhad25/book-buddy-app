class UserModel {
  bool? isLogin;
  String? email;
  String? username;
  String? password;

  UserModel({this.isLogin, this.email, this.username, this.password});

  UserModel.fromJson(Map<String, dynamic> json) {
    isLogin = json['isLogin'];
    email = json['email'];
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isLogin'] = this.isLogin;
    data['email'] = this.email;
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }
}
