//
//  PrimaryViews.swift
//  SparkTheBark
//
//  Created by Nicoleta Poenar on 4/25/20.
//

import SwiftUI

struct PrimaryViews: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PrimaryViews_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryViews()
    }
}

public struct customShape: View {
    public var body: some View {
        RoundedRectangle(cornerRadius: 25, style: .continuous)
            .fill(Color(red: 43/255, green: 175/255, blue: 187/255))
    }
}

public struct header: View {
    public var body: some View {
        HStack {
            ImageView()
            VStack {
                customShape()
            }
        }
    }
}

public struct button: View {
    public var body: some View {
        Button(action: {
            print("Button action")
        }) {
            HStack {
                Image(systemName: "play")
                Text("Play")
            }.frame(width: 80)
        }.buttonStyle(GradientButtonStyle())
    }
}




struct CustomShape_Previews: PreviewProvider {
    static var previews: some View {
        customShape()
    }
}

//class PrimaryTypes {
//    static func text(text: String, font: Font, fontSize: CGFloat, color: Color, verticalPadding: CGFloat, layoutPriority: Double) -> Text {
//        return Text(text)
//            .font(font)
//            .foregroundColor(Color.black.opacity(0.7))
//            .padding([.leading, .trailing], 8)
//            .multilineTextAlignment(.center)
//
//    }
//}

protocol Widget: Decodable {}

enum WidgetIdentifier: String, Decodable {
    case banner = "BANNER"
    case collection = "COLLECTION"
    case list = "LIST"

    var metatype: Widget.Type {
        switch self {
        case .banner:
            return BannerWidget.self
        case .collection:
            return CollectionWidget.self
        case .list:
            return ListWidget.self
        }
    }

    var viewType: some View {
        switch self {
        case .banner:
            return AnyView(HomeView())
        case .collection:
            return AnyView(ContainerView())
        case .list:
            return AnyView(MyProfileView())
        }
    }
}

struct BannerWidget: Widget {
    private let imageURLString: String
}

struct CollectionWidget: Widget {

    struct Item: Decodable {
        let imageURLString: String
        let title: String
        let subtitle: String
    }

    let sectionTitle: String
    let list: [Item]
}

struct ListWidget: Widget {

    struct Item: Decodable {
        let imageURLString: String
        let text: String
    }

    let sectionTitle: String
    let list: [Item]
}

final class AnyWidget: Decodable {

    private enum CodingKeys: CodingKey {
        case identifier
    }

    let widget: Widget?

    required init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let type = try container.decode(WidgetIdentifier.self, forKey: .identifier)
            self.widget = try type.metatype.init(from: decoder)
        } catch {
            self.widget = nil
        }
    }
}

struct HomeResponse: Decodable {

    private enum CodingKeys: CodingKey {
        case widgets
    }

    let widgets: [Widget]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.widgets = try container.decode([AnyWidget].self, forKey: .widgets).compactMap { $0.widget }
    }

    init(widgets: [Widget]) {
        self.widgets = widgets
    }
}
