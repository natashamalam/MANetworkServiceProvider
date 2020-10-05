//
//  TestServiceProviderViewController.swift
//  MANetworkServiceProvider
//
//  Created by Mahjabin Alam on 2020/10/05.
//

import UIKit

class TestServiceProviderViewController: UIViewController {

    let serviceProvider = MAServiceProvider.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()
        serviceProvider.get(fromRemoteURL: "https://jsonplaceholder.typicode.com/posts") { (completed, response) in
            if completed{
                for post in response.response{
                    if let title = post["title"]{
                        print("Title = \(title)")
                    }
                }
            }
        }
    }
    

}
