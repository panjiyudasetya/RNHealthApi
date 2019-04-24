package com.healthsdk.data;

import java.util.List;
import java.util.Objects;

public class HealthValue<T> extends DataTimeRange {
    private T value;

    public HealthValue(T value, long startTime, long endTime) {
        super(startTime, endTime);
        this.value = value;
    }

    public T getValue() {
        return value;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        if (!super.equals(o)) return false;
        HealthValue<?> that = (HealthValue<?>) o;
        return Objects.equals(value, that.value);
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), value);
    }

    @Override
    public String toString() {
        return "HealthValue{" +
                "value=" + value +
                ", startTime=" + startTime +
                ", endTime=" + endTime +
                '}';
    }

    public static int getTotalIntegers(List<HealthValue<Integer>> values) {
        if (values == null || values.isEmpty()) return 0;
        int total = 0;
        for (HealthValue<Integer> value : values) {
            total += value.getValue();
        }
        return total;
    }
}
