//
//  ImagePickerView.swift
//  iOS2_CameraSample_0122
//
//  Created by cmStudent on 2025/05/09.
//

import SwiftUI
//
//  ImagePickerView.swift
//  iOS2_CameraSample_0122
//
//  Created by cmStudent on 2025/05/09.
//

import SwiftUI

// 用于在 SwiftUI 中使用 UIKit 的 UIImagePickerController
struct ImagePickerView: UIViewControllerRepresentable {
    
    // 控制是否显示图片选择器
    @Binding var isShowSheet: Bool
    
    // 存储拍摄或选取的图片
    @Binding var captureImage: UIImage?
    
    // 创建协调器，用于处理 UIKit 控制器的代理回调
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    // 创建 UIImagePickerController 控制器
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let myImagePickerController = UIImagePickerController()
        // 设置代理为自定义 Coordinator
        myImagePickerController.sourceType = .camera
        
        
        myImagePickerController.delegate = context.coordinator
        
        return myImagePickerController
    }
    
    // 更新视图控制器的状态，这里不需要处理
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // 此处不需要实现
    }
    
    // 内部协调器类，实现 UIImagePickerController 的代理方法
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        // 对应的父视图 ImagePickerView
        let parent: ImagePickerView
        
        // 初始化方法，注入父视图引用
        init(parent: ImagePickerView) {
            self.parent = parent
        }
        
        // 当用户选取了图片后调用
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let originalImage = info[.originalImage] as? UIImage {
                parent.captureImage = originalImage // 赋值给绑定变量
            }
            parent.isShowSheet = false // 关闭图片选择器
        }
        
        // 当用户取消选择时调用
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isShowSheet = false // 关闭图片选择器
        }
    }
}

