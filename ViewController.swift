//
//  ViewController.swift
//  Project2020
//
//  Created by Virraimy Hiciano on 3/3/20.
//  Copyright © 2020 Virraimy Hiciano. All rights reserved.
//
import UserNotifications
import UIKit

class ViewController: UIViewController, UNUserNotificationCenterDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector (registerLocal))
      
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector (scheduleLocal))
             
    }
    
    
    @objc func registerLocal(){
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        center.requestAuthorization(options:  [ .alert, .badge, .sound]) { granted, error in
            if granted {
                print("Yay")
                }
            else {
                print ("Naw")
            }
        }
    }
    
    @objc func scheduleLocal(){
        
     regiterCategories()
        
        let  center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Remeber to use our App"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 3
        dateComponents.minute = 00
        //Time interval for seconds
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        //This is to schedule a notification everyday at a certain time
        //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        

        let request = UNNotificationRequest(identifier: UUID().uuidString,content:content, trigger: trigger)
        center.add(request)
    
        //View controller handling , 1:Identifier , 2: title , 3 Options related to the actions
        
        
    }
        
    func regiterCategories(){
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let show = UNNotificationAction(identifier: "shoow", title: "Tell me more...", options: .foreground)
        //options array is for more advance notifications such as carPlay support, showing the title even when the user disable this action and etc.
        let category = UNNotificationCategory (identifier: "alarm", actions: [show], intentIdentifiers: [])
        
        center.setNotificationCategories([category])
    }
    
    func userNotificationCenter(  _ center: UNUserNotificationCenter, didReceive
        response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void){
        let userInfo =  response.notification.request.content.userInfo
        if let customData = userInfo[ "customData"] as? String{
            print ("custom data reciebved: \(customData)")
            

            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                //the user swipe to unlock
                print("Default identifier")
                
            case "show":
                print("Show more information...")
                
            default:
                break
                
                
                
            }
        }
        
        completionHandler()
    }
}

    




