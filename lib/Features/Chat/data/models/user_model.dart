class ChatUser{
  String? id;
  String? name;
  String? email;
  String? about;
  String? image;
  String? createdAt;
  String? lastActivated;
  String? pushToken;
  bool? online;
  List? myUsers;

  ChatUser({
    required this.id,
    required this.name,
    required this.email,
    required this.about,
    required this.image,
    required this.createdAt,
    required this.lastActivated,
    required this.pushToken,
    required this.online,
    required this.myUsers,
});

factory ChatUser.fromJson(Map<String , dynamic> json){
  return ChatUser(
      id: json['id'] ?? "",
      name: json['name']?.toString(),
      email: json['email']?.toString(),
      about: json['about']?.toString(),
      image: json['image']?.toString(),
      createdAt: json['created_at']?.toString(),
      lastActivated: json['last_activated']?.toString(),
      pushToken: json['push_token']?.toString(),
      online: json['online'],
      myUsers: json['my_users']
  );
}

Map<String , dynamic> toJson(){
  return {
    'id' : id,
    'name' : name,
    'email' : email,
    'about' : about,
    'image' : image,
    'created_at' : createdAt,
    'last_activated' : lastActivated,
    'push_token' : pushToken,
    'online' : online,
    'my_users' : myUsers
  };
}

}