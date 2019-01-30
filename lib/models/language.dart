class Language {
  String name;
  String code;
  bool isRecent;
  bool isDownloaded;
  bool isDownloadable;

  Language(String code, String name, bool isRecent, bool isDownloaded,
      bool isDownloadable) {
    this.name = name;
    this.code = code;
    this.isRecent = isRecent;
    this.isDownloaded = isDownloaded;
    this.isDownloadable = isDownloadable;
  }
}
