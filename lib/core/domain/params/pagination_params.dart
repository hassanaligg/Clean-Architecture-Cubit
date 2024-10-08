class PaginationParams {
  int skipCount = 0;
  int maxResultCount;

  PaginationParams(this.skipCount, this.maxResultCount);

  Map<String, dynamic> toJson() => {
        "SkipCount": skipCount,
        "MaxResultCount": maxResultCount,
      };
}
