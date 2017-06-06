//
//  WeatherViewController.swift
//  UnderTheWeather
//
//  Created by Jonah Kuria on 2017/06/06.
//  Copyright © 2017 Jonah Kuria. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
  
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

  override func viewDidLoad() {
    super.viewDidLoad()
    setBlurBackground()
    separatorView.alpha = 0.65
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

}
