class Post {
  String userID;
  String firstname;
  String lastname;
  String content;
  String date;
  String img_url;

  Post(this.userID, this.firstname, this.lastname, this.content, this.date, this.img_url);

  Post.fromJson(Map<String, dynamic> json)
    : userID = json['userID'],
      firstname = json['firstname'],
      lastname = json['lastname'],
      content = json['content'],
      date = json['date'],
      img_url = json['img_url'];

  Map<String, dynamic> toJson() => {
    'userID' : userID,
    'firstname' : firstname,
    'lastname' : lastname,
    'content' : content,
    'date' : date,
    'img_url' : img_url,
  };
}