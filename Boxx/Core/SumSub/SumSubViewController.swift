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
    
    let backend : YourBackendProtocol?
    var user : User?
    
    
    init(backend: YourBackendProtocol, user: User = User.TEST_USER) {
        self.backend = backend
        self.user = user
        super.init(nibName: nil, bundle: nil)
        
        print("VC USER: \(user.id) \(user.login)\n")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackButton()
        addMainButton()
    }
    
    func addBackButton() {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "multiply.circle"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(dissmissVC), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    func addMainButton() {
        let button = UIButton(type: .system)
        button.setTitle("Пройти верификацию", for: .normal)
        button.setTitleColor(.black, for: .normal) // Установка черного цвета текста
        button.backgroundColor = .white // Установка белого цвета фона
        button.layer.cornerRadius = 8 // Настройка скругления углов, если необходимо
        button.layer.borderWidth = 1 // Установка толщины рамки
        button.layer.borderColor = UIColor.black.cgColor // Установка черного цвета рамки
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(button)
        
        // Устанавливаем размер и положение кнопки
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.center = view.center
        
        // Добавляем кнопку на экран
        view.addSubview(button)
    }
    
    
    @objc func buttonTapped() {
        startIdentify()
    }
    
    @objc func dissmissVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func startIdentify() {
        IdentityVerification.launch(
            from: self,
            for: user,
            locale: "ru"
        )
    }
}
