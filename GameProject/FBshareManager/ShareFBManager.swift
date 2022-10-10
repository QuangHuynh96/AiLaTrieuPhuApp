//
//  ShareFBManager.swift
//  GameProject
//
//  Created by HuynhLQ on 10/10/2022.
//

import UIKit
import FBSDKShareKit
class FBshareManager {
    static let shared = FBshareManager()
    func sharedFB(uiViewController: UIViewController, imageName: String) {
        guard let image = UIImage(named: "shareimage") else {
            return
        }
        let photo = SharePhoto(image: image, userGenerated: true)
        let content = SharePhotoContent()
        content.photos = [photo]
        let dialog = ShareDialog(fromViewController: uiViewController, content: content, delegate: nil)
        do {
            try dialog.validate()
        } catch {
            print("error dialog validate")
        }
        dialog.show()
    }
}
