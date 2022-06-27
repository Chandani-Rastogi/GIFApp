//
//  HomeView.swift
//  GIF App
//
//  Created by Apar256 on 26/06/22.
//

import SwiftUI
import Alamofire
import SwiftyJSON
import SDWebImageSwiftUI

struct HomeView: View {
    @State var didAppear = false
    @State var appearCount = 0
    
    @Environment(\.managedObjectContext) private var managedObjectContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \GifData.title, ascending: true)],
        animation: .default)
    
    private var items: FetchedResults<GifData>
    @State var gifListResponse : [GIF] = []
    
    var body: some View {
        NavigationView {
            List {
                if items.count > 0 {
                    ForEach(items.indices , id: \.self) { index in
                            HStack {
                                // for laoding GIFs
                                AnimatedImage(url:  URL(string: items[index].gifURL!))
                                    .onFailure {
                                        error in
                                        // Error
                                    }
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                // display gif  title
                                Text(items[index].title!)
                                Spacer()
                                // image to display favourite items 
                                Image(systemName: items[index].isFavourite  ? "star.fill"  : "star").foregroundColor(.yellow).onTapGesture {
                                    if !items[index].isFavourite {
                                        items[index].isFavourite = true
                                    }else {
                                        items[index].isFavourite = false
                                    }
                                    self.saveContext()
                                }
                            }.padding()
                        }
                    }
            }.onAppear(perform: onLoad)
            .navigationTitle("GIF List")
        }
    }
    
    func onLoad() {
            if !didAppear {
                appearCount += 1
                if items.count == 0 {
                    self.getGIFList()
                }
                //This is where I loaded API data information
            }
            didAppear = true
        }
    
    
    func getGIFList() {
        NetworkManager.shared.getAllGIFList( completion: {(response , error) in
            if error == nil , let value = response {
                self.gifListResponse.removeAll()
                let responseDict = JSON(value)
                if let dataresponse = (responseDict["data"].arrayObject) as? [[String:Any]] {
                    for data in dataresponse {
                         /* ----- show on UI ------ */
                        let obj = GIF(fromDictionary:data)
                        self.gifListResponse.append(obj)
                        /* ----- save in CoreData ------ */
                        let gifData = GifData(context: managedObjectContext)
                        gifData.title = obj.title
                        gifData.gifURL = obj.images.downsized.url
                        gifData.gidID = obj.id
                        gifData.isFavourite = false
                        
                    }
                }
                saveContext()
            }
        })
    }
    // save data into coredata
    func saveContext() {
      do {
        try managedObjectContext.save()
      } catch {
        print("Error saving managed object context: \(error)")
      }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


