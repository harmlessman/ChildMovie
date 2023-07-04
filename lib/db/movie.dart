
class Movie{
  String? aplcName;
  String? coreHarmRsn;
  String? descriptive_content;
  String? direName;
  String? direNatnlName;
  String? gradeName;
  String? leadaName;
  String? mvAssoName;
  String? oriTitle;
  String? prodYear;
  String? prodcName;
  String? prodcNatnlName;
  String? rtCoreHarmRsnNm;
  String? rtDate;
  String? rtNo;
  String? rtStdName1;
  String? rtStdName2;
  String? rtStdName3;
  String? rtStdName4;
  String? rtStdName5;
  String? rtStdName6;
  String? rtStdName7;
  String? screTime;
  String? stadCont;
  String? suppaName;
  String? useTitle;
  String? workCont;

  Movie({
    this.aplcName,
    this.coreHarmRsn,
    this.descriptive_content,
    this.direName,
    this.direNatnlName,
    this.gradeName,
    this.leadaName,
    this.mvAssoName,
    this.oriTitle,
    this.prodYear,
    this.prodcName,
    this.prodcNatnlName,
    this.rtCoreHarmRsnNm,
    this.rtDate,
    this.rtNo,
    this.rtStdName1,
    this.rtStdName2,
    this.rtStdName3,
    this.rtStdName4,
    this.rtStdName5,
    this.rtStdName6,
    this.rtStdName7,
    this.screTime,
    this.stadCont,
    this.suppaName,
    this.useTitle,
    this.workCont,
  });

  Movie.fromJson(Map<String, dynamic> json) {
    aplcName = json['aplcName'];
    coreHarmRsn = json['coreHarmRsn'];
    descriptive_content = json['descriptive_content'];
    direName = json['direName'];
    direNatnlName = json['direNatnlName'];
    gradeName = json['gradeName'];
    leadaName = json['leadaName'];
    mvAssoName = json['mvAssoName'];
    oriTitle = json['oriTitle'];
    prodYear = json['prodYear'];
    prodcName = json['prodcName'];
    prodcNatnlName = json['prodcNatnlName'];
    rtCoreHarmRsnNm = json['rtCoreHarmRsnNm'];
    rtDate = json['rtDate'];
    rtNo = json['rtNo'];
    rtStdName1 = json['rtStdName1'];
    rtStdName2 = json['rtStdName2'];
    rtStdName3 = json['rtStdName3'];
    rtStdName4 = json['rtStdName4'];
    rtStdName5 = json['rtStdName5'];
    rtStdName6 = json['rtStdName6'];
    rtStdName7 = json['rtStdName7'];
    screTime = json['screTime'];
    stadCont = json['stadCont'];
    suppaName = json['suppaName'];
    useTitle = json['useTitle'];
    workCont = json['workCont'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aplcName'] = this.aplcName;
    data['coreHarmRsn'] = this.coreHarmRsn;
    data['descriptive_content'] = this.descriptive_content;
    data['direName'] = this.direName;
    data['direNatnlName'] = this.direNatnlName;
    data['gradeName'] = this.gradeName;
    data['leadaName'] = this.leadaName;
    data['mvAssoName'] = this.mvAssoName;
    data['oriTitle'] = this.oriTitle;
    data['prodYear'] = this.prodYear;
    data['prodcName'] = this.prodcName;
    data['prodcNatnlName'] = this.prodcNatnlName;
    data['rtCoreHarmRsnNm'] = this.rtCoreHarmRsnNm;
    data['rtDate'] = this.rtDate;
    data['rtNo'] = this.rtNo;
    data['rtStdName1'] = this.rtStdName1;
    data['rtStdName2'] = this.rtStdName2;
    data['rtStdName3'] = this.rtStdName3;
    data['rtStdName4'] = this.rtStdName4;
    data['rtStdName5'] = this.rtStdName5;
    data['rtStdName6'] = this.rtStdName6;
    data['rtStdName7'] = this.rtStdName7;
    data['screTime'] = this.screTime;
    data['stadCont'] = this.stadCont;
    data['suppaName'] = this.suppaName;
    data['useTitle'] = this.useTitle;
    data['workCont'] = this.workCont;
    return data;
  }


}