//
//  AppDelegate.swift
//  sdrplay1
//
//  Created by Andy Hooper on 2023-02-01.
//

import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!
    
    let receiveThread: ReceiveThreadProtocol
    
    override init() {
        //print("AppDelegate", ProcessInfo.processInfo.arguments)
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] != nil {
            print("XCODE_RUNNING_FOR_PREVIEWS")
            receiveThread = MockReceiveThread()
        } else if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            print("XCTestConfigurationFilePath")
            receiveThread = MockReceiveThread()
        } else {
            let arguments = ProcessInfo.processInfo.arguments
            if arguments.count > 1 && arguments[1] == "TestAudio" {
                // for audio performance diagnosis
                receiveThread = TestAudio(signalHz: 440, level: 0.2)
            } else if arguments.count > 1 && arguments[1] == "TestSpectrum" {
                receiveThread = TestSpectrum()
            } else if arguments.count > 1 && arguments[1] == "TestCycle" {
                receiveThread = TestCycle()
            } else {
                receiveThread = ReceiveThread()
            }
        }
    }
    
    fileprivate func setupData() {
        let context = persistentContainer.viewContext

        do {
            let fr = Band.fetchRequest()
            let count = try context.count(for: fr)
            print("Bands count", count)
            if count == 0 {
                let AM = Band(context: context)
                AM.name          = "AM"
                AM.antenna       = "Antenna C"
                AM.demodulator   = "AM"
                AM.frequency     = 1_000
                AM.step          = 10
                
                let FM = Band(context: context)
                FM.name          = "FM"
                FM.antenna       = "Antenna A"
                FM.demodulator   = "FM"
                FM.frequency     = 100_100
                FM.step          = 200
                
                let Wx = Band(context: context)
                Wx.name          = "Weather"
                Wx.antenna       = "Antenna A"
                Wx.demodulator   = "NFM"
                Wx.frequency     = 162_400
                Wx.step          = 25
                
                try context.save()
            }
        } catch let error as NSError {
            print("Bands setup failed", error.localizedDescription, error.userInfo)
        }

        do {
            let fr = Station.fetchRequest()
            let count = try context.count(for: fr)
            print("Stations count", count)
            if count == 0 {
                let bandFetch = Band.fetchRequest()
                bandFetch.fetchLimit = 1
                bandFetch.predicate = NSPredicate(format: "name == %@", "FM")
                let FMband = try context.fetch(bandFetch).first
                bandFetch.predicate = NSPredicate(format: "name == %@", "AM")
                let AMband = try context.fetch(bandFetch).first
                bandFetch.predicate = NSPredicate(format: "name == %@", "Weather")
                let Wxband = try bandFetch.execute().first
                
                let fm96 = Station(context: context)
                fm96.name = "CFMK"
                fm96.frequency = 96_300
                fm96.demodulator = "FM"
                fm96.band = FMband
                let fm98 = Station(context: context)
                fm98.name = "CFLY"
                fm98.frequency = 98_300
                fm98.demodulator = "FM"
                fm98.band = FMband
                let xjv = Station(context: context)
                xjv.name = "XJV363"
                xjv.frequency = 162_400
                xjv.demodulator = "FM"
                xjv.band = Wxband
                let siggen = Station(context: context)
                siggen.name = "SigGen"
                siggen.frequency = 1_400
                siggen.demodulator = "AM"
                siggen.band = AMband
                
                try context.save()
            }
        } catch let error as NSError {
            print("Stations setup failed", error.localizedDescription, error.userInfo)
        }
        
        
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        setupData()
        
        // Create the SwiftUI view and set the context as the value for the managedObjectContext environment keyPath.
        // Add `@Environment(\.managedObjectContext)` in the views that will need the context.
        let contentView = ContentView(frequency: 96300, receiveThread: receiveThread,
                                      antennaChoices: receiveThread.getAntennas(),
                                      antenna: receiveThread.getAntennas()[0],
                                      gainChoices: receiveThread.getGains(),
                                      gain: -40)
            .environment(\.managedObjectContext, persistentContainer.viewContext)

        // Create the window and set the content view.
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 720, height: 450),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
        
        receiveThread.start()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        print("applicationWillTerminate")
        receiveThread.cancel()
        sleep(1) // let receiver finish
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "sdradio1")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
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
                fatalError("loadPersistentStores Unresolved error \(error)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving and Undo support

    @IBAction func saveAction(_ sender: AnyObject?) {
        // Performs the save action for the application, which is to send the save: message to the application's managed object context. Any encountered errors are presented to the user.
        let context = persistentContainer.viewContext

        if !context.commitEditing() {
            NSLog("\(NSStringFromClass(type(of: self))) unable to commit editing before saving")
        }
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Customize this code block to include application-specific recovery steps.
                let nserror = error as NSError
                NSApplication.shared.presentError(nserror)
            }
        }
    }

    func windowWillReturnUndoManager(window: NSWindow) -> UndoManager? {
        // Returns the NSUndoManager for the application. In this case, the manager returned is that of the managed object context for the application.
        return persistentContainer.viewContext.undoManager
    }

    func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
        // Save changes in the application's managed object context before the application terminates.
        let context = persistentContainer.viewContext
        
        if !context.commitEditing() {
            NSLog("\(NSStringFromClass(type(of: self))) unable to commit editing to terminate")
            return .terminateCancel
        }
        
        if !context.hasChanges {
            return .terminateNow
        }
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError

            // Customize this code block to include application-specific recovery steps.
            let result = sender.presentError(nserror)
            if (result) {
                return .terminateCancel
            }
            
            let question = NSLocalizedString("Could not save changes while quitting. Quit anyway?", comment: "Quit without saves error question message")
            let info = NSLocalizedString("Quitting now will lose any changes you have made since the last successful save", comment: "Quit without saves error question info");
            let quitButton = NSLocalizedString("Quit anyway", comment: "Quit anyway button title")
            let cancelButton = NSLocalizedString("Cancel", comment: "Cancel button title")
            let alert = NSAlert()
            alert.messageText = question
            alert.informativeText = info
            alert.addButton(withTitle: quitButton)
            alert.addButton(withTitle: cancelButton)
            
            let answer = alert.runModal()
            if answer == .alertSecondButtonReturn {
                return .terminateCancel
            }
        }
        // If we got here, it is time to quit.
        return .terminateNow
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

