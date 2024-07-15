//
//  ImageCacheManager.swift
//  CityWeather
//
//  Created by 하연주 on 7/15/24.
//

import UIKit

final class ImageCacheManager {
    static let shared = ImageCacheManager()
    
    private let fileManager = FileManager.default
    private let cache = NSCache<NSString, UIImage>()
    private let cacheDirectory: URL
    
    private init() {
        // 캐시 디렉토리 설정
        let urls = fileManager.urls(for: .cachesDirectory, in: .allDomainsMask)
        cacheDirectory = urls[0].appendingPathComponent("weatherImage")
        
        print("cacheDirectory", cacheDirectory)
        // 캐시 디렉토리가 없다면 생성
        if !fileManager.fileExists(atPath: cacheDirectory.path) {
            try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true, attributes: nil)
        }
    }
    
    
    private func makeFileNameForSaving(urlString : String) -> String{
        return urlString.replacingOccurrences(of: "/", with: "-")
    }
    
    
    private func cachingImage(_ image: UIImage, forKey key: String) {
        // 메모리에 캐시
        cache.setObject(image, forKey: key as NSString)
        
        // 디스크에 저장
        //저장할 경로(파일명) 지정
        let fileURL = cacheDirectory.appendingPathComponent(makeFileNameForSaving(urlString: key))
        
        
        if let data = image.pngData(){

            do {
                try data.write(to: fileURL)
                print("디스크에 저장 완료")
            } catch {
                print("file save error", error)
            }
        }
    }
    
    
    private func returnCachedImage(forKey key: String) -> UIImage? {
        // 메모리에서 로드
        //1) 이미지를 네트워크에서 다운로드하기 전에 캐시된 이미지가 있는지 검색
        if let cachedImage = cache.object(forKey: key as NSString) {
            //2) 메모리에 캐시된 이미지가 있다면 -> 캐시된 이미지를 가져와서 imag 리턴
            return cachedImage
        }
        
        
        // 디스크에서 로드
        //3) 메모리에 캐시된 이미지가 없다면 -> filemanager에 저장된 이미지 있는지 검색
        let fileURL = cacheDirectory.appendingPathComponent(makeFileNameForSaving(urlString: key))
        if let data = try? Data(contentsOf: fileURL), let image = UIImage(data: data) {
            //4) 디스크 캐싱이 되어 있다면 -> 앱이 꺼지기 전까지 메모리에 캐싱해둘 수 있도록
            // 메모리에 캐싱
            cache.setObject(image, forKey: key as NSString)
            return image
        }
        
        //5) 메모리와 디스크 모두 캐싱되어 있지 않다면 nil 반환
        return nil
    }
    
    
    
    
    
    
    
    
    
    func loadImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        
        // 캐시에서 로드
        if let cachedImage = returnCachedImage(forKey: urlString) {
            print("캐싱된 이미지 있으니까 그걸로 로드")
            completion(cachedImage)
            return
        }
        
        // 네트워크에서 다운로드
        
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self, let data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            print("캐싱된 이미지 ❌  -> 네트워크 다운로드 -> 캐싱")
            
            // 캐시 저장
            self.cachingImage(image, forKey: urlString)
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
        task.resume()
    }
}
