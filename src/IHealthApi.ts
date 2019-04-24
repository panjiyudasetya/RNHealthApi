/** Available data type that can be read by HealthApi in native ios/android */
export declare type DataType = 'stepCount' | 'distanceWalkingRunning';

/**
 * Interface for HealthApi, this is required to make a clear interface between JS and native ios/android.
 * Keeping interface functions consistent accross JS and Native would be easier for us in term of developing HealthApi.
 */
export default interface IHealthApi {
    /**
     * Check either user did asked permission for particular data types or not
     * @param dataTypes data types
     */
    hasPermissionsFor(dataTypes: DataType[]): Promise<void>
    /**
     * Ask permission for particular data types
     * @param dataTypes data types
     */
    askPermissionFor(dataTypes: DataType[]): Promise<void>
    /**
     * Get step count for today
     * @return resolve -> number of step count
     */
    getStepCountToday(): Promise<number>
    /**
     * Disconnect from current health providers
     */
    disconnect(): Promise<void>
}
