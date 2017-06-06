//
//  Double+RoundToInt.swift
//  UnderTheWeather
//
//  Created by Jonah Kuria on 2017/06/06.
//  Copyright © 2017 Jonah Kuria. All rights reserved.
//

import Foundation

extension Double {
  func roundToInt() -> Int{
    return Int(self.rounded())
  }
}
