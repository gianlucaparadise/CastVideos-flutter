import 'package:cast_videos_flutter/models/category_descriptor.dart';

class VideoCatalog {
  List<CategoryDescriptor>? categories;

  VideoCatalog.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      var jsonCategories = <CategoryDescriptor>[];
      json['categories'].forEach((v) {
        jsonCategories.add(new CategoryDescriptor.fromJson(v));
      });
      this.categories = jsonCategories;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categories'] = this.categories?.map((v) => v.toJson()).toList();
    return data;
  }
}
