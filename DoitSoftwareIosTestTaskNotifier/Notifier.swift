//
//  Notifier.swift
//  DoitSoftwareIosTestTaskNotifier
//
//  Created by Ihor Myroniuk on 17.05.2021.
//

import UserNotifications

public enum TaskPriority2: String {
    case high = "High"
    case medium = "Medium"
    case low = "Low"
}

public struct Task2 {
    public let id: Int
    public let title: String
    public let dueBy: Date
    public let priority: TaskPriority2
    
    public init(id: Int, title: String, dueBy: Date, priority: TaskPriority2) {
        self.id = id
        self.title = title
        self.dueBy = dueBy
        self.priority = priority
    }
}

public class Notifier {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    public init() {
        
    }
    
    open func registerLocal() {
        let center = UNUserNotificationCenter.current()

        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }
    }
    
    open func scheduleTask(_ task: Task2) {
        let content = UNMutableNotificationContent()
        content.title = task.title
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 30
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        //UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        notificationCenter.add(request)
    }
 
}
