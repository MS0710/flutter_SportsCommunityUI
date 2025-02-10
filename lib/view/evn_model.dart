class ENVRsp {
  List<XMEnvModel>? eNVS;

  ENVRsp({this.eNVS});

  /*ENVRsp.fromJson(Map<String, dynamic> json) {
    if (json['ENVS'] != null) {
      eNVS = List<XMEnvModel>();
      json['ENVS'].forEach((v) {
        eNVS.add(XMEnvModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.eNVS != null) {
      data['ENVS'] = this.eNVS.map((v) => v.toJson()).toList();
    }
    return data;
  }*/
}

class XMEnvModel {
  String? baseUrl;
  String? nodeUrl;
  String? userBaseURL;
  String? name;
  String? used; //1 是 0：否
  bool hide = false;
  bool eidting = false;
  XMEnvModel(
      {this.name, this.baseUrl, this.nodeUrl, this.userBaseURL, this.used});

  XMEnvModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    baseUrl = json['baseUrl'] ?? '';
    nodeUrl = json['nodeUrl'] ?? '';
    userBaseURL = json['userBaseURL'] ?? '';
    used = json['used'] ?? '0';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['baseUrl'] = this.baseUrl;
    data['nodeUrl'] = this.nodeUrl;
    data['userBaseURL'] = this.userBaseURL;
    data['used'] = this.used;
    return data;
  }
}