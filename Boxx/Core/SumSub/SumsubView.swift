//
//  SumsubVC.swift
//  sumsub test
//
//  Created by Nikita Evdokimov on 27.04.24.
//

import UIKit
import IdensicMobileSDK
import SwiftUI

struct SumsubView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController {
        let viewController = ViewController()
        viewController.startIdentify()
//        viewController.view.backgroundColor = .green
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        // Обновление контроллера, если это необходимо
    }
}


