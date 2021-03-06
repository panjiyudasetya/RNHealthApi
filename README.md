
# sdk-template-health-api

## Getting started

`$ yarn add git+ssh://git@github.com:panjiyudasetya/RNHealthApi.git#[specific_branch]`

### Mostly automatic installation

`$ react-native link sdk-template-health-api`


### Health provider installation

#### iOS

- Due to HealthKit SDK is a primary health provider on iOS, then you need to update `info.plist` in your React Native project:

```
<key>NSHealthShareUsageDescription</key>
<string>Read and understand health data.</string>
<key>NSHealthUpdateUsageDescription</key>
<string>Share workout data with other apps.</string>
```

- Enable Health Kit on your Application Capabilities

![image](https://user-images.githubusercontent.com/21379421/56630452-a2367800-667b-11e9-85c3-b972db86b228.png)

- Compile project and Run.

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `sdk-template-health-api` and add `RNHealthApi.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNHealthApi.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.healthsdk.RNHealthApiPackage;` to the imports at the top of the file
  - Add `new RNHealthApiPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':sdk-template-health-api'
  	project(':sdk-template-health-api').projectDir = new File(rootProject.projectDir, 	'../node_modules/sdk-template-health-api/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':sdk-template-health-api')
  	```


## Usage
```javascript
import RNHealthApi from 'sdk-template-health-api';

// TODO: What to do with the module?
RNHealthApi;
```


## Extra Configuration

### Android

In this template, Android Health Api is integrated with Fitness Api and to be able to access Fit Api, you must sign your app and setup your RN App OAuth 2.0 Client ID [here](https://developers.google.com/fit/android/get-api-key).
