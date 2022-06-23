//
//  DateFormatter+Utility.swift
//  Notify
//
//  Created by William McGinty on 7/28/20.
//

import Foundation

extension DateFormatter {
  
  static var standard: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    
    return formatter
  }
}

