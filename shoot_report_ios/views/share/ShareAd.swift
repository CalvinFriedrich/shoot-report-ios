import SwiftUI

struct ShareAd: View {
    
    let images = ["adFeinbauwerk", "adSauer", "adKoch", "adDisag", "adTechro"]
    @State var activeImageIndex = Int.random(in: 0..<2)
    let imageSwitchTimer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Image(uiImage: UIImage(named: images[activeImageIndex])!)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .onReceive(imageSwitchTimer) { _ in
                self.activeImageIndex = (self.activeImageIndex + 1) % self.images.count
            }
    }
}

struct ShareAd_Previews: PreviewProvider {
    static var previews: some View {
        ShareAd()
    }
}
