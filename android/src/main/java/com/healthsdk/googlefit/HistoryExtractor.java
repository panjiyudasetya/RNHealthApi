package com.healthsdk.googlefit;

import android.support.annotation.Nullable;
import android.util.Log;

import com.google.android.gms.fitness.data.DataPoint;
import com.google.android.gms.fitness.data.DataSet;
import com.google.android.gms.fitness.data.Field;
import com.google.android.gms.fitness.data.Value;
import com.healthsdk.data.HealthValue;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.TimeUnit;

abstract class HistoryExtractor<T> {
    private static final String TAG = "HistoryExtractor";

    /**
     * Helper function to extract data points history from {@link DataSet}
     * @param dataSet {@link DataSet}
     * @return {@link List<HealthValue<T>} Input kit values
     */
    List<HealthValue<T>> historyFromDataSet(@Nullable DataSet dataSet) {
        if (dataSet == null) return Collections.emptyList();
        Log.i(TAG, "Data returned for Data type: " + dataSet.getDataType().getName());

        List<HealthValue<T>> contents = new ArrayList<>();

        for (DataPoint dp : dataSet.getDataPoints()) {
            contents.add(new HealthValue<>(
                    getDataPointValue(dp),
                    dp.getStartTime(TimeUnit.MILLISECONDS),
                    dp.getEndTime(TimeUnit.MILLISECONDS)
            ));
        }
        return contents;
    }

    /**
     * Get data point value.
     * @param dataPoint Detected value in {@link DataPoint}
     * @return T value with specific type
     */
    abstract T getDataPointValue(@Nullable DataPoint dataPoint);

    /**
     * Convert data point as integer value
     * @param dataPoint Detected {@link DataPoint} from Fit history
     * @return Integer of data point value, otherwise 0 will be returned.
     * @throws {@link IllegalStateException} when `value.getFormat()` not equals integer
     *          -> 1 means data point value in integer format
     *          -> 2 means data point value in float format
     *          -> 3 means data point value in string format
     */
    int asInt(@Nullable DataPoint dataPoint) {
        Value value = getValue(dataPoint);
        return value == null ? 0 : value.asInt();
    }

    /**
     * Get data point value.
     * @param dataPoint Detected {@link DataPoint}
     * @return {@link Value} of detected data point
     */
    @Nullable
    private Value getValue(@Nullable DataPoint dataPoint) {
        if (dataPoint == null || dataPoint.getDataType() == null) return null;

        List<Field> fields = dataPoint.getDataType().getFields();
        if (fields == null || fields.isEmpty()) return null;

        // Usually this fields only contains one row, so we can directly return the value
        return dataPoint.getValue(fields.get(0));
    }
}
