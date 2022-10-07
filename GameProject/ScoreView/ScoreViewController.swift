//
//  ScoreViewController.swift
//  GameProject
//
//  Created by GST.DN on 03/10/2022.
//

import UIKit

class ScoreViewController: UIViewController {
    @IBOutlet var scoreTable: UITableView?
    var historis: [History] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        scoreTable?.alpha = 0
        setupCell()
        loadData()
    }

    private func loadData() {
        historis = History.getAllHistory()
    }

    private func setupCell() {
        scoreTable?.register(
            UINib(nibName: "ScoreTableViewCell", bundle: .main),
            forCellReuseIdentifier: "ScoreTableViewCell"
        )
        scoreTable?.delegate = self
        scoreTable?.dataSource = self
    }

    @IBAction func onBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension ScoreViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        historis.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "ScoreTableViewCell",
            for: indexPath) as? ScoreTableViewCell else {
            return UITableViewCell()
        }
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
            self.scoreTable?.alpha = 1
        }, completion: nil)

        cell.placesLabel.text = "\(indexPath.row + 1)"
        cell.nameLabel.text = historis[indexPath.row].name
        cell.scoreLabel.text = String(historis[indexPath.row].scores)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        scoreTable?.deselectRow(at: indexPath, animated: true)
    }
}
