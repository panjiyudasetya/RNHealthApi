package com.healthsdk;

import android.app.Activity;
import android.content.Context;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

import com.healthsdk.Exceptions.ExceptionWithCode;

public abstract class HealthApi {
    protected Context context;
    protected Activity activity;

    public HealthApi(Context context) {
        this.context = context;
    }

    public interface Result<T> {
        void onResult(T result);
        void onError(ExceptionWithCode error);
    }

    public interface ConnectionResult {
        void onSuccess(String... messages);
        void onError(ExceptionWithCode error);
    }

    public void setHostActivity(@Nullable Activity activity) {
        this.activity = activity;
    }

    public abstract String getName();

    /** Define abstraction health services here, just in case your app require to integrate with multiple health services */
    public abstract boolean hasPermissionsFor(@NonNull String[] dataTypes);
    public abstract void askPermissionFor(@NonNull String[] dataTypes, @NonNull ConnectionResult callback);
    public abstract void getStepCountToday(@NonNull Result<Integer> callback);
    public abstract void disconnect(ConnectionResult callback);
}