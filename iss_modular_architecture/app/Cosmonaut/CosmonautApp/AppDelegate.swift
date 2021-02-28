//
//  AppDelegate.swift
//  Cosmonaut
//
//  Created by Cyril Cermak on 04.01.21.
//

import UIKit
import ISSScaffold
import ISSCosmonaut
import ISSCosmonautService
import ISSRadio

struct CosmonautConfiguration {
    lazy var appCoordinator: AppCoordinator.Configuration = {
        return AppCoordinator.Configuration(style: .navigation,
                                            menuCoordinator: nil)
    }()
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow? = UIWindow()
    
    private var configuration = CosmonautConfiguration()
    
    private lazy var appCoordinator: AppCoordinator = {
        return AppCoordinator(window: window!,
                              configuration: configuration.appCoordinator)
    }()
    
    private lazy var radioService = RadioService()
    
    private lazy var cosmonautService: CosmonautHealthServicing = {
        return CosmonautService(radio: radioService)
    }()
    
    private lazy var cosmonautCoordinator: CosmonautCoordinator = {
        return CosmonautCoordinator(cosmonautHealthService: cosmonautService)
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        appCoordinator.childCoordinators = [
            cosmonautCoordinator
        ]
        
        appCoordinator.start()
        return true
    }

}

