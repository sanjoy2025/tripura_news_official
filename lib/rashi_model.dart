class RashiDataModel {
  DateTime? currentTimeStamp;
  String? rashi;
  String? frequency;
  String? dateDetails;
  String? sunsign;
  String? prediction;
  JsonToKotlinBaseMoney? money;
  JsonToKotlinBaseFamily? family;
  JsonToKotlinBaseRelation? relation;
  JsonToKotlinBaseOccupation? occupation;
  JsonToKotlinBaseLuckynumber? luckynumber;
  JsonToKotlinBaseLuckydirection? luckydirection;
  JsonToKotlinBaseLuckygem? luckygem;
  JsonToKotlinBaseLuckycolour? luckycolour;

  RashiDataModel({
    this.currentTimeStamp,
    this.rashi,
    this.frequency,
    this.dateDetails,
    this.sunsign,
    this.prediction,
    this.money,
    this.family,
    this.relation,
    this.occupation,
    this.luckynumber,
    this.luckydirection,
    this.luckygem,
    this.luckycolour,
  });

  factory RashiDataModel.fromJson(Map<String, dynamic> json) {
    return RashiDataModel(
      currentTimeStamp: json['currentTimeStamp'] != null ? DateTime.parse(json['currentTimeStamp']) : null,
      rashi: json['rashi'],
      frequency: json['frequency'],
      dateDetails: json['dateDetails'],
      sunsign: json['sunsign'],
      prediction: json['prediction'],
      money: JsonToKotlinBaseMoney.fromJson(json['money']),
      family: JsonToKotlinBaseFamily.fromJson(json['family']),
      relation: JsonToKotlinBaseRelation.fromJson(json['relation']),
      occupation: JsonToKotlinBaseOccupation.fromJson(json['occupation']),
      luckynumber: JsonToKotlinBaseLuckynumber.fromJson(json['luckynumber']),
      luckydirection: JsonToKotlinBaseLuckydirection.fromJson(json['luckydirection']),
      luckygem: JsonToKotlinBaseLuckygem.fromJson(json['luckygem']),
      luckycolour: JsonToKotlinBaseLuckycolour.fromJson(json['luckycolour']),
    );
  }
}

class JsonToKotlinBaseMoney {
  String? title;
  String? rating;
  String? details;

  JsonToKotlinBaseMoney({
    this.title,
    this.rating,
    this.details,
  });

  factory JsonToKotlinBaseMoney.fromJson(Map<String, dynamic> json) {
    return JsonToKotlinBaseMoney(
      title: json['title'],
      rating: json['rating'],
      details: json['details'],
    );
  }
}

class JsonToKotlinBaseFamily {
  String? title;
  String? rating;
  String? details;

  JsonToKotlinBaseFamily({
    this.title,
    this.rating,
    this.details,
  });

  factory JsonToKotlinBaseFamily.fromJson(Map<String, dynamic> json) {
    return JsonToKotlinBaseFamily(
      title: json['title'],
      rating: json['rating'],
      details: json['details'],
    );
  }
}

class JsonToKotlinBaseRelation {
  String? title;
  String? rating;
  String? details;

  JsonToKotlinBaseRelation({
    this.title,
    this.rating,
    this.details,
  });

  factory JsonToKotlinBaseRelation.fromJson(Map<String, dynamic> json) {
    return JsonToKotlinBaseRelation(
      title: json['title'],
      rating: json['rating'],
      details: json['details'],
    );
  }
}

class JsonToKotlinBaseOccupation {
  String? title;
  String? rating;
  String? details;

  JsonToKotlinBaseOccupation({
    this.title,
    this.rating,
    this.details,
  });

  factory JsonToKotlinBaseOccupation.fromJson(Map<String, dynamic> json) {
    return JsonToKotlinBaseOccupation(
      title: json['title'],
      rating: json['rating'],
      details: json['details'],
    );
  }
}

class JsonToKotlinBaseLuckynumber {
  String? title;
  String? details;

  JsonToKotlinBaseLuckynumber({
    this.title,
    this.details,
  });

  factory JsonToKotlinBaseLuckynumber.fromJson(Map<String, dynamic> json) {
    return JsonToKotlinBaseLuckynumber(
      title: json['title'],
      details: json['details'],
    );
  }
}

class JsonToKotlinBaseLuckydirection {
  String? title;
  String? details;

  JsonToKotlinBaseLuckydirection({
    this.title,
    this.details,
  });

  factory JsonToKotlinBaseLuckydirection.fromJson(Map<String, dynamic> json) {
    return JsonToKotlinBaseLuckydirection(
      title: json['title'],
      details: json['details'],
    );
  }
}

class JsonToKotlinBaseLuckygem {
  String? title;
  String? details;

  JsonToKotlinBaseLuckygem({
    this.title,
    this.details,
  });

  factory JsonToKotlinBaseLuckygem.fromJson(Map<String, dynamic> json) {
    return JsonToKotlinBaseLuckygem(
      title: json['title'],
      details: json['details'],
    );
  }
}

class JsonToKotlinBaseLuckycolour {
  String? title;
  String? details;

  JsonToKotlinBaseLuckycolour({
    this.title,
    this.details,
  });

  factory JsonToKotlinBaseLuckycolour.fromJson(Map<String, dynamic> json) {
    return JsonToKotlinBaseLuckycolour(
      title: json['title'],
      details: json['details'],
    );
  }
}
