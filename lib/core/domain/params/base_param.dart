class PaginationParam {
  int skipCount = 0;
  int maxResultCount;

  PaginationParam({required this.skipCount, required this.maxResultCount});

  Map<String, dynamic> toJson() => {
        "SkipCount": skipCount,
        "MaxResultCount": maxResultCount,
      };

  copyWith({
    int? skipCount,
    int? maxResultCount,
  }) {
    return PaginationParam(
      skipCount: skipCount ?? this.skipCount,
      maxResultCount: maxResultCount ?? this.maxResultCount,
    );
  }
}
