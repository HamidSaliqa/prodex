class Customer{
  int? id;
  String firstName;
  String lastName;
  String phone;

  Customer({this.id,required this.firstName,required this.lastName,required this.phone});


  // تبدیل به Map برای INSERT/UPDATE
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'firstName': firstName,
      'lastName' : lastName,
      'phone'    : phone,
    };
    if (id != null) map['id'] = id;
    return map;
  }

  factory Customer.fromMap(Map<String,dynamic> m){
  return Customer(
       id: m["id"] ,
      firstName: m["firsName"],
      lastName: m["lastName"],
      phone: m["phone"]);
  }

}

