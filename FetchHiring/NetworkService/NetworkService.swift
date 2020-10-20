//
//  NetworkService.swift
//  FetchHiring
//
//  Created by Nick Nguyen on 10/19/20.
//

import Foundation

final class NetworkService {

    private lazy var urlRequest: URLRequest = {
        let baseURL = URL(string: "https://fetch-hiring.s3.amazonaws.com/hiring.json")!
        let request = URLRequest(url: baseURL)
        return request
    }()


    func getItemsFromServer(completion: @escaping (Result<[Item],NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: self.urlRequest) { data, response, error in
            if let error = error as? NetworkError {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.isOK else {
                completion(.failure(.badResponse))
                return
            }
        
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let items = try JSONDecoder().decode([Item].self, from: data)
                completion(.success(items))
            } catch let error {
                NSLog(error.localizedDescription)
            }
        }.resume()
    }
}
