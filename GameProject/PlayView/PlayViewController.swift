// swiftlint:disable file_length
//  PlayViewController.swift
//  GameProject
//
//  Created by HuynhLQ on 02/10/2022.
//

import UIKit
import AVFAudio

class PlayViewController: UIViewController {
// View animation
    @IBOutlet var mainView: UIView?
    @IBOutlet weak var questionView: UIView?
    @IBOutlet weak var spView: UIView?
// Pass Data
    @IBOutlet weak var pointView: UIButton?
    @IBOutlet weak var titleQuestionView: UILabel?
    @IBOutlet weak var contentQuestionView: UITextView?
    @IBOutlet weak var clockView: UIButton?
    @IBOutlet weak var aAnswerView: UIButton?
    @IBOutlet weak var bAnswerView: UIButton?
    @IBOutlet weak var cAnswerView: UIButton?
    @IBOutlet weak var dAnswerView: UIButton?
// View answers
    @IBOutlet weak var aView: UIView?
    @IBOutlet weak var bView: UIView?
    @IBOutlet weak var cView: UIView?
    @IBOutlet weak var dView: UIView?
// view support
    @IBOutlet weak var imageSpView1: UIImageView?
    @IBOutlet weak var imageSpView2: UIImageView?
    @IBOutlet weak var imageSpView3: UIImageView?
    @IBOutlet weak var fiveSpButton: UIButton?
    @IBOutlet weak var callSpbutton: UIButton?
    @IBOutlet weak var ataSpButton: UIButton?
// view other
    weak var timer: Timer?
    var playerBackground: AVAudioPlayer?
    var playerAction: AVAudioPlayer?
    var playerActionUseSupport: AVAudioPlayer?
    var colorAnswerBtn: CGColor?
    var sceneHeight: CGFloat = 0
    var sceneWidth: CGFloat = 0
    var isMute = false
    var checkSelected: Bool = false
    var timeCount = 0
    var answerCount = 1
    var scores: Int = 0
    var correctAnswer = ""
    var finalAnswer = ""
    var aAnswerValue = ""
    var bAnswerValue = ""
    var cAnswerValue = ""
    var dAnswerValue = ""
    let rewards: [Int] = [
        200000, 400000, 600000, 1000000, 2000000,
        3000000, 6000000, 10000000, 14000000, 22000000,
        30000000, 40000000, 60000000, 85000000, 150000000
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setTimer()
        displayView()
        checkIsMute()
        colorAnswerBtn = aView?.backgroundColor?.cgColor ?? CGColor(gray: 0, alpha: 0)
        sceneWidth = view.frame.size.width
        sceneHeight = view.frame.size.height
        imageSpView1?.isHidden = true
        imageSpView2?.isHidden = true
        imageSpView3?.isHidden = true
        contentQuestionView?.isEditable = false
    }

    override func viewWillAppear(_ animated: Bool) {
        animationWillResetView()
        animationQuestionView()
        resetSelectAnswer(view: UIView())
    }

    override func viewWillDisappear(_ animated: Bool) {
        if let player = playerBackground,
           player.isPlaying {
            player.stop()
        }
        stopTimer()
    }

    @IBAction func onTapBack(_ sender: Any) {
        self.stopTimer()
        let customAlert = CustomAlertViewController()
        customAlert.setupAlert(
            title: "Thông báo",
            mess: "Bạn chắc chắn muốn thoát?",
            leftTitle: "Huỷ", rightTitle: "Bỏ cuộc")
        customAlert.modalPresentationStyle = .overCurrentContext
        customAlert.modalTransitionStyle = .crossDissolve
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.actionClosureLeft = {[weak self] in
            self?.dismiss(animated: true)
            self?.setTimer()
        }
        customAlert.actionClosureRight = { [weak self] in
            self?.dismiss(animated: true)
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveLinear, animations: {
                self?.mainView?.alpha = 0
            }, completion: { _ in
                self?.navigationController?.popViewController(animated: false)
            })
        }
        self.present(customAlert, animated: true)
    }

    @IBAction func onTapAAnswerBtn(_ sender: Any) {
        if !checkSelected {
            stopTimer()
            aView?.backgroundColor = .orange
            checkSelected = true
            finalAnswer = aAnswerValue
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.showCorrectAnswer()
                self.setTimer()
             }
            changeEnableSupport()
        }
    }

    @IBAction func onTapBAnswerBtn(_ sender: Any) {
        if !checkSelected {
            stopTimer()
            bView?.backgroundColor = .orange
            checkSelected = true
            finalAnswer = bAnswerValue
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.showCorrectAnswer()
                self.setTimer()
             }
            changeEnableSupport()
        }
    }

    @IBAction func onTapCAnswerBtn(_ sender: Any) {
        if !checkSelected {
            stopTimer()
            cView?.backgroundColor = .orange
            checkSelected = true
            finalAnswer = cAnswerValue
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.showCorrectAnswer()
                self.setTimer()
             }
            changeEnableSupport()

        }
    }

    @IBAction func onTapDAnswerBtn(_ sender: Any) {
        if !checkSelected {
            stopTimer()
            dView?.backgroundColor = .orange
            checkSelected = true
            finalAnswer = dAnswerValue
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.showCorrectAnswer()
                self.setTimer()
             }
            changeEnableSupport()
        }
    }

    @IBAction func onTapSp50(_ sender: Any) {
        supportFunction50_50()
    }

    @IBAction func onTapSpAta(_ sender: Any) {
        supportFunctionAta()
    }

    @IBAction func onTapSpCall(_ sender: Any) {
        supportFunctionCall()
    }
}

