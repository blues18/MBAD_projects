
class userModel {
  String userName;
  String mobilePhone;
  String imageUrl;

  userModel({required this.userName, required this.mobilePhone, required this.imageUrl});

  userModel.fromMap(Map<String, dynamic>? snapshot):
      userName = snapshot!['UserName']??'',
      mobilePhone = snapshot['UserPhoneNumber']??'',
      imageUrl = snapshot['Url_Image']??''
;}

class image_related{
  String imageUrl;

  image_related({required this.imageUrl});

  image_related.fromMap(Map<String, dynamic>? snapshot):
        imageUrl = snapshot!['Url_Image']??''
;}