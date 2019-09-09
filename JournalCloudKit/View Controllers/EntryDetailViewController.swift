//
//  EntryDetailViewController.swift
//  JournalCloudKit
//
//  Created by Lewis Jones on 09/03/2019.
//  Copyright © 2019 Rodrigo. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var entry: Entry? {
        didSet {
            loadViewIfNeeded()
            updateView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateView() {
        titleTextField.text = entry?.title
        bodyTextView.text = entry?.body
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let title = titleTextField.text,
            let body = bodyTextView.text else { return }
        if let entry = entry {
            
            EntryController.shared.updateEntry(entry: entry, title: title, body: body) { (success) in
                if success {
                    print("Success updating Entry")
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                } else {
                    print("Failure updating entry")
                }
            }
            
        } else {
            
            EntryController.shared.addEntryWith(title: title, body: body) { (success) in
                if success {
                    print("Success creating new entry")
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                } else {
                    print("Failure creating new entry")
                }
            }
        }
    }
}
