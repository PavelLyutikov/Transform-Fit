//
//  AppDelegate.swift
//  Transform
//
//  Created by Nikita Malevich on 9/23/20.
//

import UIKit

import Firebase
import SwiftyStoreKit
//import YandexMobileMetrica

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
//        let configuration = YMMYandexMetricaConfiguration.init(apiKey: "d2b3aa64-5d2e-4a50-8f2a-e99d4a5e4698")
//            YMMYandexMetrica.activate(with: configuration!)
        
        FirebaseApp.configure()
        startViewController()
        
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for purchase in purchases {
                switch purchase.transaction.transactionState {
                case .purchased, .restored:
                    if purchase.needsFinishTransaction {
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
                case .failed, .purchasing, .deferred:
                    break
                @unknown default:
                    break
                }
            }
        }
        
        // Override point for customization after application launch.
        return true
    }

    func startViewController() {
        UserDefaults.standard.set(false, forKey: "isOpenHomeWorkout")
        UserDefaults.standard.set(false, forKey: "isOpenYoga")
        UserDefaults.standard.set(false, forKey: "isOpenRecovery")
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        
        if !UserDefaults.standard.bool(forKey: "isFirstLaunch") {
            saveArray()
            UserDefaults.standard.set(true, forKey: "isFirstLaunchAppTransformUpdate3")
            
            window?.rootViewController = PreviewViewController()
           } else {
            window?.rootViewController = MainViewController()
//               window?.rootViewController = PreviewStretchingViewController()
           }
           UserDefaults.standard.set(true, forKey: "isFirstLaunch")
    }
    
    func saveArray() {
        let array: [String] = []
        
        UserDefaults.standard.set(array, forKey: "chosenExercisesPostPregnancyRecovery")
        UserDefaults.standard.set(array, forKey: "chosenExercisesStretching")
        UserDefaults.standard.set(array, forKey: "chosenExercisesYoga")
        UserDefaults.standard.set(array, forKey: "chosenExercises")
    }
}

