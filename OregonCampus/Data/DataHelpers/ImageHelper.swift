//
//  ImageHelper.swift
//  OregonCampus
//
//  Created by Oscar Epp on 4/14/24.
//

import UIKit
import Foundation

struct ImageHelper {
    static let shared = ImageHelper()
    
    private init() {}

    func saveImage(image: UIImage) -> Bool {
        guard let data = image.jpegData(compressionQuality: 1) else { return false }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else { return false }
        do {
            try data.write(to: directory.appendingPathComponent("userImage.jpg")!)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }

    func loadImage() -> UIImage? {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("userImage.jpg")
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
