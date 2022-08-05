class Facilities_Details_Meeting_Room{
  String id;
  String Location;
  String Block_And_Level;
  String Room_Number;
  String Opening_Hour;
  String Facilities_Type;
  String Facilities_Notice;
  String Room_Size;
  String Url_image;
  int pax_size;
  bool smart_tv;
  bool whiteboard;
  bool wifi;
  bool digitalAvSolution;
  bool officeSupplies;
  bool accessToRefreshment;


  Facilities_Details_Meeting_Room(
      {required this.id, required this.Location, required this.Block_And_Level, required this.Room_Number
        ,required this.Opening_Hour, required this.Facilities_Type, required this.Facilities_Notice,
        required this.Room_Size,required this.Url_image, required this.pax_size, required this.smart_tv, required this.whiteboard
        ,required this.wifi, required this.digitalAvSolution,required this.officeSupplies
        ,required this.accessToRefreshment});

  Facilities_Details_Meeting_Room.fromMap(Map <String, dynamic> snapshot,String id):
        id = id,
        Location = snapshot['Location'] ?? '',
        Block_And_Level = snapshot['Block_and_Level']??'',
        Room_Number = snapshot['Room_Number']??'',
        Opening_Hour = snapshot['Opening_hour']??'',
        Facilities_Type = snapshot['Facilities_Type']??'',
        Facilities_Notice = snapshot['Facilities_Notice']??'',
        Room_Size = snapshot['Room_size']??'',
        Url_image = snapshot['Url_image']??'',
        pax_size = snapshot['Pax_size']??'',
        smart_tv = snapshot['Smart_tv']??'',
        whiteboard = snapshot['Whiteboard']??'',
        wifi = snapshot['Wifi']??'',
        digitalAvSolution = snapshot['DigitalAvSolution']??'',
        officeSupplies = snapshot['officeSupplies']??'',
        accessToRefreshment = snapshot['AccessToRefreshment']??''
  ;}