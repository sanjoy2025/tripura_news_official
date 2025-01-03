class Horoscope {
  dynamic currentTimeStamp;
  String? rashi;
  String? frequency;
  String? dateDetails;
  String? sunsign;
  String? prediction;
  String? descriptionDetails;
  Money? money;
  Family? family;
  Relation? relation;
  Occupation? occupation;
  LuckyNumber? luckyNumber;
  LuckyDirection? luckyDirection;
  LuckyGem? luckyGem;
  LuckyColour? luckyColour;

  Horoscope({
    this.currentTimeStamp,
    this.rashi,
    this.frequency,
    this.dateDetails,
    this.sunsign,
    this.prediction,
    this.descriptionDetails,
    this.money,
    this.family,
    this.relation,
    this.occupation,
    this.luckyNumber,
    this.luckyDirection,
    this.luckyGem,
    this.luckyColour,
  });

  factory Horoscope.fromJson(Map<String, dynamic> json) => Horoscope(
        currentTimeStamp: json["currentTimeStamp"],
        rashi: json["rashi"],
        frequency: json["frequency"],
        dateDetails: json["dateDetails"],
        sunsign: json["sunsign"],
        prediction: json["prediction"],
        descriptionDetails: json["descriptionDetails"],
        money: Money.fromJson(json["money"]),
        family: Family.fromJson(json["family"]),
        relation: Relation.fromJson(json["relation"]),
        occupation: Occupation.fromJson(json["occupation"]),
        luckyNumber: LuckyNumber.fromJson(json["luckynumber"]),
        luckyDirection: LuckyDirection.fromJson(json["luckydirection"]),
        luckyGem: LuckyGem.fromJson(json["luckygem"]),
        luckyColour: LuckyColour.fromJson(json["luckycolour"]),
      );

  Map<String, dynamic> toJson() => {
        "currentTimeStamp": currentTimeStamp,
        "rashi": rashi,
        "frequency": frequency,
        "dateDetails": dateDetails,
        "sunsign": sunsign,
        "prediction": prediction,
        "descriptionDetails": descriptionDetails,
        "money": money?.toJson(),
        "family": family?.toJson(),
        "relation": relation?.toJson(),
        "occupation": occupation?.toJson(),
        "luckynumber": luckyNumber?.toJson(),
        "luckydirection": luckyDirection?.toJson(),
        "luckygem": luckyGem?.toJson(),
        "luckycolour": luckyColour?.toJson(),
      };
}

class Money {
  String? title;
  String? rating;
  String? details;

  Money({
    this.title,
    this.rating,
    this.details,
  });

  factory Money.fromJson(Map<String, dynamic> json) => Money(
        title: json["title"],
        rating: json["rating"],
        details: json["details"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "rating": rating,
        "details": details,
      };
}

class Family {
  String? title;
  String? rating;
  String? details;

  Family({
    this.title,
    this.rating,
    this.details,
  });

  factory Family.fromJson(Map<String, dynamic> json) => Family(
        title: json["title"],
        rating: json["rating"],
        details: json["details"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "rating": rating,
        "details": details,
      };
}

class Relation {
  String? title;
  String? rating;
  String? details;

  Relation({
    this.title,
    this.rating,
    this.details,
  });

  factory Relation.fromJson(Map<String, dynamic> json) => Relation(
        title: json["title"],
        rating: json["rating"],
        details: json["details"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "rating": rating,
        "details": details,
      };
}

class Occupation {
  String? title;
  String? rating;
  String? details;

  Occupation({
    this.title,
    this.rating,
    this.details,
  });

  factory Occupation.fromJson(Map<String, dynamic> json) => Occupation(
        title: json["title"],
        rating: json["rating"],
        details: json["details"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "rating": rating,
        "details": details,
      };
}

class LuckyNumber {
  String? title;
  String? details;

  LuckyNumber({
    this.title,
    this.details,
  });

  factory LuckyNumber.fromJson(Map<String, dynamic> json) => LuckyNumber(
        title: json["title"],
        details: json["details"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "details": details,
      };
}

class LuckyDirection {
  String? title;
  String? details;

  LuckyDirection({
    this.title,
    this.details,
  });

  factory LuckyDirection.fromJson(Map<String, dynamic> json) => LuckyDirection(
        title: json["title"],
        details: json["details"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "details": details,
      };
}

class LuckyGem {
  String? title;
  String? details;

  LuckyGem({
    this.title,
    this.details,
  });

  factory LuckyGem.fromJson(Map<String, dynamic> json) => LuckyGem(
        title: json["title"],
        details: json["details"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "details": details,
      };
}

class LuckyColour {
  String? title;
  String? details;

  LuckyColour({
    this.title,
    this.details,
  });

  factory LuckyColour.fromJson(Map<String, dynamic> json) => LuckyColour(
        title: json["title"],
        details: json["details"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "details": details,
      };
}
