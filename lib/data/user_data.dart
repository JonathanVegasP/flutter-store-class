class UserData {
  String name;
  String email;
  String id;

  UserData({this.name, this.email, this.id});

  UserData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    id = json['id'];
    assert(name != null && email != null && id != null,toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['id'] = this.id;
    return data;
  }

  @override
  String toString() {
    return 'UserData{name: $name, email: $email, id: $id}';
  }
}