// MARK: Game play
extension PlayViewController {

    private func checkIsMute() {
        if isMute {
            playerAction?.volume = 0
            playerBackground?.volume = 0
        }
    }

    func checkNextLevel() {
        if answerCount == 6 || answerCount == 11 {
            animationWillResetView()
            loadData()
            playerBackground?.stop()
            playSoundBackground()
            passDataToView()
        } else if answerCount == 16 {
            stopTimer()
            playerBackground?.stop()
            playSoundBackground()
            let congratVc = CongratulationViewController()
                    congratVc.modalPresentationStyle = .overCurrentContext
                    congratVc.modalTransitionStyle = .crossDissolve
                    congratVc.providesPresentationContextTransitionStyle = true
                    congratVc.definesPresentationContext = true
            congratVc.actionOnTapBack = { [weak self] in
                self?.dismiss(animated: false)
                self?.navigationController?.popViewController(animated: true)
            }
            congratVc.actionShareFb = {
                FBshareManager.shared.sharedFB(uiViewController: congratVc, imageName: "shareimage")
            }
                    self.present(congratVc, animated: true)
        } else {
            passDataToView()
        }
    }

    private func changeEnableSupport() {
        if checkSelected {
            callSpbutton?.isEnabled = false
            ataSpButton?.isEnabled = false
            fiveSpButton?.isEnabled = false
        } else {
            callSpbutton?.isEnabled = true
            ataSpButton?.isEnabled = true
            fiveSpButton?.isEnabled = true
        }
    }

    private func resetSelectAnswer(view: UIView) {
        checkSelected = false
        finalAnswer = ""
        resetTimCount(second: 31)
        changeEnableSupport()
        view.backgroundColor = UIColor(cgColor: self.colorAnswerBtn ?? CGColor(gray: 0, alpha: 0))
    }

    func passDataToView() {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        if let point = numberFormatter.string(from: NSNumber(value: scores)) {
            animationChangeScores(score: point)
        }
        titleQuestionView?.text = "Câu \(answerCount)"
        DataManager.shared.getDataRamdom { [weak self] allAnswer in
            guard let self = self else {
                return
            }
            self.contentQuestionView?.text = allAnswer.question
            self.aAnswerView?.setTitle("A. \(allAnswer.answer[0])", for: .normal)
            self.bAnswerView?.setTitle("B. \(allAnswer.answer[1])", for: .normal)
            self.cAnswerView?.setTitle("C. \(allAnswer.answer[2])", for: .normal)
            self.dAnswerView?.setTitle("D. \(allAnswer.answer[3])", for: .normal)
            self.aAnswerValue = allAnswer.answer[0]
            self.bAnswerValue = allAnswer.answer[1]
            self.cAnswerValue = allAnswer.answer[2]
            self.dAnswerValue = allAnswer.answer[3]
            self.correctAnswer = allAnswer.correct
        }
    }

    func loadData() {
        var level = "LevelOne"
        if answerCount > 5 && answerCount < 10 {
            level = "LevelTwo"
        } else if answerCount >= 10 {
            level = "LevelThree"
        }
        DataManager.shared.getDataAllLevelFirestore(collection: level) {
            self.passDataToView()
        }
    }

    private func checkCorretAnswer() -> UIView {
        var result = UIView()
        switch correctAnswer {
        case aAnswerValue:
            result = aView ?? UIView()
        case bAnswerValue:
            result = bView ?? UIView()
        case cAnswerValue:
            result = cView ?? UIView()
        case dAnswerValue:
            result = dView ?? UIView()
        default:
            break
        }
       return result
    }

