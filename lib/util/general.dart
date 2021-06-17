String formulateString(String str, int maxLength) {
  if(str.length > maxLength) {
    return str.substring(0,maxLength) + "...";
  }
  return str;
}