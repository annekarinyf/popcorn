//
//  SceneDelegate.swift
//  Popcorn
//
//  Created by Anne on 08/12/22.
//

import PopcornCore
import PopcorniOS
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private let url = URL(string: "https://api.tvmaze.com/shows?page=1")
    
    private lazy var httpClient: URLSessionHTTPClient = {
        URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    }()
    
    private lazy var showLoader: RemoteShowLoader = {
        RemoteShowLoader(client: httpClient, url: url!)
    }()
    
    private lazy var imageLoader: ImageLoader = {
        ImageLoader(client: httpClient)
    }()
    
    let composer = ShowsUIComposer()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(frame: .zero)
        window?.makeKeyAndVisible()
        let showsViewController = composer.showsComposed(with: showLoader, imageLoader: imageLoader)
        window?.rootViewController = UINavigationController(rootViewController: showsViewController)
        window?.windowScene = windowScene
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}

