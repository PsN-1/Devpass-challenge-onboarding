//
//  SettingsViewController.swift
//  challengeDevPass
//
//  Created by Pedro Neto on 30/12/21.
//

import UIKit

class SettingsViewController: UITableViewController {
    var settings = Settings().getSettingsOptions()
    var onSelectedOption: ((IndexPath) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: K.settingsCell)
        title = "Settings"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.settingsCell, for: indexPath)
        let currentOption = settings[indexPath.section].items[indexPath.row]
        cell.textLabel?.text = currentOption?.name
        cell.selectionStyle = (currentOption?.isActive ?? false) ? .default : .none
        cell.accessoryType = (currentOption?.isActive ?? false) ? .disclosureIndicator : .none
        cell.isUserInteractionEnabled = currentOption?.isActive ?? false
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        settings[section].header
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settings[section].items.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        settings.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Option Selected: " + (settings[indexPath.section].items[indexPath.row]?.name ?? ""))
        onSelectedOption?(indexPath)
    }
}

