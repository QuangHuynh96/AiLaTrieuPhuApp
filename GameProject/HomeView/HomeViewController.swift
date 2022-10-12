//
//  HomeViewController.swift
//  GameProject
//
//  Created by HuynhLQ on 29/09/2022.
//
import AVFoundation
import UIKit

class HomeViewController: UIViewController {
    @IBOutlet var mainView: UIView?
    @IBOutlet weak var iconImage: UIView?
    @IBOutlet weak var topPoint: UIButton?
    @IBOutlet weak var guideBtn: UIButton?
    @IBOutlet weak var unMuteBtn: UIButton?
    @IBOutlet weak var muteBtn: UIButton?
    @IBOutlet weak var playBtn: UIButton?
    var isMute = false
    var player: AVAudioPlayer?

    override var shouldAutorotate: Bool {
        return false
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.portrait]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        unDisplay()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        changeSoundApp()
        player?.stop()
        homeSoundBackground(resource: "home", type: "mp3")
        self.mainView?.alpha = 1
        actionShowView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            self.mainView?.alpha = 0
        }, completion: nil)
    }

    @IBAction func onTapPlay(_ sender: Any) {
        let alertCustom = CustomAlertViewController()
        alertCustom.setupAlert(
            title: "Bạn đã sẵn sàn",
            mess: "Hãy giữ kết nối online ổn định. Chúng ta bắt đầu đi tìm. Ai là triệu phú!!",
            leftTitle: "Quay lại",
            rightTitle: "Chơi")
        alertCustom.actionClosureLeft = {[weak self] in
            self?.dismiss(animated: true)
        }
        alertCustom.actionClosureRight = {[weak self] in
            self?.dismiss(animated: true)
            guard let mute = self?.isMute else {
                return
            }
            let playVC = PlayViewController()
            playVC.isMute = mute
            UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
                self?.iconImage?.transform = CGAffineTransform(scaleX: 5, y: 5)
                self?.unDisplay()
            }, completion: { _ in
                self?.navigationController?.pushViewController(playVC, animated: false)
                self?.iconImage?.transform = CGAffineTransform(scaleX: 1, y: 1)
                self?.player?.stop()
            })
        }
        alertCustom.modalPresentationStyle = .overCurrentContext
        alertCustom.modalTransitionStyle = .crossDissolve
        alertCustom.providesPresentationContextTransitionStyle = true
        alertCustom.definesPresentationContext = true
        self.present(alertCustom, animated: true)
    }

    @IBAction func onTapUnMuteBtn(_ sender: Any) {
        isMute = !isMute
        changeSoundApp()
    }

    @IBAction func onTapMuteBtn(_ sender: Any) {
        isMute = !isMute
        changeSoundApp()
    }

    @IBAction func onTapHighScoreBtn(_ sender: Any) {
        player?.stop()
        homeSoundBackground(resource: "childView", type: "mp3")
        if !isMute {
            player?.play()
        }
        let scoreView = ScoreViewController()
        navigationController?.pushViewController(scoreView, animated: true)
    }

    @IBAction func onTapRulesBtn(_ sender: Any) {
        player?.stop()
        homeSoundBackground(resource: "childView", type: "mp3")
        if !isMute {
            player?.play()
        }
        let ruleView = RulesViewController()
        navigationController?.pushViewController(ruleView, animated: true)
    }
}

extension HomeViewController {

    func changeSoundApp() {
        if isMute {
            muteButtonIsHiden()
            player?.volume = 0
        } else {
            muteButtonUnHiden()
            player?.volume = 0.8
        }
    }

    func muteButtonIsHiden() {
        UIView.animate(
            withDuration: 0.25,
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                self.unMuteBtn?.alpha = 1
                self.muteBtn?.alpha = 0
        }, completion: { [weak self] _ in
            self?.unMuteBtn?.isHidden = false
            self?.muteBtn?.isHidden = true
        })
    }

    func muteButtonUnHiden() {
        UIView.animate(
            withDuration: 0.25,
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                self.muteBtn?.alpha = 1
                self.unMuteBtn?.alpha = 0
        }, completion: { [weak self] _ in
            self?.muteBtn?.isHidden = false
            self?.unMuteBtn?.isHidden = true
        })
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
        UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveLinear, animations: {
            self.iconImage?.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
            self.iconImage?.alpha = 1
        }, completion: {_ in
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
                self.iconImage?.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.disPlayLine()
                self.player?.play()
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

extension HomeViewController {

    func homeSoundBackground(resource: String, type: String) {
        if let player = player,
           player.isPlaying {
            player.pause()
        } else {
            let urlString = Bundle.main.path(forResource: resource, ofType: type)
            do {
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)

                guard let urlString = urlString else {
                    return
                }
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            } catch {
                print("error")
            }
        }
    }
}
