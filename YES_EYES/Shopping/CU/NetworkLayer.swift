////
////  NetworkLayer.swift
////  YES_EYES
////
////  Created by mgpark on 2021/08/15.
////
//
//import Foundation
//
//enum CUAPIType{
//    case justURL(urlString: String)
//    case searchCU(querys: [URLQueryItem])
//}
//
//enum CUAPIError: Error{
//    case badURL
//}
//
//class NetworkLayer{
//    // only url
//    // url + param
//
//    typealias NetworkCompletion = (_ data: Data?, _ response: URLResponse?, _ error:Error?) -> Void
//
//    func request(type: CUAPIType, completion: @escaping NetworkCompletion) {
//
//        let sessionConfig = URLSessionConfiguration.default
//        let session = URLSession(configuration: sessionConfig)
//
//        do{
//            let request = try buildRequest(type: type)
//
//            session.dataTask(with: request) { data, response, error in
//                print((response as! HTTPURLResponse).statusCode)
//
//                completion(data, response, error)
//
//            }.resume()
//            session.finishTasksAndInvalidate()
//
//        }catch{
//            print(error)
//        }
//    }
//
//    private func buildRequest(type: CUAPIType) throws -> URLRequest{
//        switch type {
//        case .justURL(urlString: let urlString):
//
//                guard let hasURL = URL(string: urlString) else{
//                    throw CUAPIError.badURL
//                }
//
//                var request = URLRequest(url: hasURL)
//                request.httpMethod = "GET"
//                return request
//
//        case .searchCU(querys: let querys):
//            var components = URLComponents(string: "")
//
//            components?.queryItems = querys
//
//            guard let hasUrl = components?.url else{
//                throw CUAPIError.badURL
//            }
//
//            var request = URLRequest(url: hasUrl)
//            request.httpMethod = "GET" //or "POST"
//            return request
//
//        }
//    }
//}
