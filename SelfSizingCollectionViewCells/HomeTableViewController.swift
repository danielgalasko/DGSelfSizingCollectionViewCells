//
//  HomeTableViewController.swift
//  SelfSizingCollectionViewCells
//
//  Created by Daniel Galasko on 2016/02/16.
//  Copyright © 2016 Afrozaar. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
}

enum StoryboardViewControllers {
    case StaticCellsViewController
    case DynamicCellsViewController
    
    func storyboardID() -> String {
        switch self {
        case .StaticCellsViewController:
            return "CollectionViewController"
        case .DynamicCellsViewController:
            return "DynamicContentCollectionViewController"
        }
    }
    
    func createController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewControllerWithIdentifier(storyboardID())
    }
}

class HomeTableViewController: UITableViewController {
    
    struct ActionableCells {
        let title: String
        let controller: StoryboardViewControllers
    }
    
    let cells = [ActionableCells(title: "Static Content Cells with fixed height. Technically since the content never changes these cells should all be the same size. This demonstrates what the layout does when all cells have the same size", controller: StoryboardViewControllers.StaticCellsViewController),
    ActionableCells(title: "Dynamic Content Cells with fixed height. We should expect to see all cells fill their available sizes", controller: StoryboardViewControllers.DynamicCellsViewController)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 50
        self.title = "Home"
    }

    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeCellReuseIdentifier", forIndexPath: indexPath) as! HomeCell
        cell.accessoryType = .DisclosureIndicator
        cell.label.text = cells[indexPath.row].title
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let controller = cells[indexPath.row].controller.createController()
        showViewController(controller, sender: nil)
    }

}
