class Comment {
  int id;
  int ideaId;
  int userId;
  int toId;
  int commentId;
  String content;
  DateTime createdAt;
  List<Comment>? reply;

  Comment(this.id, this.ideaId, this.userId, this.toId, this.commentId,
      this.content, this.createdAt);
}

Comment json2Comment(dynamic data) {
  return Comment(data["ID"], data["ideaId"], data["userId"], data["toId"],
      data["commentId"], data["content"], DateTime.parse(data["CreatedAt"]));
}
