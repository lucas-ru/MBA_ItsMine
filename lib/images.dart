// To parse this JSON data, do
//
//     final Object = ObjectFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Object> ObjectFromJson(String str) => List<Object>.from(json.decode(str).map((x) => Object.fromJson(x)));

String ObjectToJson(List<Object> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Object {
  Object({
    required this.id,
    required this.name,
    required this.info,
    required this.publishedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
  });

  final int? id;
  final String? name;
  final String? info;
  final DateTime? publishedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Image>? images;

  factory Object.fromJson(Map<String, dynamic> json) => Object(
    id: json["id"],
    name: json["name"],
    info: json["info"],
    publishedAt: DateTime.parse(json["published_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "info": info,
    "published_at": publishedAt!.toIso8601String(),
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "images": List<dynamic>.from(images!.map((x) => x.toJson())),
  };
}

class Image {
  Image({
    required this.id,
    required this.name,
    required this.alternativeText,
    required this.caption,
    required this.width,
    required this.height,
    required this.formats,
    required this.hash,
    required this.ext,
    required this.mime,
    required this.size,
    required this.url,
    required this.previewUrl,
    required this.provider,
    required this.providerMetadata,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? name;
  final String? alternativeText;
  final String? caption;
  final int? width;
  final int? height;
  final Formats? formats;
  final String? hash;
  final String? ext;
  final String? mime;
  final double? size;
  final String? url;
  final dynamic previewUrl;
  final String? provider;
  final dynamic providerMetadata;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["id"],
    name: json["name"],
    alternativeText: json["alternativeText"],
    caption: json["caption"],
    width: json["width"],
    height: json["height"],
    formats: Formats.fromJson(json["formats"]),
    hash: json["hash"],
    ext: json["ext"],
    mime: json["mime"],
    size: json["size"].toDouble(),
    url: json["url"],
    previewUrl: json["previewUrl"],
    provider: json["provider"],
    providerMetadata: json["provider_metadata"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "alternativeText": alternativeText,
    "caption": caption,
    "width": width,
    "height": height,
    "formats": formats!.toJson(),
    "hash": hash,
    "ext": ext,
    "mime": mime,
    "size": size,
    "url": url,
    "previewUrl": previewUrl,
    "provider": provider,
    "provider_metadata": providerMetadata,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class Formats {
  Formats({
    required this.large,
    required this.small,
    required this.medium,
    required this.thumbnail,
  });

  final Large? large;
  final Large? small;
  final Large? medium;
  final Large? thumbnail;

  factory Formats.fromJson(Map<String, dynamic> json) => Formats(
    large: Large.fromJson(json["large"]),
    small: Large.fromJson(json["small"]),
    medium: Large.fromJson(json["medium"]),
    thumbnail: Large.fromJson(json["thumbnail"]),
  );

  Map<String, dynamic> toJson() => {
    "large": large!.toJson(),
    "small": small!.toJson(),
    "medium": medium!.toJson(),
    "thumbnail": thumbnail!.toJson(),
  };
}

class Large {
  Large({
    required this.ext,
    required this.url,
    required this.hash,
    required this.mime,
    required this.name,
    required this.path,
    required this.size,
    required this.width,
    required this.height,
  });

  final String ext;
  final String url;
  final String hash;
  final String mime;
  final String name;
  final dynamic path;
  final double size;
  final int width;
  final int height;

  factory Large.fromJson(Map<String, dynamic> json) => Large(
    ext: json["ext"],
    url: json["url"],
    hash: json["hash"],
    mime: json["mime"],
    name: json["name"],
    path: json["path"],
    size: json["size"].toDouble(),
    width: json["width"],
    height: json["height"],
  );

  Map<String, dynamic> toJson() => {
    "ext": ext,
    "url": url,
    "hash": hash,
    "mime": mime,
    "name": name,
    "path": path,
    "size": size,
    "width": width,
    "height": height,
  };
}