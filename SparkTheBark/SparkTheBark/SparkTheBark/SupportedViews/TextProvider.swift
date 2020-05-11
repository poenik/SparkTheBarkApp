//
//  TextProvider.swift
//  SparkTheBark
//
//  Created by Nicoleta Poenar on 4/28/20.
//

import Foundation

//protocol TextStruct: Decodable {}
//
//enum TextIdentifier: String, Decodable {
//    case title = "TITLE"
//    case subtitle = "SUBTITLE"
//    case description = "DESCRIPTION"
//
//    var metatype: TextStruct.Type {
//        switch self {
//        case .subtitle:
//            return SubtitleText.self
//        case .title:
//            return TitleText.self
//        case .description:
//            return DescriptionText.self
//        }
//    }
//
////    var viewType: some View {
////        switch self {
////        case .subtitle:
////            return AnyView(HomeView())
////        case .title:
////            return AnyView(ContainerView())
////        case .description:
////            return AnyView(MyProfileView())
////        }
////    }
//}
//
//struct TitleText: TextStruct {
//    private let imageURLString: String
//}
//
//struct SubtitleText: TextStruct {
//
//    struct Item: Decodable {
//        let imageURLString: String
//        let title: String
//        let subtitle: String
//    }
//
//    let sectionTitle: String
//    let list: [Item]
//}
//
//struct DescriptionText: TextStruct {
//
//    struct Item: Decodable {
//        let imageURLString: String
//        let text: String
//    }
//
//    let sectionTitle: String
//    let list: [Item]
//}
//
//final class AnyText: Decodable {
//
//    private enum CodingKeys: CodingKey {
//        case identifier
//    }
//
//    let text: TextStruct?
//
//    required init(from decoder: Decoder) throws {
//        do {
//            let container = try decoder.container(keyedBy: CodingKeys.self)
//            let type = try container.decode(TextIdentifier.self, forKey: .identifier)
//            self.text = try type.metatype.init(from: decoder)
//        } catch {
//            self.text = nil
//        }
//    }
//}
//
//struct Response: Decodable {
//
//    private enum CodingKeys: CodingKey {
//        case widgets
//    }
//
//    let widgets: [Widget]
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.widgets = try container.decode([AnyWidget].self, forKey: .widgets).compactMap { $0.widget }
//    }
//
//    init(widgets: [Widget]) {
//        self.widgets = widgets
//    }
//}
