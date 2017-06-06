//
//  Location.swift
//  UnderTheWeather
//
//  Created by Jonah Kuria on 2017/06/06.
//  Copyright © 2017 Jonah Kuria. All rights reserved.
//

import Foundation

class Location {
  static var sharedInstance = Location()
  private init() {}
  
  var latitude: Double!
  var longitude: Double!
}
