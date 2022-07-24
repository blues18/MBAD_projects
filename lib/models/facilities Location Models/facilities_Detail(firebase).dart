class Facilities_Details { //details for Facilities locations for listviews
  String id;
  String location;
  String block_And_Level;
  String Opening_Hour;
  String Facilities_Type;
  String Url_image;

  Facilities_Details(
      {required this.id, required this.location, required this.block_And_Level, required this.Opening_Hour,
        required this.Facilities_Type,required this.Url_image,});

  Facilities_Details.formMap(Map <String, dynamic> snapshot,String id):
      id = id,
  location = snapshot['Location'] ??'',
  block_And_Level = snapshot['Block and Level'] ?? '',
  Opening_Hour = snapshot['Opening Hour'] ?? '',
  Facilities_Type = snapshot['Facilities_Type'] ?? '',
        Url_image = snapshot['Url_image']??''
;}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


