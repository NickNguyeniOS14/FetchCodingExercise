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
        let whiteSpace = ""
        networkService.getItemsFromServer(completion: { (result) in
            switch result {
                case .success(let items):
                    self.items = items.sorted(by: <).filter { $0.name != whiteSpace && $0.name != nil }
                    self.reloadDataOnMainThread()
                case .failure(let error):
                    self.presentAlertOnMainThread(for: error)
            }
        })
    }

    private func generateFilteredItems(for section: Section) -> [Item] {
        return items.filter { $0.group == section.rawValue }
    }

    private func configureUIFor(_ item: Item, at cell: UITableViewCell) {
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "List ID: \(item.group)"
    }


    // MARK: - Table View Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionData.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let group = section + 1 // Section raw value start from 0 
        return "Group \(group)"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sectionData[section]
        let numberOfRowsForEachSection = generateFilteredItems(for: section)
        return numberOfRowsForEachSection.count
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
