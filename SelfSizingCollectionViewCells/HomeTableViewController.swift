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
    case staticCellsViewController
    case dynamicCellsViewController
    case layoutAttributesCellsViewController
    case dynamicCellsWithLayoutAttributes
    
    func storyboardID() -> String {
        switch self {
        case .staticCellsViewController:
            return "CollectionViewController"
        case .dynamicCellsViewController:
            return "DynamicContentCollectionViewController"
        case .layoutAttributesCellsViewController:
            return "CollectionViewController"
        case .dynamicCellsWithLayoutAttributes:
            return "CollectionViewController"
        }
    }
    
    func createController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: storyboardID())
        configureControllerIfNeeded(controller)
        return controller
    }
    
    func configureControllerIfNeeded(_ controller: UIViewController) {
        switch self {
        case .layoutAttributesCellsViewController:
            let c = controller as! CollectionViewController
            c.configuration = CollectionViewController.Configuration(cellType: CollectionViewController.Configuration.CellType.layoutAttributesCell)
        case .dynamicCellsWithLayoutAttributes:
            let c = controller as! CollectionViewController
            c.configuration = CollectionViewController.Configuration(cellType: CollectionViewController.Configuration.CellType.simpleCellWithDynamicText)
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
    
    let cells = [ActionableCells(title: "Static Content Cells. Technically since the content never changes these cells should all be the same size. This demonstrates what the layout does when all cells have the same size", controller: StoryboardViewControllers.staticCellsViewController),
        ActionableCells(title: "Dynamic content cells implementing preferred layout attributes in the cell subclass with auto layout", controller: StoryboardViewControllers.dynamicCellsWithLayoutAttributes),
        ActionableCells(title: "Dynamic Content Cells using auto layout WITHOUT overriding preferredLayoutAttributes", controller: StoryboardViewControllers.dynamicCellsViewController),
        ActionableCells(title: "Cells overriding preferredLayoutAttributes with NO auto layout. We should expect to see dynamic sizing.", controller: StoryboardViewControllers.layoutAttributesCellsViewController)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 50
        self.title = "Home"
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCellReuseIdentifier", for: indexPath) as! HomeCell
        cell.accessoryType = .disclosureIndicator
        cell.label.text = cells[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = cells[indexPath.row].controller.createController()
        show(controller, sender: nil)
    }

}
