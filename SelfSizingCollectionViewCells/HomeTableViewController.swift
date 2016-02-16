//
//  HomeTableViewController.swift
//  SelfSizingCollectionViewCells
//
//  Created by Daniel Galasko on 2016/02/16.
//  Copyright © 2016 Galasko. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
}

enum StoryboardViewControllers {
    case StaticCellsViewController
    case DynamicCellsViewController
    case LayoutAttributesCellsViewController
    case DynamicCellsWithLayoutAttributes
    
    func storyboardID() -> String {
        switch self {
        case .StaticCellsViewController:
            return "CollectionViewController"
        case .DynamicCellsViewController:
            return "DynamicContentCollectionViewController"
        case .LayoutAttributesCellsViewController:
            return "CollectionViewController"
        case .DynamicCellsWithLayoutAttributes:
            return "CollectionViewController"
        }
    }
    
    func createController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier(storyboardID())
        configureControllerIfNeeded(controller)
        return controller
    }
    
    func configureControllerIfNeeded(controller: UIViewController) {
        switch self {
        case .LayoutAttributesCellsViewController:
            let c = controller as! CollectionViewController
            c.configuration = CollectionViewController.Configuration(cellType: CollectionViewController.Configuration.CellType.LayoutAttributesCell)
        case .DynamicCellsWithLayoutAttributes:
            let c = controller as! CollectionViewController
            c.configuration = CollectionViewController.Configuration(cellType: CollectionViewController.Configuration.CellType.SimpleCellWithDynamicText)
        default:
            break
        }
    }
}

class HomeTableViewController: UITableViewController {
    
    struct ActionableCells {
        let title: String
        let controller: StoryboardViewControllers
    }
    
    let cells = [ActionableCells(title: "Static Content Cells. Technically since the content never changes these cells should all be the same size. This demonstrates what the layout does when all cells have the same size", controller: StoryboardViewControllers.StaticCellsViewController),
        ActionableCells(title: "Dynamic content cells implementing preferred layout attributes in the cell subclass with auto layout", controller: StoryboardViewControllers.DynamicCellsWithLayoutAttributes),
        ActionableCells(title: "Dynamic Content Cells using auto layout WITHOUT overriding preferredLayoutAttributes", controller: StoryboardViewControllers.DynamicCellsViewController),
        ActionableCells(title: "Cells overriding preferredLayoutAttributes with NO auto layout. We should expect to see dynamic sizing.", controller: StoryboardViewControllers.LayoutAttributesCellsViewController)]
    
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
