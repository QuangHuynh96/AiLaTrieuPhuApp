//
//  CallFriendViewController.swift
//  GameProject
//
//  Created by GST.DN on 05/10/2022.
//

import UIKit

class CallFriendViewController: UIViewController {

    @IBOutlet var answerLabelA: UILabel?
    @IBOutlet var answerButtonA: UIButton?
    @IBOutlet var answerLabelB: UILabel?
    @IBOutlet var answerButtonB: UIButton?
    @IBOutlet var answerLabelC: UILabel?
    @IBOutlet var answerButtonC: UIButton?
    @IBOutlet var answerLabelD: UILabel?
    @IBOutlet var answerButtonD: UIButton?
    @IBOutlet var closeButton: UIButton?
    @IBOutlet var rateLabelA: UILabel?
    @IBOutlet var rateLabelC: UILabel?
    @IBOutlet var rateLabelB: UILabel?
    @IBOutlet var rateLabelD: UILabel?
    var percentA: Double?
    var percentB: Double?
    var percentC: Double?
    var percentD: Double?
    var tempAnswer = ""
    var actionDidCancel: () -> Void = {}
    var actionPlaySound: () -> Void = {}

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        correctAnswer()
    }

    private func setupUI() {
        answerLabelA?.alpha = 0
        answerLabelB?.alpha = 0
        answerLabelC?.alpha = 0
        answerLabelD?.alpha = 0
        rateLabelA?.alpha = 0
        rateLabelB?.alpha = 0
        rateLabelC?.alpha = 0
        rateLabelD?.alpha = 0
        answerLabelA?.layer.masksToBounds = true
        answerLabelA?.layer.cornerRadius = 16
        answerLabelB?.layer.masksToBounds = true
        answerLabelB?.layer.cornerRadius = 16
        answerLabelC?.layer.masksToBounds = true
        answerLabelC?.layer.cornerRadius = 16
        answerLabelD?.layer.masksToBounds = true
        answerLabelD?.layer.cornerRadius = 16

        closeButton?.alpha = 0
        closeButton?.isHidden = true
    }

    @IBAction func onTapCallPersonA(_ sender: Any) {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveLinear, animations: {
            self.answerButtonA?.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }, completion: {_ in
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveLinear, animations: { [self] in
                self.answerButtonA?.transform = CGAffineTransform(scaleX: 1, y: 1)
                answerLabelA?.alpha = 1
                rateLabelA?.alpha = 1
                answerButtonB?.alpha = 0.5
                answerButtonC?.alpha = 0.5
                answerButtonD?.alpha = 0.5
                closeButton?.alpha = 1
                closeButton?.isHidden = false
            }, completion: nil)
        })
        actionPlaySound()
        answerButtonB?.isEnabled = false
        answerButtonC?.isEnabled = false
        answerButtonD?.isEnabled = false
    }

    @IBAction func onTapCallPersonB(_ sender: Any) {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveLinear, animations: {
            self.answerButtonB?.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }, completion: {_ in
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveLinear, animations: { [self] in
                self.answerButtonB?.transform = CGAffineTransform(scaleX: 1, y: 1)
                answerLabelB?.alpha = 1
                rateLabelB?.alpha = 1
                answerButtonA?.alpha = 0.5
                answerButtonC?.alpha = 0.5
                answerButtonD?.alpha = 0.5
                closeButton?.alpha = 1
                closeButton?.isHidden = false
            }, completion: nil)
        })
        actionPlaySound()
        answerButtonA?.isEnabled = false
        answerButtonC?.isEnabled = false
        answerButtonD?.isEnabled = false
        closeButton?.isEnabled = true
    }

    @IBAction func onTapCallPersonC(_ sender: Any) {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveLinear, animations: {
            self.answerButtonC?.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }, completion: {_ in
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveLinear, animations: { [self] in
                self.answerButtonC?.transform = CGAffineTransform(scaleX: 1, y: 1)
                answerLabelC?.alpha = 1
                rateLabelC?.alpha = 1
                answerButtonA?.alpha = 0.5
                answerButtonB?.alpha = 0.5
                answerButtonD?.alpha = 0.5
                closeButton?.alpha = 1
                closeButton?.isHidden = false
            }, completion: nil)
        })
        actionPlaySound()
        answerButtonA?.isEnabled = false
        answerButtonB?.isEnabled = false
        answerButtonD?.isEnabled = false
        closeButton?.isEnabled = true
    }

    @IBAction func onTapCallPersonD(_ sender: Any) {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveLinear, animations: {
            self.answerButtonD?.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }, completion: {_ in
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveLinear, animations: { [self] in
                self.answerButtonD?.transform = CGAffineTransform(scaleX: 1, y: 1)
                answerLabelD?.alpha = 1
                rateLabelD?.alpha = 1
                answerButtonA?.alpha = 0.5
                answerButtonB?.alpha = 0.5
                answerButtonC?.alpha = 0.5
                closeButton?.alpha = 1
                closeButton?.isHidden = false
            }, completion: nil)
        })
        actionPlaySound()
        answerButtonA?.isEnabled = false
        answerButtonB?.isEnabled = false
        answerButtonC?.isEnabled = false
        closeButton?.isEnabled = true
    }

    @IBAction func onTapClose(_ sender: Any) {
        self.dismiss(animated: true)
        actionDidCancel()
    }

    private func setColorRate(label: UILabel, percent: Double, lableAnswer: UILabel) {
        if percent*100 > 60.0 {
            label.textColor = .green
            lableAnswer.text = tempAnswer
        } else {
            let number = Int.random(in: 1...4)
            switch number {
            case 1:
                lableAnswer.text = "A"
            case 2:
                lableAnswer.text = "B"
            case 3:
                lableAnswer.text = "C"
            case 4:
                lableAnswer.text = "D"
            default:
                break
            }
        }
    }

    private func setRateLabel() {
        guard let percentA = percentA,
              let percentB = percentB,
              let percentC = percentC,
              let percentD = percentD
        else {
            return
        }
        guard let answerLabelA = answerLabelA,
              let answerLabelB = answerLabelB,
              let answerLabelC = answerLabelC,
              let answerLabelD = answerLabelD
        else {
            return
        }
        guard let rateLabelA = rateLabelA,
              let rateLabelB = rateLabelB,
              let rateLabelC = rateLabelC,
              let rateLabelD = rateLabelD
        else {
            return
        }
        rateLabelA.text = "\(String(format: "%.0f", (percentA ) * 100))%"
        rateLabelB.text = "\(String(format: "%.0f", (percentB ) * 100))%"
        rateLabelC.text = "\(String(format: "%.0f", (percentC ) * 100))%"
        rateLabelD.text = "\(String(format: "%.0f", (percentD ) * 100))%"
        setColorRate(label: rateLabelA, percent: percentA, lableAnswer: answerLabelA )
        setColorRate(label: rateLabelB, percent: percentB, lableAnswer: answerLabelB )
        setColorRate(label: rateLabelC, percent: percentC, lableAnswer: answerLabelC )
        setColorRate(label: rateLabelD, percent: percentD, lableAnswer: answerLabelD )
    }

    func correctAnswer() {
        percentA = Double(Int.random(in: 50...100)) / 100
        percentB = Double(Int.random(in: 50...100)) / 100
        percentC = Double(Int.random(in: 50...100)) / 100
        percentD = Double(Int.random(in: 50...100)) / 100
        setRateLabel()
    }
}
