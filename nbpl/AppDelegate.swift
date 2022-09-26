//
//  AppDelegate.swift
//  nbpl
//
//  Created by Nexdha on 02/06/22.
//

import UIKit
import CoreData
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

     
struct Nexdha_student {
            static var location = ""
            static var server = "https://student.nexdha.com"
        //  static var server =  "https://studsan.nexdha.com"
            static var name_user = ""
            static var login_heading = ""
            static var Upi_name = ""
            static var Upi_id = ""
            static var purpose_pay_scanner = ""
            static var user_id = "" //user id
            static var name = "" //dashboard username
            static var phone = "" //dashboard phone
            static var email = "" //dashboard email
            static var kyc = "" //dashboard email
            static var type_of_user = ""
            static var kyc_of_usertype = ""
            static var login_phone_number = ""
            static var percentage_bill_parent_to_student = ""
            static var total_amt = ""
            static var late_fee = ""
            static var name_bill_pay_parentdashboard = ""
            static var bill_value = ""
            static var bill_number = ""
            static var final_pay_GW = ""
            static var hash_for_pg = ""
            static var order_id = ""
            static var order_token = ""
            static var onboarding_screen = ""
            static var usertype_otp = ""
            static var app_version = ""
            static var Billdate1 = ""
            static var Billdate2 = ""
            static var due_date_only = ""
            static var Upiamt = ""
        }



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Thread.sleep(forTimeInterval: 2.0)
        return true
    }
    var orientationLock = UIInterfaceOrientationMask.all

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
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

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "nbpl")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

