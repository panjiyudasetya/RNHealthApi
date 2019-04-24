import { NativeModules } from 'react-native';

import IHealthApi, { DataType } from './IHealthApi';

class HealthApi implements IHealthApi {
    private healthApi: IHealthApi;

    constructor() {
        this.healthApi = NativeModules.RNHealthApi;
    }

    /** @inheritdoc */
    hasPermissionsFor(dataTypes: DataType[]): Promise<void> {
        return this.healthApi.hasPermissionsFor(dataTypes);
    }

    /** @inheritdoc */
    askPermissionFor(dataTypes: DataType[]): Promise<void> {
        return this.healthApi.askPermissionFor(dataTypes);
    }

    /** @inheritdoc */
    getStepCountToday(): Promise<number> {
        return this.healthApi.getStepCountToday();
    }

    /** @inheritdoc */
    disconnect(): Promise<void> {
        return this.healthApi.disconnect();
    }
}

export default HealthApi;
