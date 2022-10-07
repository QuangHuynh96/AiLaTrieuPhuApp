//
//  RulesViewController.swift
//  GameProject
//
//  Created by GST.DN on 03/10/2022.
//

import UIKit

class RulesViewController: UIViewController {
    @IBOutlet var rulesTable: UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCell()
    }

    private func setupCell() {
        rulesTable?.register(
            UINib(nibName: "RulesTableViewCell", bundle: .main),
            forCellReuseIdentifier: "RulesTableViewCell"
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
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "RulesTableViewCell",
            for: indexPath) as? RulesTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rulesTable?.deselectRow(at: indexPath, animated: true)
    }
}
