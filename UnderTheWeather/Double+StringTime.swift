//
//  Double+StringTime.swift
//  UnderTheWeather
//
//  Created by Jonah Kuria on 2017/06/06.
//  Copyright © 2017 Jonah Kuria. All rights reserved.
//

import Foundation

extension Double {
  func dateStringFromTime() -> String {
    let date = Date(timeIntervalSince1970: self)
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEE dd MMM"
    dateFormatter.locale = Locale(identifier: "en_ZA")
    
    return dateFormatter.string(from: date)
  }
  
  func dayStringFromTime() -> String {
    let date = Date(timeIntervalSince1970: self)
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEE"
    dateFormatter.locale = Locale(identifier: "en_ZA")
    
    return dateFormatter.string(from: date)
  }
}
