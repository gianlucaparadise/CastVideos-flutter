import 'package:cast_videos_flutter/models/category_descriptor.dart';

class VideoCatalog {
  List<CategoryDescriptor> categories;

  VideoCatalog({this.categories});

  VideoCatalog.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <CategoryDescriptor>[];
      json['categories'].forEach((v) {
        categories.add(new CategoryDescriptor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
