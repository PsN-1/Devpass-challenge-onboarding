//
//  DetailViewController.swift
//  challengeDevPass
//
//  Created by Pedro Neto on 29/12/21.
//

import UIKit

class DetailViewController: UITableViewController {
    var repo: RepositoryModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(DescriptionViewCell.self, forCellReuseIdentifier: K.descriptionCell)
        tableView.rowHeight = UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: K.descriptionCell, for: indexPath) as? DescriptionViewCell
        cell = DescriptionViewCell(cellData: loadCellDataFor(index: indexPath.row))
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func loadCellDataFor(index: Int) -> CellData {
        switch index {
        case 0:
            return CellData(
                title: repo?.name ?? "",
                descriptionTitle: repo?.description ?? "",
                subTitle: "\(repo?.stargazersCount ?? 0 ) estrelas   \(repo?.forksCount ?? 0) bifurcações",
                buttonTitle: nil,
                hasButtom: false)
        case 1:
            return CellData(
                title: "Owner",
                descriptionTitle: repo?.owner?.login,
                subTitle: repo?.owner?.type,
                buttonTitle: "See Profile",
                imageName: repo?.owner?.userPhoto,
                hasButtom: true,
                hasImage: true
            )
        case 2:
            return CellData(
                title: "License",
                descriptionTitle: repo?.license?.name,
                subTitle: repo?.license?.id,
                buttonTitle: "See License",
                hasButtom: true)
        default: return CellData()
        }
    }
}
