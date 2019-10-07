import 'dart:io';
import 'dart:convert';

void main()async{
  print("start");
  var s = await loadData();
  print(s);
  print("end");
}

Future<String> loadData() async{
  var httpClient = new HttpClient();
  var uri = Uri.parse("http://baidu.com");
  var request = await httpClient.getUrl(uri);
  var httpClientResponse = await request.close();
  return await httpClientResponse.transform(utf8.decoder).join();
}
