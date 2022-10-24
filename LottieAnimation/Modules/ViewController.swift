//
//  ViewController.swift
//  LottieAnimation
//
//  Created by Rustem Manafov on 24.10.22.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    
    var animationView: AnimationView?

    override func viewDidLoad() {
        super.viewDidLoad()

        //animationView = .init(name: "coffee")
        animationView = .init(name: "empty")
        animationView?.frame = view.bounds
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 0.5
        view?.addSubview(animationView!)
        animationView?.play()
        view.sendSubviewToBack(animationView!)
    }
    @IBAction func openDownload(_ sender: Any) {
        let viewController = DownloadViewController(nibName: "DownloadViewController", bundle: nil)
        present(viewController, animated: true)
    }
    

}

