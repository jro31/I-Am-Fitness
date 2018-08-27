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
                // Handle the error here.
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

