class Post {
  String userID;
  String firstname;
  String lastname;
  String content;
  String date;

  Post(this.userID, this.firstname, this.lastname, this.content, this.date);

  Post.fromJson(Map<String, dynamic> json)
    : userID = json['userID'],
      firstname = json['firstname'],
      lastname = json['lastname'],
      content = json['content'],
      date = json['date'];

  Map<String, dynamic> toJson() => {
    'userID' : userID,
    'firstname' : firstname,
    'lastname' : lastname,
    'content' : content,
    'date' : date,
  };
}