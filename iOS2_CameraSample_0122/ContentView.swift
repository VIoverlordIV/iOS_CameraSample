//
//  ContentView.swift
//  iOS2_CameraSample_0122
//
//  Created by cmStudent on 2025/05/09.
//

import SwiftUI
import PhotosUI
struct ContentView: View {
    @State var captureImage: UIImage? = nil
    @State var isShowSheet = false
    @State var isShowActivity = false
    @State var isPhotoLibrary = false
    @State var isShowAction = false
    @State var selectedItem: PhotosPickerItem?
    var body: some View {
        VStack {
            if let captureImage {
                Image(uiImage: captureImage)
                    .resizable()
                    .scaledToFit()
            }
            Spacer()
            Button {
//               if
//                UIImagePickerController
//                .isSourceTypeAvailable(.camera) {
//                   print("カメラOK")
//                   isShowSheet.toggle()
//               }else{}
                isShowSheet = true
            }label: {
                Text("画像選択")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .multilineTextAlignment(.center)
                    .background(Color.blue)
                    .foregroundColor(.white)
            }
            .sheet(isPresented: $isShowSheet){
                ImagePickerView(isShowSheet: $isShowSheet, captureImage: $captureImage)
            }
            .actionSheet(isPresented: $isShowAction){
                ActionSheet(title: Text("画像選択"),
                            message:Text("どちらか選んでください"),
                            buttons: [
                               
                                .default(Text("カメラ"),action:{ isPhotoLibrary = false
                                    isShowSheet = true
                                }),
                                .default(Text("フォトライブラリ"),action:{ isPhotoLibrary = true
                                    isShowSheet = false
                                }),
                                .cancel()
                            ])
            }
            .photosPicker(isPresented: $isPhotoLibrary, selection: $selectedItem)
            .onChange(of: selectedItem, {oldValue, newValue in
                Task{
                    guard let data  = try? await
                     newValue?.loadTransferable(type: Data.self)
                    else{return}
                    guard let uiImage = UIImage(data: data)
                    else {return}
                    captureImage = uiImage
                }
            })
            .padding()
            
            
            PhotosPicker(selection: $selectedItem){
                Image(systemName: "text.below.photo.fill")
            }
            
            
            Button {
                if captureImage != nil {
                    isShowActivity = true
                }
                
            }label: {
                Text("シェア")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .multilineTextAlignment(.center)
                    .background(Color.blue)
                    .foregroundColor(.white)
            }
            .sheet(isPresented: $isShowActivity) {
                if let image = captureImage {
                    ActivityView(shareItems: [image])
                } else {
                    Text("画像が選択されていません")
                }
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
