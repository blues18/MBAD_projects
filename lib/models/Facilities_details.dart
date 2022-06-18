import 'package:cloud_firestore/cloud_firestore.dart';
class facilities_location_and_details{
   String id;
   String location;
   String openingHour;
   String facilitiesType;
   String blockandlevel;
   String notices;

   facilities_location_and_details({
      required this.id, required this.location, required this.openingHour,
      required this.facilitiesType ,required this.blockandlevel, required this.notices});

   //facilities_location_and_details.fromMap(Map<String,dynamic> snapshot, String id):
         // id = id;
          //location = snapshot['Location'] ??'',
          //openingHour = snapshot['Opening Hour']?? '',
          //facilitiesType = snapshot['Facilities Type']?? '',
         // blockandlevel = snapshot['Block and Level']?? '',
         // notices = (snapshot['Notics']?? Timestamp.now() as Timestamp).toDate();

}