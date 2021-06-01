import SwiftUI

struct MenuInformationView: View {
    
    @Environment(\.presentationMode) var presentationMode
        
    var body: some View {
        NavigationView {
            Form {
                Section(header:
                            Text(LocalizedStringKey("information_section_author"))
                            .foregroundColor(Color("accentColor"))
                            .bold()
                            .textCase(nil)) {
                    VStack(alignment: .leading) {
                        Text(LocalizedStringKey("information_section_author_title"))
                        Text(LocalizedStringKey("information_section_author_content"))
                            .foregroundColor(Color.gray)
                    }
                    VStack(alignment: .leading) {
                        Text(LocalizedStringKey("information_section_website_title"))
                        Link(LocalizedStringKey("information_section_website_content"), destination: URL(string: "https://www.burkhardt-sport.solutions")!)
                            .foregroundColor(Color.gray)
                    }
                }
                Section(header:
                            Text(LocalizedStringKey("information_section_version"))
                            .foregroundColor(Color("accentColor"))
                            .bold()
                            .textCase(nil)) {
                    VStack(alignment: .leading) {
                        Text(LocalizedStringKey("information_section_version_title"))
                        Text(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "")
                            .foregroundColor(Color.gray)
                    }
                    VStack(alignment: .leading) {
                        Text(LocalizedStringKey("information_section_build_title"))
                        Text(LocalizedStringKey("information_section_build_content"))
                            .foregroundColor(Color.gray)
                    }
                }
                Section(header:
                            Text(LocalizedStringKey("information_section_source"))
                            .foregroundColor(Color("accentColor"))
                            .bold()
                            .textCase(nil)) {
                    VStack(alignment: .leading) {
                        Text(LocalizedStringKey("information_section_source_content"))
                    }
                }
            }
            .navigationBarTitle(LocalizedStringKey("information_header"))
            .navigationBarItems(
                trailing:
                    Button(LocalizedStringKey("general_close"), action: {
                        presentationMode.wrappedValue.dismiss()
                    })
            )
        }
    }
}

struct Information_Previews: PreviewProvider {
    static var previews: some View {
        MenuInformationView()
    }
}
