//
//  Routes.swift
//  Clinic Project
//
//  Created by The Godfather Júnior on 13/12/24.
//

import Foundation
import UIKit
import SwiftUI

public enum Destination {
    case signIn
    case signUp
}

public class Routes {
    public let navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() { 
        navigate(to: .signIn, .push)
    }
    
    public enum TypeTransition: String {
        case push = "fromRight"
        case pop = "fromLeft"
    }
    
    public func navigate(to destination: Destination, _ type: TypeTransition = .push) {
        navigationController.viewControllers.removeAll()
        
        let transition = CATransition()
        transition.duration = 0.35
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .moveIn
        transition.subtype = CATransitionSubtype(rawValue: type.rawValue)
        
        navigationController.view.layer.add(transition, forKey: nil)
        
        switch destination {
        case .signIn:
            let view = createModule(viewType: SignIn_View.self)
            navigationController.pushViewController(view, animated: true)
            
        case .signUp:
            let view = createModule(viewType: SignUp_View.self)
            navigationController.pushViewController(view, animated: true)
        }
    }
    
    public func createModule<V: ViewProtocol>(viewType: V.Type) -> UIViewController
    where V.VM.T.P.VM == V.VM {
        
        var viewModel = V.VM.init()
        let presenter = V.VM.T.P.init(viewModel: viewModel)
        let interactor = V.VM.T.init(presenter: presenter)
        
        viewModel.interactor = interactor
        viewModel.router = self
        
        let view = V.init(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        
        return viewController
    }
}
