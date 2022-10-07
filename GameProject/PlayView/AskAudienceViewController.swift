//
//  AskAudienceViewController.swift
//  GameProject
//
//  Created by GST.DN on 05/10/2022.
//

import UIKit

class AskAudienceViewController: UIViewController {

    @IBOutlet weak var mainView: UIView?
    @IBOutlet var percentViewA: UIView?
    @IBOutlet var percentViewB: UIView?
    @IBOutlet var percentViewC: UIView?
    @IBOutlet var percentViewD: UIView?
    @IBOutlet var viewAHeight: NSLayoutConstraint?
    @IBOutlet var viewBHeight: NSLayoutConstraint?
    @IBOutlet var viewCHeight: NSLayoutConstraint?
    @IBOutlet var viewDHeight: NSLayoutConstraint?
    @IBOutlet var percentALabel: UILabel?
    @IBOutlet var percentBLabel: UILabel?
    @IBOutlet var percentCLabel: UILabel?
    @IBOutlet var percentDLabel: UILabel?
    var actionDidCancel: () -> Void = {}
    var actionPlaySound: () -> Void = {}
    var percentA: Double?
    var percentB: Double?
    var percentC: Double?
    var percentD: Double?

    override func viewDidLoad() {
        super.viewDidLoad()
        percentAnswer()
        setupPercentLabel()
    }

    @IBAction func onCloseViewButton(_ sender: Any) {
        self.dismiss(animated: true)
        actionDidCancel()
    }

    private func percentAnswer() {
        guard let percentA = percentA, let percentB = percentB, let percentC = percentC, let percentD = percentD  else {
            return
        }
        UIView.animate(withDuration: 1) {
            self.mainView?.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        } completion: { _ in
            UIView.animate(withDuration: 0.5) {
                self.mainView?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            } completion: { _ in
                    UIView.animate(withDuration: 0.5) {
                        self.percentViewA?.transform = CGAffineTransform(scaleX: 1, y: CGFloat(percentA))
                            .concatenating(CGAffineTransform(translationX: 0, y: (100 * (1 - CGFloat(percentA))) / 2))
                        self.percentViewB?.transform = CGAffineTransform(scaleX: 1, y: CGFloat(percentB))
                            .concatenating(CGAffineTransform(translationX: 0, y: (100 * (1 - CGFloat(percentB))) / 2))
                        self.percentViewC?.transform = CGAffineTransform(scaleX: 1, y: CGFloat(percentC))
                            .concatenating(CGAffineTransform(translationX: 0, y: (100 * (1 - CGFloat(percentC))) / 2))
                        self.percentViewD?.transform = CGAffineTransform(scaleX: 1, y: CGFloat(percentD))
                            .concatenating(CGAffineTransform(translationX: 0, y: (100 * (1 - CGFloat(percentD))) / 2))
                        self.setupPercentLabel()
                        self.actionPlaySound()
                }
            }
        }
    }

    private func setupPercentLabel() {
        guard let percentA = percentA, let percentB = percentB,
                    let percentC = percentC, let percentD = percentD  else { return }
        percentALabel?.text = "\(String(format: "%.0f", percentA * 100))%"
        percentBLabel?.text = "\(String(format: "%.0f", percentB * 100))%"
        percentCLabel?.text = "\(String(format: "%.0f", percentC * 100))%"
        percentDLabel?.text = "\(String(format: "%.0f", percentD * 100))%"
    }

    func configuraPercent(percent: String) {
        let number = Int.random(in: 40...55)
        let number1 = Int.random(in: 0...(100 - number))
        let number2 = Int.random(in: 0...(100 - number - number1))
        let numver3 = 100 - number - number1 - number2
        if percent.lowercased() == "a" {
            percentA = Double(number) / 100
            percentB = Double(number1) / 100
            percentC = Double(number2) / 100
            percentD = Double(numver3) / 100
        } else if percent.lowercased() == "b" {
            percentB = Double(number) / 100
            percentA = Double(number1) / 100
            percentC = Double(number2) / 100
            percentD = Double(numver3) / 100
        } else if percent.lowercased() == "c" {
            percentC = Double(number) / 100
            percentA = Double(number1) / 100
            percentB = Double(number2) / 100
            percentD = Double(numver3) / 100
        } else {
            percentD = Double(number) / 100
            percentA = Double(number1) / 100
            percentC = Double(number2) / 100
            percentB = Double(numver3) / 100
        }
    }
}
