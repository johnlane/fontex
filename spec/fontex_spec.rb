
load '../fontex'

require'tmpdir'
require'fileutils'

describe "Fontex" do
  before(:each) do
    @dir = Dir.mktmpdir
  end
  after(:each) do
    FileUtils.rm_rf @dir
  end
    
  it "extracts two woff fonts from css-tricks.com" do
    expect(decode(@dir,["http://cloud.typography.com/610186/691184/css/fonts.css", "referer=http://css-tricks.com/forums/topic/font-face-in-base64-is-cross-browser-compatible/"])).to eq(["#{@dir}/gotham_rounded_a-500.woff","#{@dir}/gotham_rounded_b-500.woff"])
    expect(`file #{@dir}/gotham_rounded_a-500.woff`.chomp).to eq("#{@dir}/gotham_rounded_a-500.woff: Web Open Font Format, flavor 1330926671, length 15604, version 1.0")
    expect(`file #{@dir}/gotham_rounded_b-500.woff`.chomp).to eq("#{@dir}/gotham_rounded_b-500.woff: Web Open Font Format, flavor 1330926671, length 6148, version 1.0")
  end

  it "extracts two woff fonts from local css-tricks.com.woff.css" do
    # file downloaded as (refferrer)
    # wget --referer='http://css-tricks.com/forums/topic/font-face-in-base64-is-cross-browser-compatible/' http://cloud.typography.com/610186/691184/css/fonts.css
    expect(decode(@dir,["css/css-tricks.com.woff.css"])).to eq(["#{@dir}/gotham_rounded_a-500.woff","#{@dir}/gotham_rounded_b-500.woff"])
    expect(`file #{@dir}/gotham_rounded_a-500.woff`.chomp).to eq("#{@dir}/gotham_rounded_a-500.woff: Web Open Font Format, flavor 1330926671, length 15604, version 1.0")
    expect(`file #{@dir}/gotham_rounded_b-500.woff`.chomp).to eq("#{@dir}/gotham_rounded_b-500.woff: Web Open Font Format, flavor 1330926671, length 6148, version 1.0")
  end

  it "extracts two otf fonts from local css-tricks.com.otf.css" do
    # file downloaded as (referrer + user agent)
    # wget --referer='http://css-tricks.com/forums/topic/font-face-in-base64-is-cross-browser-compatible/' http://cloud.typography.com/610186/691184/css/fonts.css -U 'Mozilla/5.0 (X11; Linux x86_64; rv:30.0) Gecko/20100101 Firefox/30.0'
    expect(decode(@dir,["css/css-tricks.com.otf.css"])).to eq(["#{@dir}/gotham_rounded_a-500.otf","#{@dir}/gotham_rounded_b-500.otf"])
    expect(`file #{@dir}/gotham_rounded_a-500.otf`.chomp).to eq("#{@dir}/gotham_rounded_a-500.otf: OpenType font data")
    expect(`file #{@dir}/gotham_rounded_b-500.otf`.chomp).to eq("#{@dir}/gotham_rounded_b-500.otf: OpenType font data")
  end

  it "extracts three woff fonts from http://basecamp.com" do
    expect(decode(@dir,["http://www.basecamp.com"])).to eq(["#{@dir}/proxima_nova.woff","#{@dir}/proxima_nova-italic.woff","#{@dir}/proxima_nova-bold.woff"])
    expect(`file #{@dir}/proxima_nova.woff`.chomp).to eq("#{@dir}/proxima_nova.woff: Web Open Font Format, flavor 65536, length 23860, version 1.0")
    expect(`file #{@dir}/proxima_nova-bold.woff`.chomp).to eq("#{@dir}/proxima_nova-bold.woff: Web Open Font Format, flavor 65536, length 24188, version 1.0")
    expect(`file #{@dir}/proxima_nova-italic.woff`.chomp).to eq("#{@dir}/proxima_nova-italic.woff: Web Open Font Format, flavor 65536, length 26132, version 1.0")
  end

  # file downloaded as
  # wget https://d1pqgpjinf0thr.cloudfront.net/assets/main-ba90ebfb39f0038852433a3d1bf4dc60.css -O basecamp.css
  it "extracts three woff fonts from local basecamp.css" do
    expect(decode(@dir,["css/basecamp.css"])).to eq(["#{@dir}/proxima_nova.woff","#{@dir}/proxima_nova-italic.woff","#{@dir}/proxima_nova-bold.woff"])
    expect(`file #{@dir}/proxima_nova.woff`.chomp).to eq("#{@dir}/proxima_nova.woff: Web Open Font Format, flavor 65536, length 23860, version 1.0")
    expect(`file #{@dir}/proxima_nova-bold.woff`.chomp).to eq("#{@dir}/proxima_nova-bold.woff: Web Open Font Format, flavor 65536, length 24188, version 1.0")
    expect(`file #{@dir}/proxima_nova-italic.woff`.chomp).to eq("#{@dir}/proxima_nova-italic.woff: Web Open Font Format, flavor 65536, length 26132, version 1.0")
  end

  # file downloaded unknown
  it "extracts four woff fonts from local ruble_arial.css" do
    expect(decode(@dir,["css/ruble_arial.css"])).to eq(["#{@dir}/ruble_arial.woff","#{@dir}/ruble_arial-bold.woff","#{@dir}/ruble_arial-italic.woff","#{@dir}/ruble_arial-bold-italic.woff"])
    expect(`file #{@dir}/ruble_arial.woff`.chomp).to eq("#{@dir}/ruble_arial.woff: Web Open Font Format, flavor 65536, length 1644, version 1.0")
    expect(`file #{@dir}/ruble_arial-italic.woff`.chomp).to eq("#{@dir}/ruble_arial-italic.woff: Web Open Font Format, flavor 65536, length 1664, version 1.0")
    expect(`file #{@dir}/ruble_arial-bold.woff`.chomp).to eq("#{@dir}/ruble_arial-bold.woff: Web Open Font Format, flavor 65536, length 1676, version 1.0")
    expect(`file #{@dir}/ruble_arial-bold-italic.woff`.chomp).to eq("#{@dir}/ruble_arial-bold-italic.woff: Web Open Font Format, flavor 65536, length 1712, version 1.0")
  end

  # file downloaded as
  # wget https://assets.digital.cabinet-office.gov.uk/static/fonts-607c54f71c7c1f98257595cedaa13a34.css -O nta.css
  it "extracts three woff fonts from local nta.css" do
    expect(decode(@dir,["css/nta.css"])).to eq(["#{@dir}/nta.woff","#{@dir}/nta-bold.woff","#{@dir}/ntatabularnumbers.woff", "#{@dir}/ntatabularnumbers-bold.woff"])
    expect(`file #{@dir}/nta.woff`.chomp).to eq("#{@dir}/nta.woff: Web Open Font Format, flavor 65536, length 95856, version 2012.0")
    expect(`file #{@dir}/nta-bold.woff`.chomp).to eq("#{@dir}/nta-bold.woff: Web Open Font Format, flavor 65536, length 72644, version 2012.0")
    expect(`file #{@dir}/ntatabularnumbers.woff`.chomp).to eq("#{@dir}/ntatabularnumbers.woff: Web Open Font Format, flavor 65536, length 14388, version 1.2")
    expect(`file #{@dir}/ntatabularnumbers-bold.woff`.chomp).to eq("#{@dir}/ntatabularnumbers-bold.woff: Web Open Font Format, flavor 65536, length 9672, version 1.0")
  end

end
