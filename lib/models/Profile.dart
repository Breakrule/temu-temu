class User {
  String username;
  String email;
  String password;
  
  
  User({
   
    this.email,
    this.password
  });
  factory User.fromJson(Map<String, dynamic> json){
      return User(
       
        email: json['email'],
        password: json['password']
      ); 
  }
  Map toMap(){
    var map = new Map<String, dynamic>();
    map["email"] = email;
    map["password"] = password;

    return map;
  }
}
