//
//  ContentView.swift
//  SavingImgCoreData
//
//  Created by Yusuke Tomatsu on 2020/10/01.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Saving.entity(), sortDescriptors:[
        NSSortDescriptor(keyPath: \Saving.username, ascending: true),
        NSSortDescriptor(keyPath: \Saving.imageD, ascending: true),
        NSSortDescriptor(keyPath: \Saving.favo, ascending: false),
        NSSortDescriptor(keyPath: \Saving.descriptions, ascending: true)
        ]
    ) var savings: FetchedResults<Saving>
    
    @State var image: Data = .init(count:0)
    @State var show = false
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false ){
            ForEach(savings,id:\.self){save in
                VStack(alignment: .leading){
                    Image(uiImage: UIImage(data: save.imageD ?? self.image)!)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width - 34, height: 210)
                        .cornerRadius(15)
                        
                    HStack{
                    Text("\(save.descriptions ?? "")")
                        Spacer()
                        Button(action:{
                            save.favo.toggle()
                            try? self.moc.save()
                        }){
                            
                        Image(systemName: save.favo ? "bookmark.fill":"bookmark")
                        }
                    }
                    Text("\(save.username ?? "")")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }.padding()
            }.navigationBarTitle("News",displayMode: .inline)
            .navigationBarItems(trailing: Button(action:{
                self.show.toggle()
            }){
              Image(systemName: "camera.fill")
            })
        }
        .sheet(isPresented: self.$show){
            SenderView().environment(\.managedObjectContext, self.moc)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
