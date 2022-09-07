//
//  AlertTrait.swift
//  Mars-Curiosity
//
//  Created by Tilek Sulaymanbekov on 6/9/22.
//

import UIKit

protocol AlertTrait: UIViewController {}

extension AlertTrait {
    
    func showErrorAlert(message: String, completion: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: completion))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
    func showShareActivity(with data: URL?) {
        let message = "Test message"
        if let link = data {
            let objectsToShare = [message, link] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            DispatchQueue.main.async {
                self.present(activityVC, animated: true)
            }
        }
    }
}
