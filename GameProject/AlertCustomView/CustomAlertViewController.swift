//
//  TimeOutViewController.swift
//  GameProject
//
//  Created by GST.DN on 03/10/2022.
//

import UIKit

class CustomAlertViewController: UIViewController {
    @IBOutlet var iconImage: UIImageView?
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var messageLabel: UILabel?
    @IBOutlet var buttonLeft: UIButton?
    @IBOutlet var buttonRight: UIButton?
    var actionClosureLeft: () -> Void = {}
    var actionClosureRight: () -> Void = {}
    var subTitle = ""
    var subMess = ""
    var subLeftTitle = ""
    var subRightTitle = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel?.text = subTitle
        messageLabel?.text = subMess
        buttonLeft?.setTitle(subLeftTitle, for: .normal)
        buttonRight?.setTitle(subRightTitle, for: .normal)
    }

    override func viewWillAppear(_ animated: Bool) {
        iconImage?.layer.cornerRadius = (iconImage?.frame.height ?? 0)/2
    }

    func setupAlert(title: String, mess: String, leftTitle: String, rightTitle: String) {
        subTitle = title
        subMess = mess
        subLeftTitle = leftTitle
        subRightTitle = rightTitle
    }

    @IBAction func playButton(_ sender: Any) {
        actionClosureRight()
    }

    @IBAction func onActionLeftButton(_ sender: Any) {
        actionClosureLeft()
    }
}
