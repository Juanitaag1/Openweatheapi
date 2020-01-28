//
//  ViewController.swift
//  OpenWeatherApi
//
//  Created by juanita aguilar on 1/23/20.
//  Copyright © 2020 none. All rights reserved.
//
//We want the main.temp for the api
//Had to use this reference to open http url https://medium.com/@javedmultani16/transport-security-has-blocked-a-cleartext-http-in-ios-397f94b4ff88
import UIKit
import CoreTelephony

class ViewController: UIViewController {
//MARK: Properties
    var weather: Weather?
    
    let apiKey = "e9d54dc557259785058a0a8d0ed3a4f7"
    let DomainURL = "api.openweathermap.org/data/2.5/weather?q="
    //&APPID={APIKEY}
    var cityName = ""
    //check api it seems it is "country" under sys so sys.country
    var country = ""
    var temp = ""
    var humidity = ""
    //main is the object main.temp, main.humidity, sys.country, sys.id name is the cityName so might need to change to match
  
   
   // this line works when put in browser: api.openweathermap.org/data/2.5/weather?q=London&APPID=e9d54dc557259785058a0a8d0ed3a4f7"
    @IBOutlet weak var EnterCityTextField: UITextField!
    
    @IBOutlet weak var CityLabel: UILabel!
    
    @IBOutlet weak var TempLabel: UILabel!
    
    @IBOutlet weak var HumidityLabel: UILabel!
    
    //Purpose: to get the input from the textfield and put it in the url string to get the url of the webpage of the api info
    @IBAction func SubmitButton(_ sender: Any) {
       
        if let textInput = EnterCityTextField.text {
            //check if the user input a city and country code
            //separated by ,
            if textInput.contains(","){
                let array = textInput.components(separatedBy: ",")
                self.cityName = array[0]
                self.country = array[1]
                fetch(withName: self.cityName, withCountry: self.country)
            }else{
                self.cityName = textInput
                 fetch(withName: cityName)
            }
            
            
                      
            CityLabel.text = cityName + "'s Weather"
            getApipage()
            openApiWebPage(cityName: cityName)
            getCountryCode(countryCode: self.country)
            //Weather.fetch(withName: cityName)
           
            
            
        }
       
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // Read an User record from the server
    //@paragm withName:name,
//@param WithCountry: country
    func fetch(withName name: String, withCountry country: String){
        print(name)
         // var weather: Weather?
           let URLstring = "http://api.openweathermap.org/data/2.5/weather?q=\(name),\(country)&APPID=e9d54dc557259785058a0a8d0ed3a4f7"
        
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
                           self.temp = " Temperature: \(String(describing: myWeather.main!.temp))"
                           self.TempLabel.text = self.temp
                           self.humidity = "Humidity: \(String(describing: myWeather.main!.humidity))"
                           self.HumidityLabel.text = self.humidity
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
          
       }
    
    // Read an User record from the server
       func fetch(withName name: String){
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
                        self.temp = " Temperature: \(String(describing: myWeather.main!.temp))"
                        self.TempLabel.text = self.temp
                        self.humidity = "Humidity: \(String(describing: myWeather.main!.humidity))"
                        self.HumidityLabel.text = self.humidity
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
       
    }
    func getApipage(){
        let pathToApi = "http://api.openweathermap.org/data/2.5/weather?q=\(self.cityName)&APPID=\(self.apiKey)"
        
    }
    

    //Purpose: To open the Api webpage with the info of the cityName from this app
    //Precondtions: The user enters a city, presses the submit button and the user oks the alert to give permission to acces the webpage
    //Postcondition: An alert will pop up for the user to give permission and the Apiwebpage will open
    func openApiWebPage(cityName: String?) {
        
        if let name = cityName{
          let webURL = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(name)&APPID=\(self.apiKey)")!
            
       //  let webURL = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=London&APPID=e9d54dc557259785058a0a8d0ed3a4f7")!
        
          
        let application = UIApplication.shared
               application.open(webURL as URL)

       }
    }
    
    //purpose: to get the country code passed in and checks if it is in the array of valid country codes.
    func getCountryCode(countryCode: String?){
        if let code = countryCode{
    //get the isoContryCodes as an array of strings
            let codeArray = CFLocaleCopyISOCountryCodes() as! [String]
              // print(codeArray)
               //if the array contains the entered country code then do something withit
            if codeArray.contains(code) == true{
                //Do something with the code
                   print("EXists \(code)")
               }
        }
    }
    
}

