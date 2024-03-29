
class favourite_Location{
  String id;
  String favourite_location;
  String favourite_bkandlevel;
  String favourite_opening_hours;
  String favourite_facilities_type;
  String favourite_facilities_image;
  String email; //for Diffrenet user


  favourite_Location({
    required this.id, required this.favourite_location, required this.favourite_bkandlevel,
    required this.favourite_opening_hours, required this.favourite_facilities_type,required this.favourite_facilities_image,
    required this.email});

  favourite_Location.fromMap(Map <String, dynamic> snapshot, String id):
      id = id,
      favourite_location= snapshot['Location'] ?? '',
      favourite_bkandlevel = snapshot['Block and Level'] ?? '',
      favourite_opening_hours = snapshot['Opening_hour']?? '',
        favourite_facilities_type = snapshot['Facilities_Type']??'',
      favourite_facilities_image = snapshot['Facilities_image']??'',
      email = snapshot['Email']??''
;}