    private func showCorrectAnswer() {
        let view = checkCorretAnswer()
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
            view.backgroundColor = .green
        }, completion: { _ in
            UIView.animate(withDuration: 0.1, delay: 0.2, options: .curveLinear, animations: {
                view.backgroundColor = .orange
            }, completion: { _ in
                UIView.animate(withDuration: 0.1, delay: 0.2, options: .curveLinear, animations: {
                    view.backgroundColor = .green
                }, completion: { [weak self] _ in
                    guard let self = self else {
                        return
                    }
                    if self.correctAnswer == self.finalAnswer {
                        self.playSoundCorrectAnswer()
                        self.answerCount += 1
                        self.scores = self.rewards[self.answerCount - 2]
                        self.resetSelectAnswer(view: view)
                        self.checkNextLevel()
                    } else {
                        self.playSoundFailAnswer()
                        self.stopTimer()
                        UIView.animate(withDuration: 0, delay: 2, options: .curveLinear, animations: {
                            self.showAlert()
                        }, completion: nil)
                    }
                })
            })
        })
    }

    private func showAlert() {
        let alertView = TimeOutViewController()
        alertView.modalPresentationStyle = .overCurrentContext
        alertView.modalTransitionStyle = .crossDissolve
        alertView.providesPresentationContextTransitionStyle = true
        alertView.definesPresentationContext = true
        alertView.titleString = "Rất tiếc"
        alertView.message = "Cảm ơn bạn đã đến với chúng tôi. Chúc bạn thành công trong cuộc sống."
        alertView.actionTapHomeBtn = { [weak self] in
            self?.dismiss(animated: false)
            self?.navigationController?.popViewController(animated: false)
            self?.playerAction?.stop()
        }
        alertView.actionDidSave = { [weak self] in
            self?.dismiss(animated: false)
            self?.navigationController?.popViewController(animated: false)
        }
        alertView.scores = Double(self.scores)
        navigationController?.present(alertView, animated: true)
    }

    private func setTimer() {
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(PlayViewController.countDown),
            userInfo: nil,
            repeats: true
        )
    }

    @objc func countDown() {
        if timeCount > 0 {
            timeCount -= 1
            clockView?.setTitle(String(timeCount), for: .normal)
        } else {
            stopTimer()
            playSoundFailAnswer()
            showAlert()
        }
    }
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    private func resetTimCount(second: Int) {
        timeCount = second
    }
}

// MARK: Animation
extension PlayViewController {

    private func displayView() {
        questionView?.alpha = 0
        aView?.transform = CGAffineTransform(translationX: 0-sceneWidth, y: 0)
        bView?.transform = CGAffineTransform(translationX: sceneWidth, y: 0)
        cView?.transform = CGAffineTransform(translationX: 0-sceneWidth, y: 0)
        dView?.transform = CGAffineTransform(translationX: sceneWidth, y: 0)
        spView?.transform = CGAffineTransform(translationX: 0, y: 100)
    }

    private func animationQuestionView() {
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
            self.questionView?.alpha = 1
            self.animationAnswersView()
            self.animationSupportView()
        }, completion: { [weak self] _ in
            self?.playSoundBackground()
        })
    }

    private func animationAnswersView() {
        aView?.transform = CGAffineTransform(translationX: 0, y: 0)
        bView?.transform = CGAffineTransform(translationX: 0, y: 0)
        cView?.transform = CGAffineTransform(translationX: 0, y: 0)
        dView?.transform = CGAffineTransform(translationX: 0, y: 0)
    }

    private func animationSupportView() {
        spView?.transform = CGAffineTransform(translationX: 0, y: 0)
    }

    private func animationWillResetView() {
        mainView?.alpha = 0
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
            self.mainView?.alpha = 1
        }, completion: nil)
    }

    private func animationBtnSuccess(uiView: UIView) {
        for _ in 0...3 {
            UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
                uiView.backgroundColor = .orange
            }, completion: { _ in
                uiView.backgroundColor = .green
            })
        }
    }
}

