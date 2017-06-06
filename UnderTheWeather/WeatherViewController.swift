//
//  WeatherViewController.swift
//  UnderTheWeather
//
//  Created by Jonah Kuria on 2017/06/06.
//  Copyright © 2017 Jonah Kuria. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    setBlurBackground()
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
