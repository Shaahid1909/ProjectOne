//
//  HomeViewController.swift
//  projectOne
//
//  Created by Admin Mac on 12/02/21.
//

import UIKit
import FirebaseFirestore


class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    var tasksel = [TaskList]()
    var iden = [String]()
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var tabView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        db.collection("TaskList").getDocuments() { (querySnapshot, error)
            in
            if let error = error {
                print("Error getting documents: \(error)")
                                } else {
                for document in querySnapshot!.documents {
                                        
                let documentData = document.data()
                    
                let tl = documentData["Taskname"] as! String
                let stat = documentData["Status"] as! String
                let dID = document.documentID
                self.iden.append(dID)
                self.tasksel.append(TaskList(name: tl,status: stat,id: document.documentID))
               }
          self.tabView.reloadData()
          }
           
        }
        self.tabView.delegate = self
        self.tabView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func AddTask(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Task", message: "", preferredStyle: UIAlertController.Style.alert)
                
        let action = UIAlertAction(title: "Add Task", style: UIAlertAction.Style.default) { (action) in
                    //what will happen once the user clicks the add task button on our alert
            let task = TaskList(name: textField.text!)

            self.db.collection("TaskList").addDocument(data: ["Taskname" : textField.text,"Status":"pending"])
                    print(textField.text)
                   
                    self.tasksel.append(task)
                    self.tabView.reloadData()
      
                }
                alert.addTextField { (alertTextField) in
                    alertTextField.placeholder = "Create new task"
                    textField = alertTextField
                }
                
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
    
    @objc func cellbtntapped(sender:UIButton){
        let tag = sender.tag
        let indexPath = IndexPath(row: tag, section: 0)
        let id = iden[indexPath.row]
        if sender.isSelected{
             sender.isSelected = false
            sender.setImage(#imageLiteral(resourceName: "Unchecked"), for: .normal)
            print("Checked Deselected")
            db.collection("TaskList").document(id).updateData(["Status" : "pending"])
            
        }else{
        
           sender.isSelected = true
        //    self.selected_checked.append(id)
           sender.setImage(#imageLiteral(resourceName: "Checked"), for: .normal)
            print("Checked Selected")
            //
            db.collection("TaskList").document(id).updateData(["Status" : "complete"])
            
            
          }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabView.dequeueReusableCell(withIdentifier: "task", for: indexPath) as! TaskCell
        cell.taskname.text = tasksel[indexPath.row].name
        cell.taskCheck.tag = indexPath.row
        cell.taskCheck.addTarget(self, action: #selector(cellbtntapped(sender:)), for: .touchUpInside)
        
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            // remove the item from the data model
            tasksel.remove(at: indexPath.row)
       
            // delete the table view row
            tabView.deleteRows(at: [indexPath], with: .fade)
            
            db.collection("TaskList").document().delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
         


        }
    }

}

struct TaskList{
    var name: String?
    var status: String?
    var id: String?
}
