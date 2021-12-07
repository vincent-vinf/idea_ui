class Comment {
  int id;
  int ideaId;
  int userId;
  int toId;
  String content;

  Comment(this.id, this.ideaId, this.userId, this.toId, this.content);
}

Comment json2Comment(dynamic data){
  return Comment(data["ID"],data["ideaId"],data["userId"],data["toId"],data["content"]);
}