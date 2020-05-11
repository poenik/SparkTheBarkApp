//
//  SegmentModel.swift
//  SparkTheBark
//
//  Created by Nicoleta Poenar on 4/25/20.
//

import Foundation
import Combine


/// Segment api object
struct Segment: Codable {
    let cardID: Int
    let shape: String?
    let id: Int
    let layout: String
    let level: Int
    let fontSize: Int?
    let font: String?
    let type: String
    let verticalPadding: Int?
    let cornerRadius: Int?
}

class SegmentViewModel: Identifiable, ObservableObject {

    private let segment: Segment
    var type: SegmentType {
        SegmentType(rawValue: segment.type) ?? .card
    }

    var id: Int {
        return segment.id
    }

    var layer: LayerLevel {
        return LayerLevel(rawValue: segment.level) ?? .first
    }

    var cardId: Int {
        return segment.cardID
    }

    var layout: LayoutType {
        return LayoutType(rawValue: segment.layout) ?? .overlay
    }


    init(_ segment: Segment) {
        self.segment = segment
    }
}

