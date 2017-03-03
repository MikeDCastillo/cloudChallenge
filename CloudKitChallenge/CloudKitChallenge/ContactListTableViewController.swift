//
//  ContactListTableViewController.swift
//  CloudKitChallenge
//
//  Created by Michael Castillo on 3/3/17.
//  Copyright © 2017 Michael Castillo. All rights reserved.
//

import UIKit


//MARK: -  Properties/ life - cycle func
class ContactListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        ContactController.loadContact { (contacts) in
            self.contacts = contacts
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var contacts: [Contact] = []
  
}


// MARK: - Table view data source

extension ContactListTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return contacts.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        let contact = contacts[indexPath.row]
        cell.textLabel?.text = contact.name
        
        return cell
    }
    
    
}


// MARK: - Delete Func

extension ContactListTableViewController {
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let contact =  contacts[indexPath.row]
            guard let contactToDelete = contact.cloudKitRecordID else { return }
           ContactController.deleteRecordWithID(contactToDelete, completion: { (records, error) in
        
            if let error = error {
                print(error.localizedDescription)
            }
        //completion:
           })
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


}


// MARK: - Navigation

extension ContactListTableViewController {

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
