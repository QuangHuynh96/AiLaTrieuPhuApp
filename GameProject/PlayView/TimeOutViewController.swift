//
//  TimeOutViewController.swift
//  GameProject
//
//  Created by GST.DN on 03/10/2022.
//

import UIKit

class TimeOutViewController: UIViewController {
    @IBOutlet var iconImage: UIImageView?
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var messageLabel: UILabel?
    @IBOutlet var buttonLeft: UIButton?
    @IBOutlet var buttonRight: UIButton?
    @IBOutlet weak var mainView: UIView?
    @IBOutlet weak var inputNameView: UIView?
    @IBOutlet weak var inputNameTextField: UITextField?

    var titleString: String?
    var message: String?
    var scores: Double?
    var actionTapHomeBtn: () -> Void = {}
    var actionTapSave: () -> Void = {}
    var actionDidSave: () -> Void = {}

    override func viewDidLoad() {
        super.viewDidLoad()
        inputNameView?.alpha = 0
        inputNameView?.isHidden = true
        mainView?.alpha = 0
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            self.mainView?.alpha = 1
            self.mainView?.transform = CGAffineTransform(translationX: 0, y: 100)
        }, completion: nil)
    }

    @IBAction func onTapCancelSave(_ sender: Any) {
        actionDidSave()
    }

    @IBAction func onTapSave(_ sender: Any) {
        guard let name = inputNameTextField?.text,
              let scores = scores else {
            return
        }
        _ = History.insertNewContact(name: name, scores: scores)
        actionDidSave()
    }

    private func setupUI() {
        titleLabel?.text = titleString
        messageLabel?.text = message
    }

    @IBAction func playButton(_ sender: Any) {
        inputNameView?.isHidden = false
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveLinear, animations: { [weak self] in
            self?.inputNameView?.alpha = 1
            self?.mainView?.alpha = 0
        }, completion: nil)
    }

    @IBAction func homeButton(_ sender: Any) {
        actionTapHomeBtn()
    }

}
