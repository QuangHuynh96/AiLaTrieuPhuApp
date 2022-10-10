//
//  RulesViewController.swift
//  GameProject
//
//  Created by GST.DN on 03/10/2022.
//

import UIKit

class RulesViewController: UIViewController {
    @IBOutlet var rulesTable: UITableView?
    @IBOutlet weak var textViewField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCell()
        textViewField.isScrollEnabled = false
    }

    private func setupCell() {
        rulesTable?.register(
            UINib(nibName: "RulesTableViewCell", bundle: .main),
            forCellReuseIdentifier: "RulesTableViewCell"
        )
        rulesTable?.register(
            UINib(nibName: "RulesTableViewCell2", bundle: .main),
            forCellReuseIdentifier: "RulesTableViewCell2"
        )
        rulesTable?.register(
            UINib(nibName: "RulesTableViewCell3", bundle: .main),
            forCellReuseIdentifier: "RulesTableViewCell3"
        )
        rulesTable?.delegate = self
        rulesTable?.dataSource = self
    }

    @IBAction func onTapBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension RulesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "RulesTableViewCell",
                for: indexPath) as? RulesTableViewCell else {
                return UITableViewCell()
            }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "RulesTableViewCell2",
                for: indexPath) as? RulesTableViewCell2 else {
                return UITableViewCell()
            }
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "RulesTableViewCell3",
                for: indexPath) as? RulesTableViewCell3 else {
                return UITableViewCell()
            }
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rulesTable?.deselectRow(at: indexPath, animated: true)
    }
}