// MARK: support function
extension PlayViewController {
    private func animationChangeScores(score: String) {
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveLinear,
            animations: {
                self.pointView?.transform = CGAffineTransform(translationX: 150, y: 0)
                self.pointView?.alpha = 0
            }, completion: { [weak self] _ in
                self?.pointView?.setTitle(score, for: .normal)
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
                    self?.pointView?.transform = CGAffineTransform(translationX: 0, y: 0)
                    self?.pointView?.alpha = 1
                })
            })
    }

    private func supportFunction50_50() {
        self.stopTimer()
        let customAlert = CustomAlertViewController()
        customAlert.setupAlert(
            title: "Sử dụng quyền trợ giúp",
            mess: "Bạn có chắc muốn sử dụng quyền trợ giúp này??",
            leftTitle: "Huỷ", rightTitle: "OK")
        customAlert.modalPresentationStyle = .overCurrentContext
        customAlert.modalTransitionStyle = .crossDissolve
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.actionClosureLeft = {[weak self] in
            self?.dismiss(animated: true)
            self?.setTimer()
        }
        customAlert.actionClosureRight = { [weak self] in
            self?.dismiss(animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self?.removeTwoAnswer()
                self?.setTimer()
                self?.imageSpView1?.isHidden = false
                self?.fiveSpButton?.isEnabled = false
             }
        }
        self.present(customAlert, animated: true)
    }

    private func supportFunctionAta() {
        self.stopTimer()
        let percent = getCharAnswerCorret()
        let customAlert = CustomAlertViewController()
        customAlert.setupAlert(
            title: "Sử dụng quyền trợ giúp",
            mess: "Bạn có chắc muốn sử dụng quyền trợ giúp này??",
            leftTitle: "Huỷ", rightTitle: "OK")
        customAlert.modalPresentationStyle = .overCurrentContext
        customAlert.modalTransitionStyle = .crossDissolve
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.actionClosureLeft = {[weak self] in
            self?.dismiss(animated: true)
            self?.setTimer()
        }
        customAlert.actionClosureRight = { [weak self] in
            self?.dismiss(animated: true)
            let audienceVc = AskAudienceViewController()
            audienceVc.configuraPercent(percent: percent)
            audienceVc.actionPlaySound = { [weak self] in
                self?.playSoundUseSupport()
            }
            audienceVc.actionDidCancel = { [weak self] in
                self?.setTimer()
                self?.imageSpView2?.isHidden = false
                self?.ataSpButton?.isEnabled = false
            }
            audienceVc.modalPresentationStyle = .overCurrentContext
            audienceVc.modalTransitionStyle = .crossDissolve
            audienceVc.providesPresentationContextTransitionStyle = true
            audienceVc.definesPresentationContext = true
            self?.present(audienceVc, animated: true)
        }
        self.present(customAlert, animated: true)
    }

    private func supportFunctionCall() {
        self.stopTimer()
        let percent = getCharAnswerCorret()
        let customAlert = CustomAlertViewController()
        customAlert.setupAlert(
            title: "Sử dụng quyền trợ giúp",
            mess: "Bạn có chắc muốn sử dụng quyền trợ giúp này??",
            leftTitle: "Huỷ", rightTitle: "OK")
        customAlert.modalPresentationStyle = .overCurrentContext
        customAlert.modalTransitionStyle = .crossDissolve
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.actionClosureLeft = {[weak self] in
            self?.dismiss(animated: true)
            self?.setTimer()
        }
        customAlert.actionClosureRight = { [weak self] in
            self?.dismiss(animated: true)
            let callVc = CallFriendViewController()
            callVc.tempAnswer = percent
            callVc.actionPlaySound = { [weak self] in
                self?.playSoundUseSupport()
            }
            callVc.actionDidCancel = { [weak self] in
                self?.setTimer()
                self?.imageSpView3?.isHidden = false
                self?.callSpbutton?.isEnabled = false
            }
            callVc.modalPresentationStyle = .overCurrentContext
            callVc.modalTransitionStyle = .crossDissolve
            callVc.providesPresentationContextTransitionStyle = true
            callVc.definesPresentationContext = true
            self?.present(callVc, animated: true)
        }
        self.present(customAlert, animated: true)
    }

    private func getCharAnswerCorret() -> String {
        switch correctAnswer {
        case aAnswerValue:
            return "A"
        case bAnswerValue:
            return "B"
        case cAnswerValue:
            return "C"
        case dAnswerValue:
            return "D"
        default:
            return ""
        }
    }

    private func removeTwoAnswer() {
        var answers = ["A", "B", "C", "D"]
        let corretAnswer = getCharAnswerCorret()
        for index in 0...answers.count-1 where answers[index].lowercased() == corretAnswer.lowercased() {
            answers.remove(at: index)
            break
        }
        playSoundUseSupport()
        for _ in 0...1 {
            let number = Int.random(in: 0...answers.count-1)
            switch answers[number] {
            case "A":
                aAnswerView?.setTitle("A.", for: .normal)
                answers.remove(at: number)
            case "B":
                bAnswerView?.setTitle("B.", for: .normal)
                answers.remove(at: number)
            case "C":
                cAnswerView?.setTitle("C.", for: .normal)
                answers.remove(at: number)
            case "D":
                dAnswerView?.setTitle("D.", for: .normal)
                answers.remove(at: number)
            default:
                break
            }
        }
    }

}
