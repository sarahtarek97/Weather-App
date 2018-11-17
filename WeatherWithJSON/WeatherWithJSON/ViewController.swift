//
//  ViewController.swift
//  WeatherWithJSON
//
//  Created by Aboelnaga on 11/7/18.
//  Copyright © 2018 tamkeen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityBane: UITextField!
    @IBOutlet weak var showTime: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func findSunriseBtn(_ sender: UIButton) {
        let url = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22\(cityBane.text!)%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
        
        loadURL(url: url)
    }
    
    func loadURL(url: String){
        
        DispatchQueue.global().async {
          
        do{
            let appURL = URL(string: url)!
            let data = try Data(contentsOf: appURL)
            let json = try JSONSerialization.jsonObject(with: data) as! [String:Any]
            let query = json["query"] as! [String: Any]
            let results = query["results"] as! [String: Any]
            let channel = results["channel"] as! [String: Any]
            let astronomy = channel["astronomy"] as! [String: Any]
            
            DispatchQueue.main.async {
              
            self.showTime.text = "Sunrise time is \(astronomy["sunrise"]!)"
            }
            
            }catch{
                
                DispatchQueue.main.async {
                 
            self.showTime.text = "Can't catch the server"
                }
        }
        
    }
    }
    
}

