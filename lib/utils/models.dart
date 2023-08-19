class UserCustom {
  final int id;
  final int circleId;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String profileCode;
  final bool isCircleOwner;
  final DateTime createdAt;

  UserCustom({
    required this.id,
    required this.circleId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.profileCode,
    required this.isCircleOwner,
    required this.createdAt,
  });
}

class Media {
  final int id;
  final int userId;
  final int circleId;
  final int promptId;
  final int type;
  final DateTime postDate;
  final String firebaseUrl;
  final String textContent;

  Media({
    required this.id,
    required this.userId,
    required this.circleId,
    required this.promptId,
    required this.type,
    required this.postDate,
    required this.firebaseUrl,
    required this.textContent,
  });
}

class Prompts {
  final int id;
  final String prompt;
  final DateTime postDate;

  Prompts({
    required this.id,
    required this.prompt,
    required this.postDate,
  });
}

class Circles {
  final int id;

  Circles({
    required this.id,
  });
}
