//
//  FavouriteSwiftUI.swift
//  GIF App
//
//  Created by Apar256 on 26/06/22.
//

import SwiftUI
import Alamofire
import SwiftyJSON
import SDWebImageSwiftUI

struct FavouriteSwiftUI: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \GifData.title, ascending: true)],
        animation: .default)
    
    private var items: FetchedResults<GifData>
    
    var body: some View {
        NavigationView {
            List {
                if items.count > 0 {
                    ForEach(items.indices , id: \.self) { index in
                        if items[index].isFavourite {
                            HStack {
                               AnimatedImage(url:  URL(string: items[index].gifURL!))
                                        .onFailure {
                                            error in
                                            // Error
                                        }
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                    Text(items[index].title!)
                                    Spacer()
                                    Image(systemName: "star.fill").foregroundColor(.yellow)
                                
                            }.padding()

                        }
                    }
                } else {
                    Text("No GIF added to Favourite")
                }
                
            }.navigationTitle("Favourite")
        }
    }
}

struct FavouriteSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteSwiftUI()
    }
}
