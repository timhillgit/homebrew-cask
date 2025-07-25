cask "abbyy-finereader-pdf" do
  version "1402.19"
  sha256 :no_check

  url "https://downloads.abbyy.com/fr/fr_mac/current/ABBYY_FineReader_PDF.dmg?secure=5c11NlPrQmIZeGn6dK2PZA=="
  name "ABBYY FineReader PDF"
  desc "Scan, OCR, and convert documents to searchable PDFs and other formats"
  homepage "https://pdf.abbyy.com/finereader-pdf-for-mac/"

  livecheck do
    url "https://www.abbyy.com/finereader-pdf-mac-downloads/"
    regex(%r{>\s*Part\s+#:.*?<td>\s*v?(\d+(?:[./]\d+)+)\s*<}im)
    strategy :page_match do |page, regex|
      page.scan(regex).map { |match| match[0].tr("/", ".") }
    end
  end

  no_autobump! because: :requires_manual_review

  depends_on macos: ">= :big_sur"

  app "ABBYY FineReader PDF.app"

  zap trash: [
    "~/Library/Application Support/ABBYY",
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.abbyy.finereader.sfl*",
    "~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.abbyy.frpdfviewer.sfl*",
    "~/Library/Preferences/com.abbyy.finereader.pdf.plist",
    "~/Library/Preferences/com.abbyy.FineReader.plist",
    "~/Library/Preferences/com.abbyy.FRPDFViewer.plist",
    "~/Library/Preferences/com.abbyy.ImageProcessService*.plist",
    "~/Library/Saved Application State/com.abbyy.FineReader.savedState",
    "~/Library/Saved Application State/com.abbyy.FRPDFViewer.savedState",
  ]

  caveats do
    requires_rosetta
  end
end
