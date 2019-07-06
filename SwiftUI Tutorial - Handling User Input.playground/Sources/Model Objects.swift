import Foundation
import CoreLocation
import SwiftUI
import UIKit
import Combine

public struct Coordinates: Hashable, Codable {
    public var latitude: Double
    public var longitude: Double
}

public struct Landmark: Hashable, Codable, Identifiable {
    public var id: Int
    public var name: String
    fileprivate var imageName: String
    fileprivate var coordinates: Coordinates
    public var state: String
    public var park: String
    public var category: Category
    public var isFavorite: Bool
    
    public var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }
    
    public func image(forSize size: Int) -> Image {
        ImageStore.shared.image(name: imageName, size: size)
    }
    
    public enum Category: String, CaseIterable, Codable, Hashable {
        case featured = "Featured"
        case lakes = "Lakes"
        case rivers = "Rivers"
        case mountains = "Mountains"
    }
}

public final class UserData: BindableObject {
    public let didChange = PassthroughSubject<UserData, Never>()
    
    public var showFavoritesOnly = false {
        didSet {
            didChange.send(self)
        }
    }
    public var landmarks: [Landmark] = [] {
        didSet {
            didChange.send(self)
        }
    }
    
    public init (landmarks: [Landmark]) {
        self.landmarks = landmarks
    }
}
