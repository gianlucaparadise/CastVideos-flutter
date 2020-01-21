class TrackDescriptor {
  String id;
  String type;
  String subtype;
  String contentId;
  String name;
  String language;

  TrackDescriptor(
      {this.id,
      this.type,
      this.subtype,
      this.contentId,
      this.name,
      this.language});

  TrackDescriptor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    subtype = json['subtype'];
    contentId = json['contentId'];
    name = json['name'];
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['subtype'] = this.subtype;
    data['contentId'] = this.contentId;
    data['name'] = this.name;
    data['language'] = this.language;
    return data;
  }
}
