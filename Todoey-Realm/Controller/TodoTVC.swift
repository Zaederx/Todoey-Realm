//
//  ViewController.swift
//  Todoey-Realm
//
//  Created by Zachary Ishmael on 10/09/2019.
//  Copyright © 2019 Zachary Ishmael. All rights reserved.
//

import UIKit
import SwipeCellKit
import RealmSwift

class TodoTVC: UITableViewController {
    //MARK: - Variable and Constant Declarations
    var todos:Results<Todo>?
    let realm = try! Realm()
    
    //MARK: - VIEW LOADING SETUP
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTodos()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        // Do any additional setup after loading the view.
    }

    //MARK:- TableView Override Precusor Code
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as? SwipeTableViewCell ?? SwipeTableViewCell()
        cell.textLabel?.text = todos?[indexPath.row].name ?? "No Todos"
        cell.accessoryType = .disclosureIndicator
        cell.delegate = self

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tableView didSelectRowAt and performed Segue")
        performSegue(withIdentifier: "toItemsTVC", sender: self)
        print("tableView didSelectRowAt and performed Segue")//might not work because segue triggered new call to other class
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ItemTVC
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.todo = todos?[indexPath.row]
        }
        print("Segue prepared")
    }
   
    //MARK: - Realm Data FunctionS for CRUD

    func loadTodos () {
        todos = realm.objects(Todo.self)
        tableView.reloadData()
    }
    
    func saveTodo(with todo: Todo) {
        do {
            try realm.write {
                realm.add(todo)
            }
        } catch {
            print("Error saving Todos: \(error)")
        }
        print("Todo Saved")
        tableView.reloadData()
    }
    
    func deleteTodo(with indexPath: IndexPath){
        realm.delete((todos?[indexPath.row])!)
        print("Todo deleted")
    }
}

    //MARK: - SwipeTableCellDelegate
extension TodoTVC: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else {return nil}
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.deleteTodo(with:indexPath)
        }
        return [deleteAction]
    }
    
}
