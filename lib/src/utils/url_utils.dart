class UrlUtils {
  static String editImgUrl(String inputUrl) {
    if (inputUrl == null) {
      String errorUrl =
          'https://drive.google.com/file/d/127VMNW_-mtqTKndVaHBeG2uxaobn9oYJ/view?usp=sharing';
      int startIndex = errorUrl.indexOf('file/d/') + 7;
      int endIndex = errorUrl.indexOf('/view?usp=sharing');
      String imgCode = errorUrl.substring(startIndex, endIndex);
      String outputUrl = 'https://drive.google.com/uc?export=view&id=$imgCode';
      return outputUrl;
    } else {
      int startIndex = inputUrl.indexOf('file/d/') + 7;
      int endIndex = inputUrl.indexOf('/view?usp=sharing');
      String imgCode = inputUrl.substring(startIndex, endIndex);
      String outputUrl = 'https://drive.google.com/uc?export=view&id=$imgCode';
      return outputUrl;
    }
  }

  static String editAudioUrl(String inputUrl){
    int startIndex = inputUrl.indexOf('file/d/') + 7;
    int endIndex = inputUrl.indexOf('/view?usp=sharing');
    String imgCode = inputUrl.substring(startIndex, endIndex);
    String outputUrl = 'https://drive.google.com/uc?export=view&id=$imgCode';
    return outputUrl;
  }

}
