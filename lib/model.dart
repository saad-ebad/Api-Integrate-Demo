class DataModel
{
   int? userId;
   int? id;
   String? tilte;
   String? body;


  DataModel({
    this.userId,
    this.id,
    this.tilte,
    this.body
});


   DataModel.fromJson(Map<String, dynamic>  json){


    userId = json['userId'];
    id= json['id'];
    tilte = json['title'];
    body = json['body'];
  }


  Map<String, dynamic> toJson()
  {
    Map<String, dynamic> data = new Map<String , dynamic>();

    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.tilte;
    data['body'] = this.body;

    return data;
  }
}