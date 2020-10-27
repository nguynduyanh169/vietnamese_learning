
class GoogleImageUtil {

  static String editUrl(String inputUrl){
    int startIndex = inputUrl.indexOf('file/d/') + 7;
    int endIndex = inputUrl.indexOf('/view?usp=sharing');
    String imgCode = inputUrl.substring(startIndex, endIndex);
    String outputUrl = 'https://drive.google.com/uc?export=view&id=$imgCode';
    return outputUrl;
  }
}