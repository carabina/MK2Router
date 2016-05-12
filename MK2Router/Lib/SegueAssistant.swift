//
//  SegueAssistant.swift
//  MK2Router
//
//  Created by k2o on 2016/05/12.
//  Copyright © 2016年 Yuichi Kobayashi. All rights reserved.
//

import UIKit

/// prepareForSegue の代行を行う.
class SegueAssistant {
    private (set) var segue: UIStoryboardSegue
    private (set) var sender: AnyObject?
    
    init(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.segue = segue
        self.sender = sender
    }
    
    func prepareIfIdentifierEquals<DestinationVC where DestinationVC: Destination, DestinationVC: UIViewController>(
        identifier: String,
        @noescape contextForDestination: ((DestinationVC) -> DestinationVC.Context)
    ) {
        if self.segue.identifier != identifier {
            return
        }
        
        let _destinationViewController: UIViewController?
        if let navigationController = self.segue.destinationViewController as? UINavigationController {
            _destinationViewController = navigationController.topViewController
        } else {
            _destinationViewController = self.segue.destinationViewController
        }
        
        guard let destinationViewController = _destinationViewController as? DestinationVC else {
            return		// FIXME: debug message
        }
        
        let context = contextForDestination(destinationViewController)
        destinationViewController.context = context
    }
}