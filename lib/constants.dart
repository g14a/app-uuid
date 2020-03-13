import 'package:get_ip/get_ip.dart';

class AppConstants {
  static final ipAddress = GetIp.ipAddress;
  
  Future<String> getIPAddr() async {
    String ip = await GetIp.ipAddress;
    
    return ip.toString();
  }
}