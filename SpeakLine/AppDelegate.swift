//
//  AppDelegate.swift
//  SpeakLine
//
//  Created by joecaz on 6/1/17.
//  Copyright © 2017 Coyote Creek Software. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var mainWindowController: MainWindowController?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create a Window Controller
        let mainWindowController = MainWindowController()
        
        // Put the window of the WindowController on the screen
        mainWindowController.showWindow(self)
        
        // Set the property to point to the WindowController
        self.mainWindowController = mainWindowController
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}
