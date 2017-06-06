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
  
  // fetch current weather
  func fetchCurrentWeather(completed: @escaping (_ weatherCondition: WeatherCondition) -> Void) {
    Alamofire.request(currentWeatherURL).responseJSON { response in
      if let responseDictionary = response.result.value {
        let responseJSON = JSON(responseDictionary)
        print("****** Response *******: \(responseJSON)")
        completed(_: self.currentWeatherFromJSON(json: responseJSON))
      } else {
        print("Error!")
      }
    }
  }
  
  // fetch five day forecast
  func fetchDailyForecastWeather(completed: @escaping (_ weatherConditions: Array<WeatherCondition>) -> Void) {
    Alamofire.request(dailyForecastURL).responseJSON { response in
      if let responseDictionary = response.result.value {
        let responseJSON = JSON(responseDictionary)
        print("****** Response Forecast *******: \(responseJSON["list"])")
        let jsonList: Array<JSON> = responseJSON["list"].arrayValue
        let weatherConditions: Array<WeatherCondition> = jsonList.map() {
          return self.dailyForecastFromJSON(json: $0)
        }
        let count = weatherConditions.count
        let dailyForecastExcludingToday = Array(weatherConditions[1..<count])
        completed(_ : dailyForecastExcludingToday)
      } else {
        print("Error!")
      }
      
    }
  }
}

private extension WeatherService {
  func currentWeatherFromJSON(json: JSON) -> WeatherCondition{
    let name = json["name"].string
    let description = json["weather"][0]["description"].stringValue
    let minTemp = json["main"]["temp_min"].doubleValue.roundToInt()
    let maxTemp = json["main"]["temp_max"].doubleValue.roundToInt()
    let temp = json["main"]["temp"].doubleValue.roundToInt()
    let icon = json["weather"][0]["icon"].stringValue
    let date = json["dt"].doubleValue.dateStringFromTime()
    let code = json["sys"]["country"].stringValue
    
    
    return WeatherCondition(
      locationName: name,
      description: description,
      minTemperature: minTemp,
      maxTemperature: maxTemp,
      temperature: temp,
      icon: icon,
      date: date,
      countryCode: code
    )
  }
  
  func dailyForecastFromJSON(json: JSON) -> WeatherCondition {
    let name = ""
    let countryCode = ""
    let description = json["weather"][0]["description"].stringValue
    let minTemp = json["temp"]["min"].doubleValue.roundToInt()
    let maxTemp = json["temp"]["max"].doubleValue.roundToInt()
    let temp = json["temp"]["day"].doubleValue.roundToInt()
    let icon = json["weather"][0]["icon"].stringValue
    let date = json["dt"].doubleValue.dayStringFromTime()
    
    return WeatherCondition(
      locationName: name,
      description: description,
      minTemperature: minTemp,
      maxTemperature: maxTemp,
      temperature: temp,
      icon: icon,
      date: date,
      countryCode: countryCode
    )
  }
}
