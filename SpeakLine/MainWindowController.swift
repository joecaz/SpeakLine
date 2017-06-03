//
//  MainWindowController.swift
//  SpeakLine
//
//  Created by joecaz on 6/1/17.
//  Copyright © 2017 Coyote Creek Software. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSSpeechSynthesizerDelegate, NSWindowDelegate, NSTableViewDataSource {

    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var speakButton: NSButton!
    @IBOutlet weak var stopButton: NSButton!
    
    let speechSynth = NSSpeechSynthesizer()
    
    let voices = NSSpeechSynthesizer.availableVoices() as! [String]
    
    var isStarted: Bool = false {
        didSet {
            updateButtons()
        }
    }
   
    override var windowNibName: String? {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        updateButtons()
        speechSynth.delegate = self
        // print(voices)
        for voice in voices {
            print(voiceName(identifier: voice)!)
        }
    }
    
    // Mark: - Action methods
    @IBAction func speakIt(sender: NSButton) {
        // Get typed text as string
        let string = textField.stringValue
        
        if string.isEmpty {
            print("string from \(textField) is empty")
        }
        else {
            print("string is \"\(textField.stringValue)\"")
          
        }
        
        speechSynth.startSpeaking(string)
        isStarted = true
    }
    
    @IBAction func stopIt(sender: NSButton) {
        print("stop button clicked")
        speechSynth.stopSpeaking()
        // isStarted = false
    }
    
    func updateButtons() {
        if isStarted {
            speakButton.isEnabled = false
            stopButton.isEnabled = true
        }
        else {
            speakButton.isEnabled = true
            stopButton.isEnabled = false
        }
    }
    
    // Mark: - NSSpeechSynthesizerDelegate
    func speechSynthesizer(_ sender: NSSpeechSynthesizer, didFinishSpeaking finishedSpeaking: Bool) {
        isStarted = false
        print("finishedSpeaking = \(finishedSpeaking)")
    }
    
    // Mark: -  NSWindowDelegate
    func windowShouldClose(_ sender: Any) -> Bool {
        return !isStarted
    }
    
    func voiceName(identifier: String) -> String? {
        let attributes = NSSpeechSynthesizer.attributes(forVoice: identifier)
            return attributes[NSVoiceName] as? String
        
    }
    
    // MARK: - NSTableViewDataSource
    func numberOfRows(in tableView: NSTableView) -> Int {
        return voices.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) ->  Any? {
        let voice = voices[row]
        let voiceName = self.voiceName(identifier: voice)
        return voiceName as AnyObject?
    }
}
