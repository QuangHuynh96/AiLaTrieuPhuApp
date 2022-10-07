//
//  HomeViewController.swift
//  GameProject
//
//  Created by HuynhLQ on 29/09/2022.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet var mainView: UIView?
    @IBOutlet weak var iconImage: UIView?
    @IBOutlet weak var topPoint: UIButton?
    @IBOutlet weak var guideBtn: UIButton?
    @IBOutlet weak var unMuteBtn: UIButton?
    @IBOutlet weak var muteBtn: UIButton?
    @IBOutlet weak var playBtn: UIButton?
    private var mute = false

    override func viewDidLoad() {
        super.viewDidLoad()
        unDisplay()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.mainView?.alpha = 1
        changeSoundApp()
        actionShowView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            self.mainView?.alpha = 0
        }, completion: nil)
    }

    @IBAction func onTapPlay(_ sender: Any) {
        let playVC = PlayViewController()
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            self.iconImage?.transform = CGAffineTransform(scaleX: 5, y: 5)
            self.unDisplay()
        }, completion: { _ in
            self.navigationController?.pushViewController(playVC, animated: false)
            self.iconImage?.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }

    @IBAction func onTapUnMuteBtn(_ sender: Any) {
        changeSoundApp()
    }

    @IBAction func onTapMuteBtn(_ sender: Any) {
        changeSoundApp()
    }
}

extension HomeViewController {

    func changeSoundApp() {
        mute = !mute
        if mute {
            unMuteBtn?.isHidden = true
            muteBtn?.isHidden = false
        } else {
                unMuteBtn?.isHidden = false
                muteBtn?.isHidden = true
        }
    }

    private func unDisplay() {
        playBtn?.alpha = 0
        topPoint?.alpha = 0
        guideBtn?.alpha = 0
        iconImage?.alpha = 0
        playBtn?.transform = CGAffineTransform(translationX: 100, y: 0)
        topPoint?.transform = CGAffineTransform(translationX: -100, y: 0)
        guideBtn?.transform = CGAffineTransform(translationX: 100, y: 0)
    }

    private func actionShowView() {
        self.mainView?.alpha = 1
        UIView.animate(withDuration: 0.7, delay: 0.2, options: .curveLinear, animations: {
            self.iconImage?.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
            self.iconImage?.alpha = 1
        }, completion: {_ in
            UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
                self.iconImage?.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.disPlayLine()
            }, completion: nil)
        })
    }

    private func disPlayLine() {
        self.playBtn?.alpha = 1
        self.topPoint?.alpha = 1
        self.guideBtn?.alpha = 1
        self.playBtn?.transform = CGAffineTransform(translationX: 0, y: 0)
        self.topPoint?.transform = CGAffineTransform(translationX: 0, y: 0)
        self.guideBtn?.transform = CGAffineTransform(translationX: 0, y: 0)
    }

}
