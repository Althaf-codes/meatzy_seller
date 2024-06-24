import 'dart:convert';

class User {
  String id;
  String email;
  String userName;
  String phoneNumber;
  String password;
  String address;
  List<dynamic> cart;
  List<dynamic> wishlist;
  List<dynamic> orders;
  String profileImage;
  bool isSeller;
  bool isPremiumSeller;
  bool isLocalAreaAdmin;
  bool isMainAdmin;
  bool isMeatSeller;
  String type;
  String chats;
  String token;
  String sellerID;
  String localAreaAdminID;
  String meatSellerID;
  String mainAdminID;

  User(
      {required this.id,
      required this.email,
      required this.userName,
      required this.phoneNumber,
      required this.password,
      required this.address,
      required this.cart,
      required this.wishlist,
      required this.orders,
      required this.profileImage,
      required this.isSeller,
      required this.isPremiumSeller,
      required this.isLocalAreaAdmin,
      required this.isMainAdmin,
      required this.isMeatSeller,
      required this.type,
      required this.chats,
      required this.token,
      required this.sellerID,
      required this.localAreaAdminID,
      required this.meatSellerID,
      required this.mainAdminID});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'password': password,
      'address': address,
      'cart': cart,
      'wishlist': wishlist,
      'orders': orders,
      'profileImage': profileImage,
      'isSeller': isSeller,
      'isPremiumSeller': isPremiumSeller,
      'isLocalAreaAdmin': isLocalAreaAdmin,
      'isMainAdmin': isMainAdmin,
      'isMeatSeller': isMeatSeller,
      'type': type,
      'chats': chats,
      'token': token,
      'sellerID': sellerID,
      'localAreaAdminID': localAreaAdminID,
      'meatSellerID': meatSellerID,
      'mainAdminID': mainAdminID
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['_id'] ?? '',
        email: map['email'] ?? '',
        userName: map['userName'] ?? '',
        phoneNumber: map['phoneNumber'] ?? '',
        password: map['password'] ?? '',
        address: map['address'] ?? '',
        cart: List<Map<String, dynamic>>.from(
          map['cart']?.map(
            (x) => Map<String, dynamic>.from(x),
          ),
        ),
        wishlist: List<Map<String, dynamic>>.from(
            map['wishlist']?.map((x) => Map<String, dynamic>.from(x))),
        orders: List<Map<String, dynamic>>.from(
          map['orders']?.map(
            (x) => Map<String, dynamic>.from(x),
          ),
        ),
        profileImage: map['profileImage'] ?? '',
        isSeller: map['isSeller'] ?? false,
        isPremiumSeller: map['isPremiumSeller'] ?? false,
        isLocalAreaAdmin: map['isLocalAreaAdmin'] ?? false,
        isMainAdmin: map['isMainAdmin'] ?? false,
        isMeatSeller: map['isMeatSeller'] ?? false,
        type: map['type'] ?? '',
        chats: map['chats'] ?? '',
        token: map['token'] ?? '',
        sellerID: map['sellerID'] ?? '',
        localAreaAdminID: map['localAreaAdminID'] ?? '',
        meatSellerID: map['meatSellerID'] ?? '',
        mainAdminID: map['mainAdminID'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? email,
    String? userName,
    String? phoneNumber,
    String? password,
    String? address,
    List<dynamic>? cart,
    List<dynamic>? wishlist,
    List<dynamic>? orders,
    String? profileImage,
    bool? isSeller,
    bool? isPremiumSeller,
    bool? isLocalAreaAdmin,
    bool? isMainAdmin,
    bool? isMeatSeller,
    String? type,
    String? chats,
    String? token,
    String? sellerID,
    String? localAreaAdminID,
    String? meatSellerID,
    String? mainAdminID,
  }) {
    return User(
        id: id ?? this.id,
        email: email ?? this.email,
        userName: userName ?? this.userName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        password: password ?? this.password,
        address: address ?? this.address,
        cart: cart ?? this.cart,
        wishlist: wishlist ?? this.wishlist,
        orders: this.orders,
        profileImage: profileImage ?? this.profileImage,
        isSeller: isSeller ?? this.isSeller,
        isPremiumSeller: isPremiumSeller ?? this.isPremiumSeller,
        isLocalAreaAdmin: isLocalAreaAdmin ?? this.isLocalAreaAdmin,
        isMainAdmin: isMainAdmin ?? this.isMainAdmin,
        isMeatSeller: isMeatSeller ?? this.isMeatSeller,
        type: type ?? this.type,
        chats: chats ?? this.chats,
        token: token ?? this.token,
        sellerID: sellerID ?? this.sellerID,
        localAreaAdminID: localAreaAdminID ?? this.localAreaAdminID,
        meatSellerID: meatSellerID ?? this.meatSellerID,
        mainAdminID: mainAdminID ?? this.mainAdminID);
  }
}




// {
//     "id":"",
//     "userName":"",
//     "phoneNumber":"",
//     "password":"",
//   "address":"",
//    "cart":[{
//        "product":{},
//        "quantity":""
//    }],
//   "orders":[{
//        "product":{},
//        "quantity":""
//    }],
//  "profileImage":""
//  "isSeller":false
//    "isPremiumSeller":false
//    "isLocalAreaAdmin":false
//   "isMainAdmin":false,
//   "isMeatSeller":false,
//    "type":"",
//   "chats":"",
// }