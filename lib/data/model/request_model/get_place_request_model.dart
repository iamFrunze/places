class GetPlaceRequestModel {
  final int? count;
  final int? offset;
  final String? pageBy;
  final String? pageAfter;
  final String? pagePrior;
  final List<String>? sortBy;

  const GetPlaceRequestModel({
    this.count,
    this.offset,
    this.pageBy,
    this.pageAfter,
    this.pagePrior,
    this.sortBy,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        if (count != null) 'count': count,
        if (offset != null) 'offset': offset,
        if (pageBy != null) 'pageBy': pageBy,
        if (pageAfter != null) 'pageAfter': pageAfter,
        if (pagePrior != null) 'pagePrior': pagePrior,
        if (sortBy != null) 'sortBy': sortBy,
      };
}
