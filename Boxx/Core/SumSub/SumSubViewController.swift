//
//  ViewController.swift
//  sumsub test_UIKIT
//
//  Created by Namerei on 28.04.24.
//

import UIKit
import IdensicMobileSDK
import CryptoKit
import CommonCrypto

class ViewController: UIViewController {
    
    let backend = YourBackend()
//    var user = YourUser(userId: UUID().uuidString)
    var user = YourUser(userId: UUID().uuidString)
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .yellow
        
//        startIdentify()
        // Создаем кнопку
        let button = UIButton(type: .system)
        button.setTitle("Нажми меня", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        // Устанавливаем размер и положение кнопки
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.center = view.center
        
        // Добавляем кнопку на экран
        view.addSubview(button)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        startIdentify()
//    }
    
    @objc func buttonTapped() {
        startIdentify()
    }
    
    func startIdentify() {
        IdentityVerification.launch(
            from: self,
            for: user,
            locale: "ru"
        )
        delete()
    }
    
    func delete() {
        let applicantId = "663002dd9eb638554e1fda78"

        let urlString = "https://api.sumsub.com/resources/applicants/\(applicantId)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer your_access_token", forHTTPHeaderField: "Authorization") // Замените your_access_token на ваш реальный токен аутентификации Sumsub

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Response status code: \(response.statusCode)")
            }
        }

        task.resume()
    }
}
