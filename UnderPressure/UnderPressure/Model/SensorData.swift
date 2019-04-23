//
//  SensorData.swift
//  UnderPressure
//
//  Created by murph on 4/23/19.
//  Copyright © 2019 k9doghouse. All rights reserved.
//

import UIKit
import CoreMotion
import CoreData

class SensorData: UIView {

    var rawPressure = 999.99
    var intervalTimer: Timer!

    let hour = 3600
    let day: Int = 86400
    let altimeter = CMAltimeter()


    func intervalTimer3600()
    {
        intervalTimer = Timer.scheduledTimer(timeInterval: TimeInterval(hour),
                                             target: self,
                                             selector: #selector(getSensorData),
                                             userInfo: nil,
                                             repeats: true)
    }

    @objc func getSensorData()
    {
        if CMAltimeter.isRelativeAltitudeAvailable()
        {
            altimeter.startRelativeAltitudeUpdates(to: OperationQueue.main)
            {
                (data, error) in
                if !(error != nil)
                {
                    // Pressure as a rounded Int
                    self.rawPressure = Double(truncating: (data?.pressure)!) * 10.00
                    let pressureText = String(format: "%.0f", self.rawPressure)+"mb"

                    // time and date
                    var date = Date()
                    date.addTimeInterval(TimeInterval(self.day))

                    let formatter00 = DateFormatter()
                    formatter00.timeStyle = .medium
                    formatter00.dateStyle = .medium

                    let currentDateTime = Date()
                    let dateTimeString = formatter00.string(from: currentDateTime)

                    //Mark - Save the new sensor reading
                    let entityDescription = NSEntityDescription.entity(forEntityName: "Entity", in: TableViewController().pc)

                    let item = Entity(entity: entityDescription!, insertInto: TableViewController().pc)
                    item.texttitle = dateTimeString+" CTD:  "+pressureText  /// Fix for locale and time zone
                    
                    self.altimeter.stopRelativeAltitudeUpdates()
                } else { print(" Oops! 😕 1 ") }
            }  }  else { print(" Oops! 😕 2 ") }
    } }
