//
//  ViewController.swift
//  API-Recap
//
//  Created by Chucky on 7/30/17.
//  Copyright © 2017 Chuck. All rights reserved.
//

import UIKit


/*
 Note: in order to use API calls in your project, you need to first go to the Info.plist and add a property called "App Transport Security Settings". Expand the property and add a subcategory called "Allow Arbitrary Loads" and set the value from NO to "YES".
 
 */

class ViewController: UIViewController {
    
    //need to get an api key from openweathermap.org, sign up for a developer account
    var apiKey = "73b038e177f49d1d80ba169a22826ef6"
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData(city: "London")
    }
    
    
    func getData(city: String) {
        
        //setup the api call with the correct http request, need to go look at documentation for openweathermap.org
        //https://openweathermap.org/current
        let urlString = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&APPID=\(self.apiKey)")
        
        //setup a "URL session" that handles the data that comes back from the api call
        let task = URLSession.shared.dataTask(with: urlString!) { (data, response, error) in
            do {
                if let data = data,
                    
                    //translate the data into a JSON object
                    let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    print(json) //print the entire json object retrieved from the url string
                    
                    //the following code parses through the JSON object, you can experiment here and try to print and get different values from the JSON object
                    let main = json["main"] as! [String : Any]
                    print(main)
                    
                    let temp = main["temp"] as! Int
                    print(temp)
                    
                    //once you have collected the data you need, you can now update any UI objects on your view controller
                    DispatchQueue.main.async {
                        self.cityLabel.text = city
                        self.weatherLabel.text = String(temp) + " Celsius"
                    }
                    
                }
            } catch {
                print("Error deserializing JSON: \(error)")
            }
        }
        task.resume()
        
    }
    
    
    
}

