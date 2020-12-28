//
//  AppDelegate.swift
//  YoLoBoo
//
//  Created by Jennie Ding on 12/26/20.
//  Copyright © 2020 Juan Ding. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    typealias dataInfo = (name: String, postal: String, capital: String, population: String)
    let items:[dataInfo] = [ ("Alabama",   "AL" ,   "Montgomery",    "4,903,185"),
                             ("Alaska",    "AK",    "Juneau",    "731,545"),
                             ("Arizona",    "AZ",    "Phoenix",    "7,278,717"),
                             ("Arkansas",    "AR",    "Little Rock",    "3,017,804"),
                             ("California",    "CA",    "Sacramento",    "39,512,223"),
                             ("Colorado" ,   "CO",    "Denver",    "5,758,736"),
                             ("Connecticut",    "CT",   "Hartford",   "3,565,287"),
                             ("Delaware",    "DE",    "Dover",    "973,764"),
                             ("Florida" ,   "FL",    "Tallahassee",    "21,477,737"),
                             ("Georgia",    "GA",    "Atlanta",    "10,617,423"),
                             ("Hawaii",    "HI",    "Honolulu",    "1,415,872"),
                             ("Idaho" ,   "ID",    "Boise",    "1,787,065"),
                             ("Illinois",    "IL",    "Springfield",    "12,671,821"),
                             ("Indiana",   "IN",    "Indianapolis",    "6,732,219"),
                             ("Iowa",    "IA",    "Des Moines",    "3,155,070"),
                             ("Kansas" ,   "KS",    "Topeka",    "2,913,314"),
                             ("Kentucky"  ,  "KY",    "Frankfort",    "4,467,673"),
                             ("Louisiana",    "LA",    "Baton Rouge",    "4,648,794"),
                             ("Maine",    "ME",    "Augusta",    "1,344,212"),
                             ("Maryland",    "MD",    "Annapolis",    "6,045,680"),
                             ("Massachusetts",    "MA",    "Boston",    "6,892,503"),
                             ("Michigan" ,   "MI",    "Lansing",    "9,986,857"),
                             ("Minnesota",    "MN",    "St. Paul",    "5,639,632"),
                             ("Mississippi" ,   "MS",    "Jackson",    "2,976,149"),
                             ("Missouri",    "MO",    "Jefferson City",    "6,137,428"),
                             ("Montana" ,   "MT",    "Helena",    "1,068,778"),
                             ("Nebraska",   "NE",    "Lincoln",    "1,934,408"),
                             ("Nevada" ,   "NV",    "Carson City",    "3,080,156"),
                             ("New Hampshire" ,   "NH",   "Concord" ,   "1,359,711"),
                             ("New Jersey" ,   "NJ",    "Trenton",    "8,882,190"),
                             ("New Mexico",    "NM",    "Santa Fe",    "2,096,829"),
                             ("New York" ,   "NY",    "Albany",    "19,453,561"),
                             ("North Carolina",    "NC",    "Raleigh",    "10,488,084"),
                             ("North Dakota" ,   "ND",   "Bismarck",    "762,062"),
                             ("Ohio",    "OH",    "Columbus",    "11,689,100"),
                             ("Oklahoma" ,   "OK",    "Oklahoma City",    "3,956,971"),
                             ("Oregon"  ,  "OR" ,   "Salem" ,   "4,217,737"),
                             ("Pennsylvania" ,   "PA",    "Harrisburg",    "12,801,989"),
                             ("Rhode Island" ,   "RI",    "Providence",    "1,059,361"),
                             ("South Carolina" ,   "SC",    "Columbia",    "5,148,714"),
                             ("South Dakota"  ,  "SD",    "Pierre",    "884,659"),
                             ("Tennessee" ,   "TN" ,   "Nashville",    "6,829,174"),
                             ("Texas" ,   "TX",    "Austin",    "28,995,881"),
                             ("Utah" ,   "UT",    "Salt Lake City",    "3,205,958"),
                             ("Vermont" ,  "VT",    "Montpelier",    "623,989"),
                             ("Virginia"  ,  "VA",    "Richmond",    "8,535,519"),
                             ("Washington" ,   "WA",    "Olympia",   "7,614,893"),
                             ("West Virginia" ,   "WV" ,  "Charleston",    "1,792,147"),
                             ("Wisconsin",   "WI",    "Madison",    "5,822,434"),
                             ("Wyoming" ,   "WY",    "Cheyenne",    "578,759")]

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
//        for data in items {
//            Firestore.firestore().collection("states").document(data.postal).setData(["name": data.name,   "capital": data.capital, "population" : data.population, "postal": data.postal]) { err in
//                
//                
//            }
//        }
        
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

