class GetPlaceRequestModel {
  final int count;
  final int offset;
  final String pageBy;
  final String pageAfter;
  final String pagePrior;
  final List<String> sortBy;

  const GetPlaceRequestModel({
    this.count = 0,
    this.offset = 0,
    this.pageBy = '',
    this.pageAfter = '',
    this.pagePrior = '',
    this.sortBy = const [],
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'count': count,
        'offset': offset,
        'pageBy': pageBy,
        'pageAfter': pageAfter,
        'pagePrior': pagePrior,
        'sortBy': List<String>.from(sortBy.map<String>((x) => x)),
      };
}
