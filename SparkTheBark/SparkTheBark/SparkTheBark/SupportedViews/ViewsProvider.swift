//
//  SegmentsProvider.swift
//  SparkTheBark
//
//  Created by Nicoleta Poenar on 4/25/20.
//

import Foundation
import Combine
import SwiftUI

typealias buildingBlocks = (ContainerType, EmbeddedType)

enum LayerLevel: Int {
    case first
    case second
    case third
}

enum ContainerType: String {
    case zStack
    case scrollView
    case list
    case vStack
    case hStack
    case image
    case card
    case text
    case shape
    case spacer
}

enum EmbeddedType: String {
    case zStack
    case shape
    case list
    case vStack
    case hStack
    case image
    case card
    case text
    case spacer
}

struct SegmentTextModel {


}

struct SegmentTextViewProvider {

}

struct ContainerViewModelProvider {

}

struct Layer: Identifiable {

    var id = UUID()
    var level: LayerLevel
    var type: LayoutType

}

struct TopLevelView: View {
    var segment: SegmentViewModel
    var body: some View {
        SecondLevelView(segment: self.segment)
    }
}

struct SecondLevelView: View {
    var segment: SegmentViewModel
    var body: some View {
        Layers(segment: segment) {
            SegmentViewProvider.viewForSegmentType(segmentType: self.segment.type)
            ThirdLevelView(segment: self.segment)
            //ImageView()
        }
    }
}

struct TitleTextView: View {
    var body: some View {
        Text("Welcome Cat")
            .font(Font.custom("Chalkduster", size: 35))
            .foregroundColor(Color.black.opacity(0.7))
            .padding([.leading, .trailing], 8)
            .multilineTextAlignment(.center)
    }
}
struct DescriptionTextView: View {
    var body: some View {
        Text("Enroll today for free")
            .font(Font.custom("HelveticaNeue-Medium", size: 25))
            .foregroundColor(.white)
            .padding([.top, .bottom], 3)
            .padding(.leading, 14)
            .multilineTextAlignment(.center)
    }
}

struct InfoText: View {
    var body: some View {
        Text("This offer is limited")
            .font(Font.custom("HelveticaNeue-Medium", size: 15))
            .foregroundColor(.white)
            .layoutPriority(-2)
            .padding(.leading, 5)
    }
}
struct ThirdLevelView: View {
    var segment: SegmentViewModel
    var body: some View {
        Layers(segment: segment) {
           SegmentViewProvider.viewForSegmentType(segmentType: self.segment.type)

        }
    }
}

struct ImageView: View {
    var body: some View {
        Image("catButt")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .layoutPriority(-1)
            .padding(10)
            .frame(width:140, height: 140)
            .shadow(color: Color.black.opacity(0.4), radius: 7, x: 0, y: 2)
    }
}

struct Layers<Content>: View where Content: View {
    //let type: LayoutType
    let content: () -> Content
    private var segment: SegmentViewModel

    init(segment: SegmentViewModel, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.segment = segment
    }


    var body: some View {
        Group {
            if segment.layer == .first {
                Layout(type: segment.layout) {
                    self.content()
                }
            }
            if segment.layer == .second {
                Layout(type: segment.layout) {
                    self.content()
                }
            }
            if segment.layer == .third {
                Layout(type:segment.layout) {
                    self.content()
                }
            }
        }
    }
}


struct ContainerView: View {
    @ObservedObject private var viewModel = SegmentsViewModel()

    var body: some View {
        ZStack {
            ForEach(self.viewModel.segmentsViewModels, id: \.id) { segment in
                Group {
                    buildView(segment)
                }
            }
        }.onAppear {
            self.viewModel.fetchSegments()
        }
        .frame(height: 200)
        .padding([.leading, .trailing], 10)
        .cornerRadius(25)
        .shadow(color: Color.black.opacity(0.4), radius: 7, x: 0, y: 2)
    }
}



struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
     HomeView()
    }
}

typealias SegmentInfo = (Int, SegmentType, LayoutType)

func buildView(_ segment: SegmentViewModel) -> some View {
    let segmentInfo = SegmentInfo(segment.id, segment.type, segment.layout)

    /// We make our own rules
    switch segmentInfo {
    case (1, .card, .overlay):
        return AnyView(customShape())
    case (3, .text, .vertical):
        return AnyView(customShape())
    case (1, .text, .vertical):
        return AnyView(Text(""))
    case (5, .image, .inherited):
        return AnyView(ListView())
    default:
        return AnyView(Text(""))
    }
}


struct CustomizableView<Content: View>: View {
    var segment: SegmentViewModel

    let content: () -> Content

    init(segment: SegmentViewModel, @ViewBuilder content: @escaping () -> Content) {
        self.segment = segment
        self.content = content
    }
    var body: some View {
        Group {
            Layers(segment: segment) {
                self.content()
                Layers(segment: self.segment) {
                    self.content()
                }
                Layers(segment: self.segment) {
                    self.content()
                }
            }
        }
    }
}

//struct ImageAndText: View {
//    var imageLayout: LayoutType
//    var textLayout: LayoutType
//    var textType: TextType
//    var body: some View {
//        Layout(type: imageLayout) {
//            TextBuildingBlock(layout: self.textLayout, textType: self.textType)
//            ImageView()
//        }
//    }
//}

enum TextType {
    case v1
    case v2
    case v3
}

//struct TextBuildingBlock: View {
//    var layout: LayoutType
//    var textType: TextType
//    
//    var body: some View {
//        Group {
//            if textType == .v1 {
//                Layout(type: layout) {
//                    TitleText()
//                }
//            }
//            if textType == .v2 {
//                Layout(type: layout) {
//                    TitleText()
//                    DescriptionText()
//                }
//            }
//            if textType == .v3 {
//                Layout(type: layout) {
//                    TitleText()
//                    DescriptionText()
//                    InfoText()
//                }
//            }
//        }
//    }
//}

struct CustomizableView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView(destinationView: Text(""))
    }
}

struct FirstView<Content: View>: View {
    private var destinationView: Content

    init(destinationView: Content) {
        self.destinationView = destinationView
    }

    var body : some View {
        destinationView
    }
}

struct SecondView<Content>: View where Content: View {
    //let type: LayoutType
    let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    var body: some View {
     content()
    }
}

struct ThirdView<Content>: View where Content: View {
    //let type: LayoutType
    let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    var body: some View {
     content()
    }
}


