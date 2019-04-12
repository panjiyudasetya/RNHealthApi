
package com.healthsdk;

import android.app.Activity;
import android.content.Intent;
import android.util.Pair;

import com.facebook.react.bridge.ActivityEventListener;
import com.facebook.react.bridge.LifecycleEventListener;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableArray;
import com.healthsdk.Exceptions.ExceptionWithCode;
import com.healthsdk.Exceptions.HealthConnectionRefusedError;
import com.healthsdk.HealthApi.ConnectionResult;
import com.healthsdk.googlefit.FitApi;

import java.util.ArrayList;
import java.util.List;

public class RNHealthApiModule extends ReactContextBaseJavaModule implements ActivityEventListener,
        LifecycleEventListener {
    private final HealthApi healthApi;
    private List<Pair<String, Promise>> permissionPairPromises;

    @SuppressWarnings("WeakerAccess")// Public access required by react native
    public RNHealthApiModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.healthApi = new FitApi(reactContext);
        this.permissionPairPromises = new ArrayList<>();
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == FitApi.FIT_PERMISSION_REQUEST_CODE) {
            proceedPermissionPairPromises(resultCode == Activity.RESULT_OK);
        }
    }

    @Override
    public void onHostResume() {
        this.healthApi.setHostActivity(getCurrentActivity());
    }

    @Override
    public void onHostPause() {}

    @Override
    public void onHostDestroy() {}

    @Override
    public String getName() {
        return "RNHealthApi";
    }

    @ReactMethod
    @SuppressWarnings("unused")// Used by react native
    public void hasPermissionsFor(ReadableArray dataTypes, Promise promise) {
        if (healthApi.hasPermissionsFor(getPermissions(dataTypes))) {
            promise.resolve(true);
            return;
        }
        promise.reject("PERMISSIONS_ARE_NOT_GRANTED", new HealthConnectionRefusedError());
    }

    @ReactMethod
    @SuppressWarnings("unused")// Used by react native
    public void askPermissionFor(ReadableArray dataTypes, final Promise promise) {
        // For certain Health services, permission result will be delivered through Android intent. For example,
        // Fitness API. That's why we need to implement {@link ActivityEventListener#onActivityResult}.
        permissionPairPromises.add(Pair.create(healthApi.getName(), promise));
        healthApi.askPermissionFor(getPermissions(dataTypes), new ConnectionResult() {
            @Override
            public void onSuccess(String... messages) {
                proceedPermissionPairPromises(true);
            }

            @Override
            public void onError(ExceptionWithCode error) {
                proceedPermissionPairPromises(false, error);
            }
        });
    }

    @ReactMethod
    @SuppressWarnings("unused")// Used by react native
    public void getStepCountToday(final Promise promise) {
        healthApi.getStepCountToday(new HealthApi.Result<Integer>() {
            @Override
            public void onResult(Integer totalStepCount) {
                promise.resolve(totalStepCount);
            }

            @Override
            public void onError(ExceptionWithCode error) {
                promise.reject("UNABLE_TO_READ_STEP_COUNT", error);
            }
        });
    }

    @ReactMethod
    @SuppressWarnings("unused")// Used by react native
    public void disconnect(final Promise promise) {
        healthApi.disconnect(new ConnectionResult() {
            @Override
            public void onSuccess(String... messages) {
                promise.resolve("REQUEST_SUCCESS");
            }

            @Override
            public void onError(ExceptionWithCode error) {
                promise.reject("DISCONNECTED_TO_HEALTH_API_FAILED", error);
            }
        });
    }

    private void proceedPermissionPairPromises(boolean isConnected, Exception... errors) {
        Exception error = (errors == null || errors.length == 0) ? new HealthConnectionRefusedError() : errors[0];
        List<Pair<String, Promise>> completedPromises = new ArrayList<>();
        for (int i = 0; i< permissionPairPromises.size(); i++) {
            Pair<String, Promise> promiseKeyValue = permissionPairPromises.get(i);
            if (promiseKeyValue.first.equals(healthApi.getName())) {
                completedPromises.add(promiseKeyValue);
                if (isConnected) {
                    promiseKeyValue.second.resolve("CONNECTED_TO_HEALTH_API");
                } else {
                    promiseKeyValue.second.reject("REQUEST_CONNECTION_TO_HEALTH_API_FAILED", error);
                }
            }
        }
        permissionPairPromises.removeAll(completedPromises);
    }

    private String[] getPermissions(ReadableArray dataTypes) {
        if (dataTypes == null || dataTypes.size() == 0) {
            return new String[0];
        }

        List<String> converted = new ArrayList<>();
        for (int i = 0; i< dataTypes.size(); i++) {
            String dataType = dataTypes.getString(i);
            if (dataType.equals(Constants.STEP_COUNT)
                    || dataType.equals(Constants.DISTANCE_WALKING_OR_RUNNING)) {
                converted.add(String.valueOf(dataType));
            }
        }
        return converted.toArray(new String[]{});
    }
}