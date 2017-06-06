//
//  WeatherService.swift
//  UnderTheWeather
//
//  Created by Jonah Kuria on 2017/06/06.
//  Copyright © 2017 Jonah Kuria. All rights reserved.
//

import Foundation
import CoreLocation

import Alamofire
import SwiftyJSON

class WeatherService {
  
  var baseURL: String { return "http://api.openweathermap.org/data/2.5/weather?" }
  var forecastBaseURL: String { return "http://api.openweathermap.org/data/2.5/forecast/daily?"}
  var apiKey: String { return "9028caa6d9796a4342ded97e4d9078c2" }
  var appID: String { return "&appid=\(apiKey)" }
  var lat: String { return "lat=\(Location.sharedInstance.latitude!)" }
  var lon: String { return "&lon=\(Location.sharedInstance.longitude!)" }
  var units: String { return "&units=metric"}
  var numOfDays: String { return "&cnt=6" }
  var modeJSON: String { return "&mode=json" }
  
  var currentWeatherURL: String { return baseURL + lat + lon + units + appID }
  var dailyForecastURL: String { return forecastBaseURL + lat + lon + numOfDays + modeJSON + units + appID }
  
}
