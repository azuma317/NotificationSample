//
//  ViewController.swift
//  AZ_NotificationSample
//
//  Created by Azuma on 2018/06/28.
//  Copyright © 2018 Azuma. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func defaultNotificationAction(_ sender: Any) {
        let trigger: UNNotificationTrigger
        trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = "通常の通知"
        content.body = "body"
        content.sound = UNNotificationSound.default
        let request = UNNotificationRequest(identifier: "normal", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    @IBAction func fiveSecondNotificationAction(_ sender: Any) {
        let trigger: UNNotificationTrigger
        trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = "5秒後通知"
        content.body = "body"
        content.sound = UNNotificationSound.default
        let request = UNNotificationRequest(identifier: "normal", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    @IBAction func buttonNotificationAction(_ sender: Any) {
        let trigger: UNNotificationTrigger
        trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let okAction = UNNotificationAction(identifier: NotificationActionID.ok.rawValue, title: "OK", options: [])
        let cancelAction = UNNotificationAction(identifier: NotificationActionID.cancel.rawValue, title: "Cancel", options: [])
        let categories = UNNotificationCategory(identifier: "message", actions: [okAction, cancelAction], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([categories])
        let content = UNMutableNotificationContent()
        content.title = "Action付き通知"
        content.body = "body"
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "message"
        let request = UNNotificationRequest(identifier: "message", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    @IBAction func dateNotificationAction(_ sender: Any) {
        let trigger: UNNotificationTrigger
        let calendar = Calendar(identifier: .gregorian)
        var dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
        dateComponents.minute = dateComponents.minute! + 1
        trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = "時間指定で通知(次分で通知)"
        content.body = "body"
        content.sound = UNNotificationSound.default
        let request = UNNotificationRequest(identifier: "calendar", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    @IBAction func imageNotificationAction(_ sender: Any) {
        let trigger: UNNotificationTrigger
        trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = "写真付き通知"
        content.body = "body"
        content.sound = UNNotificationSound.default
        if let url = Bundle.main.url(forResource: "myImage", withExtension: "png") {
            let attachment = try? UNNotificationAttachment(identifier: "attachment", url: url, options: nil)
            if let attachment = attachment {
                content.attachments = [attachment]
            }
            content.categoryIdentifier = "attachment"
        }
        let request = UNNotificationRequest(identifier: "attachment", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}

enum NotificationActionID: String {
    case ok
    case cancel
}
