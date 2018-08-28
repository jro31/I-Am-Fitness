//
//  ViewController.swift
//  I Am Fitness
//
//  Created by Jethro Williams on 27/08/2018.
//  Copyright © 2018 Jethro Williams. All rights reserved.
//

import UIKit
import HealthKit

class ViewController: UIViewController {
    
    let healthStore = HKHealthStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if HKHealthStore.isHealthDataAvailable() {
            // Add code to use HealthKit here.
            requestWorkoutReadPermissions()
        }
    }
    
    func requestWorkoutReadPermissions() {
        let workouts = Set([HKObjectType.workoutType(), HKQuantityType.workoutType()]) //This line selects 'workouts' as the data to be requested by users. I don't know why I've defined '.workoutType()' twice. It seems to work the same with one, the other, or both, so I just left it as both.
        
        healthStore.requestAuthorization(toShare: nil, read: workouts) { (success, error) in
            if !success {
                let alert = UIAlertController(title: "Unable to read workouts", message: "Please go to Settings and allow I Am Fitness to view your workout data", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                
                let goToSettingsAction = UIAlertAction(title: "Go to Settings", style: .default) { (_) -> Void in
                    guard let settingsURL = URL(string: UIApplicationOpenSettingsURLString) else {
                        return
                    }
                    if UIApplication.shared.canOpenURL(settingsURL) {
                        UIApplication.shared.open(settingsURL, completionHandler: { (success) in
                            print("Settings opened: \(success)") // Prints true
                        })
                }
            }
                alert.addAction(goToSettingsAction)
                
                alert.preferredAction = goToSettingsAction
                self.present(alert, animated: true)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

