//
//  WeatherViewController.swift
//  UnderTheWeather
//
//  Created by Jonah Kuria on 2017/06/06.
//  Copyright © 2017 Jonah Kuria. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {

  // MARK: - Outlets
  @IBOutlet weak var currentDateLabel: UILabel!
  @IBOutlet weak var currentWeatherImageView: UIImageView!
  @IBOutlet weak var currentWeatherTemperatureLabel: UILabel!
  @IBOutlet weak var currentWeatherHighLowLabel: UILabel!
  @IBOutlet weak var currentWeatherDescriptionLabel: UILabel!
  @IBOutlet weak var currentLocationLabel: UILabel!

  @IBOutlet weak var dayOneForecastNameLabel: UILabel!
  @IBOutlet weak var dayTwoForecastNameLabel: UILabel!
  @IBOutlet weak var dayThreeForecastNameLabel: UILabel!
  @IBOutlet weak var dayFourForecastNameLabel: UILabel!
  @IBOutlet weak var dayFiveForecastNameLabel: UILabel!

  @IBOutlet weak var dayOneForecastWeatherImageView: UIImageView!
  @IBOutlet weak var dayTwoForecastWeatherImageView: UIImageView!
  @IBOutlet weak var dayThreeForecastWeatherImageView: UIImageView!
  @IBOutlet weak var dayFourForecastWeatherImageView: UIImageView!
  @IBOutlet weak var dayFiveForecastWeatherImageView: UIImageView!

  @IBOutlet weak var dayOneForecastHighLowLabel: UILabel!
  @IBOutlet weak var dayTwoForecastHighLowLabel: UILabel!
  @IBOutlet weak var dayThreeForecastHighLowLabel: UILabel!
  @IBOutlet weak var dayFourForecastHighLowLabel: UILabel!
  @IBOutlet weak var dayFiveForecastHighLowLabel: UILabel!

  @IBOutlet weak var separatorView: UIView!

  var weatherService: WeatherService!
  let locationManager = CLLocationManager()
  var currentLocation: CLLocation!
  var weatherCondition: WeatherCondition!

  override func viewDidLoad() {
    super.viewDidLoad()
    setBlurBackground()
    separatorView.alpha = 0.65

    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()

    weatherService = WeatherService()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    locationAuthStatus()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return UIStatusBarStyle.lightContent
  }

  func setBlurBackground() {
    let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
    backgroundImageView.image = UIImage.init(named: "joburg.jpeg")
    backgroundImageView.contentMode = .scaleAspectFill
    self.view.addSubview(backgroundImageView)
    self.view.sendSubview(toBack: backgroundImageView)

    let blurEffect = UIBlurEffect(style: .dark)
    let blurEffectView = UIVisualEffectView(effect: blurEffect)
    blurEffectView.frame = UIScreen.main.bounds

    backgroundImageView.addSubview(blurEffectView)
  }

  func locationAuthStatus() {
    if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
      currentLocation = locationManager.location
      Location.sharedInstance.latitude = currentLocation.coordinate.latitude
      Location.sharedInstance.longitude = currentLocation.coordinate.longitude
      weatherService.fetchCurrentWeather { weatherCondition in
        self.updateCurrentWeather(weatherCondition: weatherCondition)
        return
      }
      weatherService.fetchDailyForecastWeather { weatherConditions in
        self.updateForeCastWeather(weatherConditions: weatherConditions)
        return
      }
    } else {
      locationManager.requestWhenInUseAuthorization()
      locationAuthStatus()
    }
  }
  
  func updateCurrentWeather(weatherCondition: WeatherCondition) {
    self.currentDateLabel.text = "\(weatherCondition.date!)"
    self.currentWeatherTemperatureLabel.text = "\(weatherCondition.temperature!)°C"
    self.currentWeatherHighLowLabel.text = "\(weatherCondition.maxTemperature!) / \(weatherCondition.minTemperature!)"
    self.currentWeatherDescriptionLabel.text = "\(weatherCondition.description!)"
    let countryName = self.countryName(countryCode: weatherCondition.countryCode!)
    self.currentLocationLabel.text = "\(weatherCondition.locationName!), \(countryName!)"
    self.currentWeatherImageView.image = UIImage.init(named: weatherCondition.icon!)
  }
  
  func updateForeCastWeather(weatherConditions: Array<WeatherCondition>) {
    print(weatherConditions)
  }
  
  func countryName(countryCode: String) -> String? {
    let current = Locale(identifier: "en_US")
    return current.localizedString(forRegionCode: countryCode) ?? nil
  }
  
  // MARK: - CLLocationManagerDelegate
  func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
    let location = locations.last as! CLLocation
    
    Location.sharedInstance.latitude = location.coordinate.latitude
    Location.sharedInstance.latitude = location.coordinate.longitude
  }

}
