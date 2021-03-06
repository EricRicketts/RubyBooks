#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
require 'spec_helper'

describe Ghee::API::Repos::Downloads do
  subject { Ghee.new(GH_AUTH).repos(GH_USER,GH_REPO) }


  describe "#repos(login,name)#downloads" do
    context "with a test download" do
      before :all do
        VCR.use_cassette "repos(login,name).downloads.create.test" do
          @download = subject.downloads.create(File.expand_path("../../../fyeah.jpg",__FILE__),"This is a test of the downloads api")
          @download.should_not be_nil
        end
      end
      let(:test_download) {@download}
      after :all do
        VCR.use_cassette "repos(login,name).downloads.delete" do
           subject.downloads(test_download["id"]).destroy
        end
      end

      it "should return a list of downloads" do
        VCR.use_cassette "repos#downloads#all" do 
          downloads = subject.downloads
          downloads.size.should > 0
          downloads.first["download_count"].should_not be_nil
        end
      end
      it "should return a single download" do
        VCR.use_cassette "repos#downloads#by_id" do 
          download = subject.downloads test_download["id"]
          download.should_not be_nil
          download["download_count"].should_not be_nil
        end
      end

      it "should have uploaded a file" do
        test_download["id"].should_not be_nil
        test_download["name"].should_not be_nil
        test_download["mime_type"].should_not be_nil
        test_download["policy"].should_not be_nil
        test_download["signature"].should_not be_nil
      end
    end

  end
end


