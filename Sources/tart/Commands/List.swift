import ArgumentParser
import Dispatch
import SwiftUI

struct List: AsyncParsableCommand {
  static var configuration = CommandConfiguration(abstract: "List created VMs")

  func run() async throws {
    do {
      print("Name\tSource")

      displayTable("local", try VMStorageLocal().list())
      displayTable("oci", try VMStorageOCI().list())

      Foundation.exit(0)
    } catch {
      print(error)

      Foundation.exit(1)
    }
  }

  private func displayTable(_ source: String, _ vms: [(String, VMDirectory)]) {
    for (name, _) in vms {
      print("\(source)\t\(name)")
    }
  }
}
