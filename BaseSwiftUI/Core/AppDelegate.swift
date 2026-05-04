//
//  AppDelegate.swift
//  CTF
//
//  Created by Ahmed Ramadan on 25/11/2025.
//

import UIKit
import FirebaseCore
import FirebaseMessaging
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {

        FirebaseApp.configure()

        UNUserNotificationCenter.current().delegate = self
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            } else {
                print("⚠️ Notification permission not granted: \(error?.localizedDescription ?? "")")
            }
        }

        Messaging.messaging().delegate = self
        return true
    }

    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        Messaging.messaging().apnsToken = deviceToken
    }

    func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable : Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
    ) {
        handleIncomingPush(userInfo: userInfo, source: .backgroundOrSilent)
        completionHandler(.newData)
    }

    private enum PushSource {
        case foreground
        case backgroundOrSilent
        case tap
    }

    private func handleIncomingPush(userInfo: [AnyHashable: Any], source: PushSource) {
        guard let payload = PushPayload(userInfo: userInfo) else { return }

        NotificationCenter.default.post(name: .notificationsShouldRefresh, object: nil)

        switch source {
        case .foreground, .backgroundOrSilent:
            NotificationCenter.default.post(name: .pushDidReceiveForeground, object: payload)

        case .tap:
            NotificationCenter.default.post(name: .pushDidTap, object: payload)
        }
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("🔥 [FCM] New registration token: \(fcmToken ?? "nil")")
        UserDefaults.pushNotificationToken = fcmToken
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        let userInfo = notification.request.content.userInfo
        handleIncomingPush(userInfo: userInfo, source: .foreground)
        completionHandler([.banner, .sound, .badge])
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        let userInfo = response.notification.request.content.userInfo
        handleIncomingPush(userInfo: userInfo, source: .tap)
        completionHandler()
    }
}
