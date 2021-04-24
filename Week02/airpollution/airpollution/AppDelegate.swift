//
//  AppDelegate.swift
//  airpollution
//
//  Created by leadon-dev on 2021/04/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    //--- 앱이 시작될때 실행
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    //-- inActive로 이동될때
    func applicationWillResignActive(_ application: UIApplication) {
        print("will inActive")
    }
    
    //-- 백그라운드 상태
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    //-- back -> foreground로 이동될때
    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }
    
    //-- 앱이 active 상태
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    //-- 앱이 종료될때 실행
    func applicationWillTerminate(_ application: UIApplication) {
        
    }


}
