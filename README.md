此版本为google play 专用版删除修改了所有内置更新的方法 by long51xy
国内版请用 https://github.com/crazecoder/flutter_bugly.git

# flutter_bugly 
[![pub package](https://img.shields.io/pub/v/flutter_bugly.svg)](https://pub.dartlang.org/packages/flutter_bugly)
[![Gitter](https://badges.gitter.im/flutter_developer/community.svg)](https://gitter.im/flutter_developer/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

腾讯Bugly flutter应用更新插件

## 支持Android/iOS 运营统计、原生异常上报、flutter异常上报、应用更新

---

一、引入
--
```yaml
//因为大部分主流插件都已升级androidx，所以pub库升级androidx
//版本更新弹窗问题见下面说明
//androidx 
dependencies:
  flutter_bugly: lastVersion
  
//support
dependencies:
  flutter_bugly:
    git:
      url: git://github.com/long51xy/flutter_bugly_google_play
      ref: master
```

二、项目配置
---
在android/app/build.gradle的android下加入

```gradle
    defaultConfig {
        ndk {
            //设置支持的SO库架构
            abiFilters 'armeabi-v7a'//, 'arm64-v8a', 'x86', 'x86_64'
        }
    }
```

三、使用
----
```dart
import 'package:flutter_bugly/flutter_bugly.dart';

//使用flutter异常上报
void main()=>FlutterBugly.postCatchedException((){
  runApp(MyApp());
});

FlutterBugly.init(androidAppId: "your android app id",iOSAppId: "your iOS app id");

```

四、release打包（Android）
-----
64-bit
```
flutter build apk --release --target-platform android-arm64
```
32-bit（目前配合armeabi-v7a可以打出32位64位通用包）
```
flutter build apk --release --target-platform android-arm
```

五、支持属性（Android）
-----
```dart
 String channel, //自定义渠道标识
 

 FlutterBugly.setUserId("user id");
 FlutterBugly.putUserData(key: "key", value: "value");
 int tag = 9527;
 FlutterBugly.setUserTag(tag);
```

六、说明（Android）
-------
异常上报说明

1、flutter异常上报不属于崩溃，所以如需查看flutter的异常上报，请在【错误分析】tab页查看

![](https://github.com/crazecoder/flutter_bugly/blob/1ff1928b3215a8fa1c8fb99c3071692da322e278/screenshot/crash.png)


2、iOS的异常上报没有过多测试，如出现问题请issue

目前已知问题

~~1、第一次接受到更新策略之后，不会弹窗，即使手动检查更新也不会，需要退出app之后再进入，才会有弹窗（已解决）~~

~~2、官方没有适配8.0的notification，所以如果需要用到notification的时候请关闭后（默认关闭），自己写相关业务逻辑，或者直接把gradle里的targetSdkVersion设成26以下（方法见示例）~~ 官方已适配

~~3、请勿在targetSdkVersion 26以上设置autoDownloadOnWifi = true，会导致在8.0以上机型更新策略没有反应~~

4、因为版本更新弹窗封装进sdk，使用的是support包，所以使用androidx包时，请配合FlutterBugly.getUpgradeInfo()或者FlutterBugly.checkUpgrade()【两种方法区别见方法注释】方法自定义弹窗界面 [弹窗示例](https://github.com/crazecoder/flutter_bugly/commit/6052890cee63ec1e433501e1149852878fd234de)或者[有下载打开安装的完整示例](https://github.com/crazecoder/testsocket/blob/master/lib/ui/home.dart)

