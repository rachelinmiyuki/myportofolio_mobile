
import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

@JsonSerializable()
class Project {
  final String id;
  final String title;
  final String description;

  @JsonKey(name: 'project_type')
  final String category;

  @JsonKey(name: 'project_type_display')
  final String categoryDisplay;

  final String? thumbnail;

  @JsonKey(name: 'tag1')
  final String? technologies;

  @JsonKey(name: 'detail_url')
  final String? projectLink;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.categoryDisplay,
    this.thumbnail,
    this.technologies,
    this.projectLink,
  });

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
