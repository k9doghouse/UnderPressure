//
//  TableViewController.swift
//  UnderPressure
//
//  Created by murph on 4/22/19.
//  Copyright © 2019 k9doghouse. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var frc: NSFetchedResultsController = NSFetchedResultsController<NSFetchRequestResult>()
    var pc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var item: Entity? = nil

    func fetchRequest() -> NSFetchRequest<NSFetchRequestResult> {

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        let sorter = NSSortDescriptor(key: "texttitle", ascending: false)
        fetchRequest.sortDescriptors = [sorter]

        return fetchRequest
        }


    func getFRC() -> NSFetchedResultsController<NSFetchRequestResult> {

        frc = NSFetchedResultsController(fetchRequest: fetchRequest(),
                                         managedObjectContext: pc,
                                         sectionNameKeyPath: nil,
                                         cacheName: nil)

        return frc
    }


    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
        { self.tableView.reloadData() }


    override func viewDidLoad() {
        super.viewDidLoad()

        SensorData().getSensorData()
        SensorData().intervalTimer3600()

        frc = getFRC()
        frc.delegate = self

        do { try frc.performFetch() }
        catch { print(error); return }

        self.tableView.reloadData()
        self.tableView.rowHeight = 32
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int
         { return 1 }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {

        guard let numberOfRows = frc.sections?[section].numberOfObjects else { return 1 }

        return numberOfRows
    }


    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                 for: indexPath) as! TableViewCell

        let item = frc.object(at: indexPath) as! Entity

        cell.cellTitle.text = item.texttitle

        return cell
    }

    @IBAction func newReadingButtonTapped(_ sender: UIBarButtonItem) {

        SensorData().getSensorData()
    }

}
