//
//  ViewController.swift
//  API-recap-swifty-json
//
//  Created by Chucky on 7/31/17.
//  Copyright © 2017 Chuck. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire


class ViewController: UIViewController {

    //create an array to store custom movie objects (see moview.swift file)
    var moviesArray = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
    }

    
    
    func getData() {
        
        //this url string pulls the top 25 movies from iTunes, this is a free API call and there is no need for an API key or developer account
        let urlString = "https://itunes.apple.com/us/rss/topmovies/limit=25/json"
        

        //the function belows fires an API request using Alamofire
        Alamofire.request(urlString).validate().responseJSON() { response in
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    
                    //after getting the response back, we convert it to a JSON struct using SwiftyJSON
                    let json = JSON(value)
                    print(json)

                    //get the movies list which is stored under "feed" and "entry"
                    let jsonArray = json["feed"]["entry"].arrayValue
                    //print(jsonArray[0]["im:name"]["label"])
                    
                    for item in jsonArray {
                        if let jsonTitle = item["im:name"]["label"].string,
                            let jsonPrice = item["im:price"]["label"].string {
                            
                            //print(jsonTitle + " " + jsonPrice)
                            let movie = Movie(title: jsonTitle, price: jsonPrice)
                            self.moviesArray.append(movie)
                            
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }

        
    }


}

