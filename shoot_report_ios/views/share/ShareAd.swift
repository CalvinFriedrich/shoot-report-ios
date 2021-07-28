import SwiftUI

struct ShareAd: View {
    
    @State var activeImageIndex = Int.random(in: 0..<2)
    
    let images = ["adFeinbauwerk", "adSauer", "adKoch", "adDisag", "adTechro"]
    let imageSwitchTimer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack {
            Image(uiImage: UIImage(named: images[activeImageIndex])!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 50)
                .onReceive(imageSwitchTimer) { _ in
                    self.activeImageIndex = (self.activeImageIndex + 1) % self.images.count
                }
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity
        )
        .background(Color("partnerColor"))
    }
}

struct ShareAd_Previews: PreviewProvider {
    static var previews: some View {
        ShareAd()
    }
}
