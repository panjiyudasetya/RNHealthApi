package com.healthsdk.googlefit;

import android.support.annotation.NonNull;

import com.google.android.gms.fitness.FitnessOptions;
import com.google.android.gms.fitness.data.DataType;
import com.healthsdk.Constants;

public class Permissions {

    private Permissions() { }

    static FitnessOptions getPermissionsSet(@NonNull String[] sampleTypes) {
        FitnessOptions.Builder builder = FitnessOptions.builder();
        if (sampleTypes != null && sampleTypes.length > 0) {
            for (String sampleType : sampleTypes) {
                createFitnessOptions(sampleType, builder);
            }
        }
        return builder.build();
    }

    private static void createFitnessOptions(@NonNull String sampleType,
                                      @NonNull FitnessOptions.Builder builder) {
        if (sampleType.equals(Constants.STEP_COUNT)) {
            builder.addDataType(
                    DataType.TYPE_STEP_COUNT_DELTA,
                    FitnessOptions.ACCESS_READ
            ).addDataType(
                    DataType.AGGREGATE_STEP_COUNT_DELTA,
                    FitnessOptions.ACCESS_READ
            );
            return;
        }

        if (sampleType.equals(Constants.DISTANCE_WALKING_OR_RUNNING)) {
            builder.addDataType(
                    DataType.TYPE_DISTANCE_DELTA,
                    FitnessOptions.ACCESS_READ
            ).addDataType(
                    DataType.AGGREGATE_DISTANCE_DELTA,
                    FitnessOptions.ACCESS_READ
            );
        }
    }
}
