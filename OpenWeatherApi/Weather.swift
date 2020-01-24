//
//  Weather.swift
//  OpenWeatherApi
//
//  Created by juanita aguilar on 1/23/20.
//  Copyright © 2020 none. All rights reserved.
//

import Foundation
import UIKit

class Weather: Codable {
    //apiKey of the openweatherapp
     let APIKEY = "e9d54dc557259785058a0a8d0ed3a4f7"
    //name is the city name
    
      var name: String?
      //check api it seems it is "country" under sys so sys.country
    //all vars have to be the same type as api
      var id: Int?
      var main:Main?
      var sys: Sys?
      //main is the object main.temp, main.humidity, sys.country, sys.id name is the cityName so might need to change to match
    init(name: String?, id: Int, main:Main?, sys:Sys?) {
        self.name = name
        self.id = id
        self.main = main
        self.sys = sys
    }
    
    init(name: String?){
        self.name = name
    }
    // Read an User record from the server
   /*   static func fetch(withName name: String){
      // var weather: Weather?
        let URLstring = "http://api.openweathermap.org/data/2.5/weather?q=\(name)&APPID=e9d54dc557259785058a0a8d0ed3a4f7"
         if let url = URL.init(string: URLstring){
            let task = URLSession.shared.dataTask(with: url, completionHandler:
            {(dataFromAPI, response, error) in
                print(String.init(data:dataFromAPI!, encoding: .ascii) ?? "no data")
                if let myWeather = try? JSONDecoder().decode(Weather.self, from:  dataFromAPI!){
                    
                                        print(myWeather.name ?? "No name")
                                        print(myWeather.main ?? "No Main")
                                        print(myWeather.main?.humidity  ?? "No Main.humanity")
                                        print(myWeather.sys ?? "No Sys")
                                        print(myWeather.sys?.country  ?? "No sys.country")
                                        print(myWeather.id )
                    
                    DispatchQueue.main.async {
                       /* weather!.name = myWeather.name
                                          weather!.id = myWeather.id
                                          weather!.main = myWeather.main
                                          weather!.sys = myWeather.sys*/
                    }
                  
                 
                                    }
                
                                })
                                task.resume()
                 
            }
       // print( weather.name, weather.id, weather.main?.temp ?? "No Temp", weather.sys)
       
    }*/
    // Read an User record from the server
   /*  static func fetch(withID id:Int){
             let URLstring = DomainURL + "users/\(id)"
             if let url = URL.init(string: URLstring){
                 let task = URLSession.shared.dataTask(with: url, completionHandler:
                 {(dataFromAPI, response, error) in
                     print(String.init(data:dataFromAPI!, encoding: .ascii) ?? "no data")
                     if let myUser = try? JSONDecoder().decode(User.self, from:  dataFromAPI!){
                         print(myUser.FirstName ?? "No name")
                     }
                 })
                 task.resume()
             }
     }*/
    struct Main: Codable {
        let humidity: Int
        let temp: Double
    }
    struct Sys: Codable {
        let country: String?
       
    }
}
