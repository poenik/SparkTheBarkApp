//
//  ContentView.swift
//  SparkTheBark
//
//  Created by Nicoleta Poenar on 4/22/20.
//

import SwiftUI

enum SegmentType: String {
    case list = "list"
    case grid = "grid"
    case card = "card"
    case text = "text"
    case image = "image"
    case container = "container"

}

enum LayoutType: String {
    case vertical
    case horizontal
    case overlay
    case inherited
}

struct ContentView: View {
    @State private var selection = 0

    var body: some View {
        TabView(selection: $selection) {
            HomeView()
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("Home")
                    }.edgesIgnoringSafeArea(.bottom)
            }
            .tag(0)
            ContainerView()
            //MyProfileView()
            .tabItem {
                VStack {
                    Image(systemName: "person")
                    Text("My Profile")
                }
            }
            .tag(1)
        }
    }
}

struct TableView: View, Hashable {

    var body: some View {
        List {
            Text("first")
            Text("first")
        }
    }
}

struct ImageRow: View {
    var body: some View {
        var images: [[Int]] = []
        _ = (1...6)
            .publisher
            .collect(3)
            .collect()
            .sink(receiveValue: { images = $0})

        return ForEach(0..<images.count, id: \.self) { array in
            HStack {
                ForEach(images[array], id: \.self) { number in
                    Image("pic\(number)")
                        .resizable()
                        .scaledToFill()
                        .cornerRadius(10)
                }
            }
        }
    }
}

struct HomeView: View {
    var body: some View {
        ScrollView {
        Layout(type: .overlay) {
            customShape()
            Layout(type: .horizontal) {
                getText()
                getImage()
            }
        }
        //.frame(height: 800)
        .padding([.leading, .trailing], 10)
        .cornerRadius(30)
        .shadow(color: Color.black.opacity(0.4), radius: 7, x: 0, y: 2)
    }
    }
}

struct ListView: View {
    var body: some View {
        NavigationView {
            List {
                ImageRow()
            }.navigationBarTitle(Text("List"))
        }
    }
}

struct Layout<Content>: View where Content: View {
    let type: LayoutType
    let content: () -> Content

    init(type: LayoutType, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.type = type
    }

    var body: some View {
        Group {
            if type == .vertical {
                VStack {
                    content()
                }
            } else if type == .horizontal {
                HStack {
                    content()
                }
            } else if type == .overlay {
                ZStack {
                   content()
                }
            }
        }
    }
}


func getText() -> some View {
    return VStack(alignment: .center)  {
        Text("Welcome Cat")
            .font(Font.custom("Chalkduster", size: 35))
            .foregroundColor(Color.black.opacity(0.7))
            .padding([.leading, .trailing], 8)
            .multilineTextAlignment(.center)
        Text("Enroll today for free")
            .font(Font.custom("HelveticaNeue-Medium", size: 25))
            .foregroundColor(.white)
            .padding([.top, .bottom], 3)
            .padding(.leading, 14)
            .multilineTextAlignment(.center)
        Text("This offer is limited")
            .font(Font.custom("HelveticaNeue-Medium", size: 15))
            .foregroundColor(.white)
            .layoutPriority(-2)
            .padding(.leading, 5)
    }
}

func getImage() -> some View {
    Image("catButt")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .layoutPriority(-1)
        .padding(20)
        .frame(width:140, height: 140)
        .shadow(color: Color.black.opacity(0.4), radius: 7, x: 0, y: 2)
}

extension Color {
    static let oldPrimaryColor = Color(UIColor.systemIndigo)
    static let newPrimaryColor = Color("lightOrange")
}

struct MyProfileView: View, Hashable {
    var body: some View {
        NavigationView {
            ScrollView {
                Spacer()
                HomeView()
                ZStack {
                    //Ellipse()
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(Color("lightOrange"))
                    VStack {
                        Image("dog")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .layoutPriority(-1)
                            .shadow(color: Color.black.opacity(0.3), radius: 7, x: 0, y: 2)
                        Text("Play with Spookey")
                            .font(Font.custom("Chalkduster", size: 35))
                            .foregroundColor(Color.black.opacity(0.7))
                        Spacer(minLength: 20)
                        Button(action: {
                            print("Button action")
                        }) {
                            HStack {
                                Image(systemName: "play")
                                Text("Play")
                            }.frame(width: 80)
                        }.buttonStyle(GradientButtonStyle())
                    }
                    .frame(height: 300)
                }
                .frame(height: 400)
                .padding([.leading, .trailing], 10)
                .cornerRadius(30)
                .shadow(color: Color.black.opacity(0.4), radius: 7, x: 0, y: 2)
                .navigationBarTitle("My Activities", displayMode: .large)
            }
        }
    }
}

struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color("darkGreen")]), startPoint: .top, endPoint: .bottom))
            .cornerRadius(15.0)
            .shadow(color: Color.white.opacity(0.3), radius: 2, x: -3, y: -3)
            .shadow(color: Color.black.opacity(0.3), radius: 2, x: 2, y: 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class SegmentViewProvider: ObservableObject {

   static func viewForSegmentType(segmentType :SegmentType) -> AnyView {
        switch segmentType {
        case .list:
            return AnyView(MyProfileView())
        case .grid:
            return AnyView(TableView())
        case .card:
            return AnyView(customShape())
        case .text:
            return AnyView(Text("Text"))
        case .image:
            return AnyView(ImageView())
        case .container:
            return AnyView(Text("Ham"))
        }
    }
}
