
class Contact {

  final int? id;
  final String name;
  final String phone;
  final String email;
  final String address;
  final bool isFavourite;


  Contact ({
    this.id,
    required this.name,
    required this.phone,
    this.email="",
    this.address='',
    this.isFavourite=false,
  });


  factory Contact.fromMap(Map<String,dynamic> map){
    return Contact(
      id: map['id'] as int?,
      name: map['name'] as String? ?? '',
      phone: map['phone'] as String? ?? '',
      email: map['email']as String? ?? '',
      address: map['address']as String? ?? '',
      isFavourite: (map['isFavorite']as int?) ==1,
    );
  }

    Map<String, dynamic> toMap() {
      return {
        'id': id,
        'name': name,
        'phone': phone,
        'email': email,
        'address': address,
        'isFavourite': isFavourite ? 1 : 0,
      };
    }


      Contact copyWith({
        int? id,
        String? name,
        String? phone,
        String? email,
        String? address,
        bool? isFavourite,
      }) {
        return Contact(
          id: id ?? this.id,
          name: name ?? this.name,
          phone: phone ?? this.phone,
          email: email ?? this.email,
          address: address ?? this.address,
          isFavourite: isFavourite ?? this.isFavourite,
        );
      }
  }



