//
//  TextInputAlert.swift
//  Push Doctor
//
//  Created by Will McGinty on 8/10/21.
//

import AppKit

extension NSAlert {
  
  // MARK: - Message
  struct AlertConfiguration {
    
    public var title: String
    public var message: String
    
    // MARK: - Preset
    static let duplicateName = AlertConfiguration(title: "Duplicate Name",
                                                  message: "A template with that name already exists. Please choose another.")
  }
  
  static func presentInformationalAlert(for config: AlertConfiguration) {
    let alert = NSAlert()
    alert.alertStyle = .informational
    alert.messageText = config.title
    alert.informativeText = config.message
    
    alert.addButton(withTitle: "OK")
    alert.runModal()
  }
  
  // MARK: - Text Input
  struct TextInputAlertConfiguration {
    
    public var title: String
    public var message: String
    public var initialValue: String = ""
    public var placeholder: String = ""
    
    public var accept: String = "OK"
    public var acceptAction: (String) -> Void
    
    public var cancel: String = "Cancel"
    public var cancelAction: (() -> Void)? = nil
    
    // MARK: - Preset
    static func templateNaming(with existing: String = "", acceptAction: @escaping (String) -> Void) -> TextInputAlertConfiguration {
      return TextInputAlertConfiguration(title: "Template Name", message: "Please enter a name for the template:",
                                         initialValue: existing, placeholder: "Name",  acceptAction: acceptAction)
    }
  }
  
  static func presentAlert(for config: TextInputAlertConfiguration) {
    let alert = NSAlert()
    alert.alertStyle = .informational
    alert.messageText = config.title
    alert.informativeText = config.message
    
    alert.addButton(withTitle: config.accept)
    alert.addButton(withTitle: config.cancel)
    
    let textField = NSTextField(frame: NSRect(x: 0, y: 0, width: 200, height: 24))
    textField.placeholderString = config.placeholder
    textField.stringValue = config.initialValue
    alert.accessoryView = textField
    
    let response = alert.runModal()
    
    switch response {
      case .alertFirstButtonReturn: config.acceptAction(textField.stringValue)
      default: config.cancelAction?()
    }
  }
}

