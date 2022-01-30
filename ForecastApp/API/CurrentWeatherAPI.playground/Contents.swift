import UIKit

struct CurrentWeather: Codable {
    let dt: Int
    
    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    let weather: [Weather]
    
    struct Main: Codable {
        let temp: Double
        let temp_min: Double
        let temp_max: Double
        
    }
    
    let main: Main
}

func fetchCurrentWeather(cityName: String){
    let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=a5ba5bb0a39b7c371d4265f85c848b36&units=metric&lang=kr"
    
    guard let url = URL(string: urlString) else {
        fatalError("URL 생성 실패")
    }
    
    let task = URLSession.shared.dataTask(with: url) {
        (data, response, error) in
        if let error = error {
            fatalError(error.localizedDescription)
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            fatalError("invalid response")
        }
        
        guard httpResponse.statusCode == 200 else {
            fatalError("falied code \(httpResponse.statusCode)")
        }
        
        guard let data = data else {
            fatalError("empty data")
        }
        
        do {
            let decoder = JSONDecoder()
            let weather = try decoder.decode(CurrentWeather.self, from: data)
            
            weather.weather.first?.description
            weather.main.temp.description
        }catch {
            print(error)
            fatalError(error.localizedDescription)
        }
    }
    task.resume()
}


fetchCurrentWeather(cityName: "seoul")
