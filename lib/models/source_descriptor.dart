class SourceDescriptor {
  String? type;
  String? mime;
  String? url;

  SourceDescriptor.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    mime = json['mime'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['mime'] = this.mime;
    data['url'] = this.url;
    return data;
  }
}
