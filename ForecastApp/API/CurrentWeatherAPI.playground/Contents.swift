import UIKit
import CoreLocation

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

enum ApiError: Error {
    case unKnown
    case invalidUrl(String)
    case invalidResponse
    case failed(Int)
    case emptyData
}

func fetch<PasingType: Codable>(urlStr: String, completion: @escaping (Result<PasingType, Error>) -> ()) {
    guard let url = URL(string: urlStr) else {
        //fatalError("URL 생성 실패")
        completion(.failure(ApiError.invalidUrl(urlStr)))
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) {
        (data, response, error) in
        if let error = error {
            //fatalError(error.localizedDescription)
            completion(.failure(error))
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            //fatalError("invalid response")
            completion(.failure(ApiError.invalidResponse))
            return
        }
        
        guard httpResponse.statusCode == 200 else {
            //fatalError("falied code \(httpResponse.statusCode)")
            completion(.failure(ApiError.failed(httpResponse.statusCode)))
            return
        }
        
        guard let data = data else {
            //fatalError("empty data")
            completion(.failure(ApiError.emptyData))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(PasingType.self, from: data)
            completion(.success(data))
            
        }catch {
            //print(error)
            //fatalError(error.localizedDescription)
        }
    }
    task.resume()
}

func fetchCurrentWeather(cityName: String, completion: @escaping (Result<CurrentWeather, Error>) -> ()){
    let urlStr = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=a5ba5bb0a39b7c371d4265f85c848b36&units=metric&lang=kr"
    fetch(urlStr: urlStr, completion: completion)
    
}

func fetchCurrentWeather(cityId: Int, completion: @escaping (Result<CurrentWeather, Error>) -> ()){
    let urlStr = "https://api.openweathermap.org/data/2.5/weather?id=\(cityId)&appid=a5ba5bb0a39b7c371d4265f85c848b36&units=metric&lang=kr"
    fetch(urlStr: urlStr, completion: completion)
    
}

func fetchCurrentWeather(location: CLLocation, completion: @escaping (Result<CurrentWeather, Error>) -> ()){
    let urlStr = "https://api.openweathermap.org/data/2.5/weather?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=a5ba5bb0a39b7c371d4265f85c848b36&units=metric&lang=kr"
    fetch(urlStr: urlStr, completion: completion)
    
}

let location = CLLocation(latitude: 37.498206, longitude: 127.02761)
fetchCurrentWeather(location: location) { (result) in
    switch result {
        case .success(let weather):
            dump(weather)
        case .failure(let error):
            print(error)
        }
}

//fetchCurrentWeather(cityId: 1835847) { (result) in
//    switch result {
//    case .success(let weather):
//        dump(weather)
//    case .failure(let error):
//        print(error)
//    }
//}
