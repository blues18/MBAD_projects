class userModel {
  String userName;
  String mobilePhone;

  userModel({required this.userName, required this.mobilePhone});

  userModel.fromMap(Map<String, dynamic>? snapshot):
      userName = snapshot!['UserName']??'',
      mobilePhone = snapshot['UserPhoneNumber']??''
;}