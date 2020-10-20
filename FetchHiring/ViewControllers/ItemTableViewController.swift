//
//  ViewController.swift
//  FetchHiring
//
//  Created by Nick Nguyen on 10/19/20.
//

import UIKit

class ItemTableViewController: UITableViewController {

    // MARK: - Properties

    var networkService =  NetworkService()

    var items: [Item] = []

    private let reuseCellID = "ItemCell"

    var sectionData: [Section] = [.one,.two,.three,.four]

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        getItemsFromServer()

    }

    // MARK: - Privates

    private func getItemsFromServer() {
        networkService.getItemsFromServer(completion: { (result) in
            switch result {
                case .success(let items):
                    self.items = items.sorted(by: <)
                        .filter { $0.name != "" && $0.name != nil }
                    self.reloadDataOnMainThread()
                case .failure(let error):
                    self.presentErrorAlertOnMainThread(for: error)
            }
        })
    }

    private func generateFilteredItems(for section: Section) -> [Item] {
        return items.filter { $0.group == section.rawValue }
    }

    private func configureUIFor(_ item: Item,at cell :UITableViewCell) {
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "List ID: \(item.group)"
    }


    // MARK: - Table View Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionData.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var titleForSection = ""
        switch section {
            case 0:
                titleForSection = "Group 1"
            case 1:
                titleForSection = "Group 2"
            case 2:
                titleForSection = "Group 3"
            case 3:
                titleForSection = "Group 4"
            default:
                break
        }
        return titleForSection
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sectionData[section]
        var numberOfRows = 0

        switch section {
            case .one:
                numberOfRows = items.filter { $0.group == 1}.count

            case .two:
                numberOfRows = items.filter { $0.group == 2}.count

            case .three:
                numberOfRows = items.filter { $0.group == 3}.count

            case .four:
                numberOfRows = items.filter { $0.group == 4}.count

        }
        return numberOfRows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseCellID, for: indexPath)
        
        let section = sectionData[indexPath.section]
        
        switch section {
            case .one:
                let groupedItems = generateFilteredItems(for: section)
                let item = groupedItems[indexPath.row]
                configureUIFor(item, at: cell)
            case .two:
                let groupedItems = generateFilteredItems(for: section)
                let item = groupedItems[indexPath.row]
                configureUIFor(item, at: cell)
            case .three:
                let groupedItems = generateFilteredItems(for: section)
                let item = groupedItems[indexPath.row]
                configureUIFor(item, at: cell)
            case .four:
                let groupedItems = generateFilteredItems(for: section)
                let item = groupedItems[indexPath.row]
                configureUIFor(item, at: cell)
        }

        return cell
    }
}
