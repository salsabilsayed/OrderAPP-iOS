//
//  MenuController.swift
//  OrderApp
//
//  Created by ifts 25 on 16/03/23.
//

import Foundation
import UIKit


class MenuController {
    
    static var shared = MenuController()
    
    static let orderUpdatedNotification =
       Notification.Name("MenuController.orderUpdated") 
    
    var order = Order() {
        didSet {
            NotificationCenter.default.post(name: MenuController.orderUpdatedNotification, object: nil)
        }
    }

    
    let baseURL = URL(string: "http://localhost:8080/")
    
    typealias MinutesToPrepare = Int
    
    func fetchCategories(completion: @escaping (Result<[String], Error>) -> Void) {
        guard let categoriesURL = baseURL?.appending(path: "categories") else { return }
        let task = URLSession.shared.dataTask(with: categoriesURL) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let categoriesResponse = try decoder.decode(CategoriesResponse.self, from: data)
                    completion(.success(categoriesResponse.categories))
                }catch {
                    completion(.failure(error))
                }
            }else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    func fetchMenuItems(forCategory categoryName:String, completion: @escaping (Result<[MenuItem], Error>) -> Void){
        guard let baseMenuUrl = baseURL?.appending(component: "menu") else { return }
        var components = URLComponents(url: baseMenuUrl, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        let menuUrl = components.url
        
        let task = URLSession.shared.dataTask(with: menuUrl!) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    if let menuItemsResponse = try? decoder.decode(MenuResponse.self, from: data) {
                        completion(.success(menuItemsResponse.items))
                    }
                } catch {
                    completion(.failure(error))
                }
                
            }else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    
    func submitOrder(forMenuIDs menuIDs:[Int],completion: @escaping (Result<MinutesToPrepare, Error>) -> Void){
        guard let orderURL = baseURL?.appending(path: "order") else { return }
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let data = ["menuIds": menuIDs]
        let encoder = JSONEncoder()
        let jsonData = try? encoder.encode(data)
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let orderResponse = try? decoder.decode(OrderResponse.self, from: data)
                    completion(.success(orderResponse!.prepTime))
                }catch {
                    completion(.failure(error))
                }
            }else if let error = error {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    
    func fetchImage(url: URL, completion: @escaping (UIImage?)
       -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
}
