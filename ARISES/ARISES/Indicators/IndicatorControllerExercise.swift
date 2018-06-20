//
//  IndicatorControllerExercise.swift
//  ARISES
//
//  Created by Ryan Armiger on 05/06/2018.
//  Copyright © 2018 Ryan Armiger. All rights reserved.
//

import UIKit

class IndicatorControllerExercise: UIViewController {

    @IBOutlet weak var indicatorCountdown: UILabel!
    @IBOutlet weak var indicatorActivityName: UILabel!
    @IBOutlet weak var indicatorLabel: UILabel!
    
    private var currentDay: Day = ModelController().findOrMakeDay(day: Date())
    /*
    let userCalendar = Calendar.current
    let dateFormatter = DateFormatter()
    let requestedComponent: Set<Calendar.Component> = [.day,.hour,.minute,.second]
    private var nextExercise: Exercise? = nil
 */
    let nc = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        indicatorCountdown.isHidden = true
        indicatorActivityName.isHidden = true
        indicatorLabel.isHidden = true
        */
        nc.addObserver(self, selector: #selector(exerciseUpdated), name: Notification.Name("ExerciseAdded"), object: nil)
        
        // Do any additional setup after loading the view.


    }

    @objc private func exerciseUpdated(){
        
    }
    /*
    @objc private func exerciseUpdated(){
        indicatorCountdown.isHidden = false
        indicatorActivityName.isHidden = false
        indicatorLabel.isHidden = false
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        let currentTime = timeFormatter.string(from: Date())
        var exerciseArray: [Exercise] = currentDay.exercise?.allObjects as! [Exercise]

        exerciseArray = exerciseArray.filter({ (Exercise) -> Bool in
            (TimeInterval((Exercise.time)!)! - TimeInterval(currentTime)!) > TimeInterval(0)
        })
        if exerciseArray.isEmpty{
            print("no future exercise")
        }
        else{
            for index in exerciseArray{
                if nextExercise == nil{
                    nextExercise = index
                }
                else{
                    if Double((index.time)!)! < Double((nextExercise?.time)!)!{
                        nextExercise = index
                    }
                }
            }
            let interval = Double((nextExercise?.time)!)! - Double(currentTime)!
            Timer.init(fire: Date(), interval: interval, repeats: false) { (Timer) in
                self.updateTime()
            }
            
        }
    }
    
    @objc private func updateTime(){
        dateFormatter.dateFormat = "hh:mm:ss"
        let startTime = Date()
        let endTime = dateFormatter.date(from: (nextExercise?.time!)!)
        let timeDifference = userCalendar.dateComponents(requestedComponent, from: startTime, to: endTime!)
        
        indicatorCountdown.text = "\(timeDifference.day!) Days \(timeDifference.hour!) Hours \(timeDifference.minute!) Minutes \(timeDifference.second!) Seconds"



    }
 */


}
