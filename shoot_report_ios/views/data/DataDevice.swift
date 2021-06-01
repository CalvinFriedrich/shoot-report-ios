import SwiftUI

struct DataDevice: View {
    
    @State var device_data: String = ""
    
    var body: some View {
        Form {
            Section(header: Text(LocalizedStringKey("user_device_title"))) {
                VStack(alignment: .leading) {
                    Text(LocalizedStringKey("user_device_data"))
                    TextEditor(text: $device_data)
                        .onChange(of: device_data) { newValue in
                            UserDefaults.standard.set(newValue, forKey: "device_data")
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 300, maxHeight: 300)
                        .ignoresSafeArea(.keyboard)
                }
            }
            
        }
        .listStyle(GroupedListStyle())
        .gesture(DragGesture())
        .onAppear(perform: {
            self.device_data = UserDefaults.standard.string(forKey: "device_data") ?? ""
        })
    }
}

struct DataDevice_Previews: PreviewProvider {
    static var previews: some View {
        DataDevice()
    }
}
