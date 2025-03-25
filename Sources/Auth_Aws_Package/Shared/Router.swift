//
//  Routes.swift
//  Clinic Project
//
//  Created by The Godfather Júnior on 13/12/24.
//

import Foundation
import UIKit
import SwiftUI
import ViewProtocol_Package

public enum Destination {
    case signIn
    case signUp
}

@MainActor
public class Router: @preconcurrency RoutesProtocol{
    
    public let navigationController: UINavigationController
    
    required public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() { 
        navigate(to: .signIn, .push)
    }
    
    public func popToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
    
    public enum TypeTransition: String {
        case push = "fromRight"
        case pop = "fromLeft"
    }
    
    public func navigate(to destination: Destination, _ type: TypeTransition = .push) {
//        navigationController.viewControllers.removeAll()
        
        let transition = CATransition()
        transition.duration = 0.35
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .moveIn
        transition.subtype = CATransitionSubtype(rawValue: type.rawValue)
        
        navigationController.view.layer.add(transition, forKey: nil)
        
        switch destination {
        case .signIn:
            let view = createModule(viewType: SignIn_View.self, router: self)
            navigationController.pushViewController(view, animated: true)
            
        case .signUp:
            let view = createModule(viewType: SignUp_View.self, router: self)
            navigationController.pushViewController(view, animated: true)
        }
    }
    
    public func createModule<V, R>(viewType: V.Type, router: R) -> UIViewController where V : ViewProtocol_Package.ViewProtocol, R == V.VM.R, V.VM == V.VM.I.P.VM {
        var viewModel = V.VM.init()
        let presenter = V.VM.I.P.init(viewModel: viewModel)
        let interactor = V.VM.I.init(presenter: presenter)
        
        viewModel.interactor = interactor
        viewModel.router = self as? R
        
        let view = V.init(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)
        
        return viewController
    }

}
