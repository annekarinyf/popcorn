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
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(frame: .zero)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: makeShowsViewController())
        window?.windowScene = windowScene
    }
    
    private func makeShowsViewController() -> ShowsViewController {
        let httpClient = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
        let url = URL(string: "https://api.tvmaze.com/shows?page=1")!
        let showLoader = RemoteShowLoader(client: httpClient, url: url)
        let imageLoader = ImageLoader(client: httpClient)
        return ShowsUIComposer.showsComposed(with: showLoader, imageLoader: imageLoader)
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}

