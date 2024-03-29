//
//  Extension+UIImageView.swift
//  DotaCodable
//
//  Created by Admin on 12/1/21.
//

import UIKit


extension UserDefaults {
    private enum UserDefaultKeys: String {
        case switchIsOn
    }

    var switchIsOn:Bool {
        get {
            bool(forKey: UserDefaultKeys.switchIsOn.rawValue)
        }
        set {
            setValue(newValue, forKey: UserDefaultKeys.switchIsOn.rawValue)
        }
    }
}

extension UIImageView {
    func getImage(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200 else { return }
            guard let mimeType = response?.mimeType, mimeType.hasPrefix("image") else { return }
            guard let data = data, error == nil else { return }
            guard let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}


