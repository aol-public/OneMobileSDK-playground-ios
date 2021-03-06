//  Copyright © 2017 Oath. All rights reserved.

import UIKit
import OneMobileSDK
import PlayerControls

class ViewController: UIViewController {

    var oneSdk: Future<Result<One.SDK>> = {
        var provider = OneSDK.Provider.default
        return provider.getSDK()
    }()
    
    @IBAction func playButtonTouched(_ sender: Any) {
        oneSdk
            .then { $0.getPlayer(videoID: "577cc23d50954952cc56bc47") }
            .dispatch(on: .main)
            .onSuccess { player in
                let playerViewController = PlayerViewController()
                playerViewController.contentControlsViewController = DefaultControlsViewController()
                playerViewController.player = player
                self.navigationController?.pushViewController(playerViewController, animated: true)
            }
            .onError { error in
                let alert = UIAlertController(title: "Error",
                                              message: "\(error)",
                    preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK",
                                              style: .default,
                                              handler: nil))
                self.present(alert, animated: true, completion: nil)
        }
    }
}

