//
//  CongratulationViewController.swift
//  GameProject
//
//  Created by GST.DN on 06/10/2022.
//

import UIKit

class CongratulationViewController: UIViewController {

    @IBOutlet var bodyView: UIView?
    @IBOutlet var congratImage: UIImageView!
    @IBOutlet var congratLabel: UILabel!
    @IBOutlet var moneyView: UIView!
    @IBOutlet var homeButton: UIButton!
    @IBOutlet var shareButton: UIButton!
    @IBOutlet var infoLabel: UILabel!
    let moneyImage = UIImageView()
    var actionShareFb: () -> Void = {}
    var actionOnTapBack: () -> Void = {}
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        animateImage()
    }

    private func setupUI() {
        moneyImage.image = UIImage(named: "dollar")
        congratImage.alpha = 1
        moneyView.alpha = 0
        congratLabel.alpha = 0
        infoLabel.alpha = 0
        homeButton.alpha = 0
        shareButton.alpha = 0
    }

    private func animateImage() {
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
            self.congratImage.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            UIView.addKeyframe(withRelativeStartTime: 1, relativeDuration: 0.5, animations: {
                self.fallingMoney()
                self.moneyImage.alpha = 0
            })
        }, completion: {_ in
            UIView.animate(withDuration: 1, delay: 0.5, options: .curveEaseInOut, animations: {
                self.congratImage?.transform = CGAffineTransform(translationX: 0, y: 270)
            }, completion: {_ in
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
                    self.congratLabel.alpha = 1
                    self.infoLabel.alpha = 1
                }, completion: {_ in
                    UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseInOut, animations: {
                        self.moneyView.alpha = 1
                    }, completion: {_ in
                        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseInOut, animations: {
                            self.homeButton.alpha = 1
                            self.shareButton.alpha = 1
                        }, completion: nil)
                    })
                })
            })
        })
    }

    @IBAction func onTapBackHome(_ sender: Any) {
        actionOnTapBack()
    }

    @IBAction func onTapShare(_ sender: Any) {
        actionShareFb()
    }

    private func fallingMoney() {
        let size = UIScreen.main.bounds.width
        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterSize = CGSize(width: size/2, height: 1)
        emitterLayer.emitterPosition = CGPoint(x: size/2, y: 10)
        self.view.layer.addSublayer(emitterLayer)

        let cell = CAEmitterCell()
        cell.birthRate = 8
        cell.lifetime = 2
        cell.lifetimeRange = 2
        cell.velocity = 150
        cell.velocityRange = 20
        cell.emissionLongitude = CGFloat(Double.pi/2)
        cell.emissionRange = CGFloat(Double.pi*1.5)
        cell.spin = 0.5
        cell.spinRange = 0
        cell.contents = moneyImage.image?.cgImage

        emitterLayer.emitterCells = [cell]
    }
}
