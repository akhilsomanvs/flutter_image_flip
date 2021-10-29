class GetMemeResponseModel {
  GetMemeResponseModel({
    required this.success,
    required this.data,
  });
  late final bool success;
  late final Data data;

  GetMemeResponseModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.memes,
  });
  late final List<Memes> memes;

  Data.fromJson(Map<String, dynamic> json){
    memes = List.from(json['memes']).map((e)=>Memes.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['memes'] = memes.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Memes {
  Memes({
    required this.id,
    required this.name,
    required this.url,
    required this.width,
    required this.height,
    required this.boxCount,
  });
  late final String id;
  late final String name;
  late final String url;
  late final int width;
  late final int height;
  late final int boxCount;

  bool isSaved=false;

  Memes.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    url = json['url'];
    width = json['width'];
    height = json['height'];
    boxCount = json['box_count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['url'] = url;
    _data['width'] = width;
    _data['height'] = height;
    _data['box_count'] = boxCount;
    return _data;
  }
}