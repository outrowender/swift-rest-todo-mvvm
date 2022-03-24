//
//  TasksApi.swift
//  Todo MVVM
//
//  Created by Wender Patrick on 24/03/22.
//

import Foundation

class TasksApi {
    
    // esse enum classifica os tipos de erros cobertos na requisção
    enum TasksApiError: Error {
        case decodingError, networkingError // confira linha 47
    }
    
    // Essa variável é a base da URL. Ela fica estática para poder ser concatenada com o caminho de cada recurso no servidor
    static private let server = URL(string: "http://localhost:3000")!
    
    static private let jsonDecoder = JSONDecoder()
    static private let jsonEncoder = JSONEncoder()
    
    /// Essa função lista todas as tasks.
    /// `GET /tasks`
    static func getTasks(completion: @escaping (Result <[TaskModel], TasksApiError>) -> Void) {
        
        // concatena o caminho do recurso com a URL inicial
        let url = server.appendingPathComponent("tasks")
        
        var request = URLRequest(url: url)
        // o método http é definido aqui
        request.httpMethod = "GET"
        
        // uma URLSession é iniciada com a URL montada
        let task = URLSession.shared.dataTask(with: request) {
            // esses 3 objetos retornam o estado da aplicação
            (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse {
                    // esse código é um exemplo para conferir o StatusCode da requisição
                    print("status code: \(httpResponse.statusCode)")
            }
            
            if error != nil {
                // a requisição só continua se não houver um erro.
                // caso um erro ocorra, o callback é chamado passando um erro como status
                completion(.failure(.networkingError))
                return
            }
            
            // o código tenta converter o resultado JSON em um objeto Swift `TaskModel`, que implementa o protocolo `Codable`
            if let data = data, let json = try? self.jsonDecoder.decode([TaskModel].self, from: data) {
                completion(.success(json)) // caso de sucesso da conversão
            } else {
                completion(.failure(.decodingError)) // caso a conversão falhe
            }
        }
        
        // força o continuação da task
        task.resume()
    }
    
    /// Essa função salva uma nova task.
    /// `POST /tasks`
    static func saveTask(task: TaskModel, completion: @escaping (Result <Void, TasksApiError>) -> Void) {
        let url = server.appendingPathComponent("tasks")
        
        // o objeto Swift `Task` é convertido para JSON para ser enviado para o servidor
        let data = try! self.jsonEncoder.encode(task)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // tipo POST é definido no método HTTP
        request.httpBody = data // o body da requisição é passado aqui
        request.addValue("application/json", forHTTPHeaderField: "Content-Type") // esse é um header http que identifica o tipo de body passado
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            if error != nil {
                completion(.failure(.networkingError))
            } else {
                completion(.success(())) // se a requisição for um sucesso, o callback é chamado com status de sucesso
            }
        }
        
        task.resume()
    }
    
    /// Essa função exclui uma task
    /// `DELETE /tasks/(id)`
    static func deleteTask(id: Int, completion: @escaping (Result <Void, TasksApiError>) -> Void) {
        let url = server.appendingPathComponent("tasks/\(id)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            
            if error != nil {
                completion(.failure(.networkingError))
            } else {
                completion(.success(()))
            }
        }
        
        task.resume()
    }
}
