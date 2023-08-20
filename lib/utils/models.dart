import 'package:cloud_firestore/cloud_firestore.dart';

class UserCustom {
  final String? id;
  final String? circleId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? profileCode;
  final bool? isCircleOwner;
  final Timestamp? createdAt;

  UserCustom({
    this.id,
    this.circleId,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.profileCode,
    this.isCircleOwner,
    this.createdAt,
  });

  factory UserCustom.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserCustom(
      id: data?['id'],
      circleId: data?['circleId'],
      firstName: data?['firstName'],
      lastName: data?['lastName'],
      email: data?['email'],
      phoneNumber: data?['phoneNumber'],
      profileCode: data?['profileCode'],
      isCircleOwner: data?['isCircleOwner'],
      createdAt: data?['createdAt'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (circleId != null) "circleId": circleId,
      if (firstName != null) "firstName": firstName,
      if (lastName != null) "lastName": lastName,
      if (email != null) "email": email,
      if (phoneNumber != null) "phoneNumber": phoneNumber,
      if (profileCode != null) "profileCode": profileCode,
      if (isCircleOwner != null) "isCircleOwner": isCircleOwner,
      if (createdAt != null) "createdAt": createdAt,
    };
  }
}

class MediaCustom {
  final int? id;
  final int? userId;
  final String? circleId;
  final int? promptId;
  final int? type;
  final DateTime? postDate;
  final String? firebaseUrl;
  final String? textContent;

  MediaCustom({
    this.id,
    this.userId,
    this.circleId,
    this.promptId,
    this.type,
    this.postDate,
    this.firebaseUrl,
    this.textContent,
  });

  factory MediaCustom.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return MediaCustom(
      id: data?['id'],
      circleId: data?['circleId'],
      userId: data?['userId'],
      promptId: data?['promptId'],
      type: data?['type'],
      postDate: data?['postDate'],
      firebaseUrl: data?['firebaseUrl'],
      textContent: data?['textContent'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (circleId != null) "circleId": circleId,
      if (userId != null) "firstName": userId,
      if (promptId != null) "lastName": promptId,
      if (type != null) "email": type,
      if (postDate != null) "phoneNumber": postDate,
      if (firebaseUrl != null) "profileCode": firebaseUrl,
      if (textContent != null) "isCircleOwner": textContent,
    };
  }
}

class PromptsCustom {
  final int? id;
  final String? prompt;
  final DateTime? postDate;

  PromptsCustom({
    this.id,
    this.prompt,
    this.postDate,
  });

  factory PromptsCustom.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return PromptsCustom(
      id: data?['id'],
      prompt: data?['prompt'],
      postDate: data?['postDate'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (prompt != null) "circleId": prompt,
      if (postDate != null) "firstName": postDate,
    };
  }
}

class CirclesCustom {
  final String? id;

  CirclesCustom({
    this.id,
  });

  factory CirclesCustom.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return CirclesCustom(
      id: data?['id'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
    };
  }
}
