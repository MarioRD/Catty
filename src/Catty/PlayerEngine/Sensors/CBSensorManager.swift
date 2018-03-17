/**
 *  Copyright (C) 2010-2018 The Catrobat Team
 *  (http://developer.catrobat.org/credits)
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Affero General Public License as
 *  published by the Free Software Foundation, either version 3 of the
 *  License, or (at your option) any later version.
 *
 *  An additional term exception under section 7 of the GNU Affero
 *  General Public License, version 3, is available at
 *  (http://developer.catrobat.org/license_additional_term)
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *  GNU Affero General Public License for more details.
 *
 *  You should have received a copy of the GNU Affero General Public License
 *  along with this program.  If not, see http://www.gnu.org/licenses/.
 */

import CoreMotion
import CoreLocation

@objc class CBSensorManager : NSObject, SensorManagerProtocol {
    
    @objc public static let shared = CBSensorManager()
    public var defaultValueForUndefinedSensor : Double = 0
    
    private var sensors : [String : CBSensor]
    private var motionManager : CMMotionManager
    private var locationManager : CLLocationManager
    
    override private init() {
        motionManager = CMMotionManager()
        locationManager = CLLocationManager()
        sensors = [String : CBSensor]()
        super.init()
        
        registerSensors()
    }
    
    func registerSensors() {
        register(sensor: InclinationXSensor(motionManager: motionManager))
        register(sensor: InclinationYSensor(motionManager: motionManager))
        register(sensor: AccelerationXSensor(motionManager: motionManager))
        register(sensor: AccelerationYSensor(motionManager: motionManager))
        register(sensor: AccelerationZSensor(motionManager: motionManager))
        register(sensor: CompassDirectionSensor(locationManager: locationManager))
    }
    
    func register(sensor: CBSensor) {
        sensors[sensor.tagForSerialization] = sensor
    }
    
    func sensor(tag: String) -> CBSensor? {
        return sensors[tag]
    }
    
    func value(sensor: CBSensor) -> Double {
        guard sensor.isAvailable() else { return sensor.defaultValue }
        
        if sensor.isActive() == false {
            sensor.start()
        }
        
        return sensor.value()
    }
    
    @objc func value(sensorTag: String) -> Double {
        guard let sensor = sensor(tag: sensorTag) else { return defaultValueForUndefinedSensor }
        
        return value(sensor: sensor)
    }
    
    func stopSensors() {
        for (_, sensor) in sensors {
            sensor.stop()
        }
    }
}
