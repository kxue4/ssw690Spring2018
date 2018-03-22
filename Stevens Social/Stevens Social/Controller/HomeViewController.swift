//
//  HomeViewController.swift
//  Stevens Social
//
//  Created by Vincent Porta on 3/5/18.
//  Copyright © 2018 Stevens. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {

    @IBOutlet var postTableView: UITableView!
    
    //Has attribute of postBody
    var postArray:[Post] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do aUITableView setup after loading the view.
        
        postTableView.delegate = self
        postTableView.dataSource = self
        
        //fetch data from postArray
        self.fetchData()
        self.postTableView.reloadData()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
       // postTableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "postTableCell")
       // configureTableView()

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postcell", for: indexPath)
        //first post data will be stored into post
        let post = postArray[indexPath.row]
        cell.textLabel!.text = post.postBody!
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchData(){
        do{
            //fetch data from Post and put data in postArray
            postArray = try context.fetch(Post.fetchRequest())
        }catch{
            print(error)
        }
    }
    
    @IBAction func logOutPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
            print("signout successful")
        }
        catch {
            print("Error: there was a problem logging out")
        }
    }
    
    func configureTableView() {
        postTableView.rowHeight = UITableViewAutomaticDimension
        postTableView.estimatedRowHeight = 120.0
    }

}