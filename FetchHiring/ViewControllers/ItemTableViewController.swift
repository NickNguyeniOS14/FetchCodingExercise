//
//  ViewController.swift
//  FetchHiring
//
//  Created by Nick Nguyen on 10/19/20.
//

import UIKit

final class ItemTableViewController: UITableViewController {

    // MARK: - Properties

    private let networkService =  NetworkService()

    private var items: [Item] = []

    private let reuseCellID = "ItemCell"

    private let sectionData: [Section] = [.one,.two,.three,.four]

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
                    self.presentAlertOnMainThread(for: error)
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
        switch sectionData[section] {
            case .one:
                titleForSection = "Group 1"
            case .two:
                titleForSection = "Group 2"
            case .three:
                titleForSection = "Group 3"
            case .four:
                titleForSection = "Group 4"
        }
        return titleForSection
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sectionData[section]
        let numberOfRows = generateFilteredItems(for: section)
        return numberOfRows.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseCellID, for: indexPath)
        let section = sectionData[indexPath.section]
        let groupedItems = generateFilteredItems(for: section)
        let item = groupedItems[indexPath.row]

        configureUIFor(item, at: cell)
        return cell
    }
}
