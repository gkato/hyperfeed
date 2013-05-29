require 'spec_helper'

describe Hyperfeed do

  let(:url) { "http://quatrorodas.abril.com.br/lst_mob.xml" }
  #let(:url_page) { "http://quatrorodas.abril.com.br/lst_mob.xml?page=2" }
  #let(:url_per_page) { "http://quatrorodas.abril.com.br/lst_mob.xml?per_page=20" }
  let(:resource_id) {"f91f93b7061233a9c13c20376c450012"}

  context "with response code equal 200" do
    before do
      register_uri(:get, url, :body => fixture("lst_mob.xml"))
    end

    subject { Hyperfeed::Client.at(url) }
    its(:code) { should == 200}

    context "get" do
      def subject
        super.get
      end
      its(:per_page)      { should == 10 }
      its(:current_page)  { should == 1 }
      its(:total_pages)   { should == 35 }
      its(:total_results) { should == 350 }

      context "#result" do
        def subject
          super.result.first
        end

        its(:id)      { should == "f91f93b7061233a9c13c20376c450012" }
        its(:pubdate) { should == "10/05/2013" }
        its(:title)   { should == "BMW e maior marca do mundo, diz Forbes" }
        its(:source)  { should == "QUATRO RODAS" }
      end
    end

  end

  context "with per_page param" do
    before do
      register_uri(:get, url, :body => fixture("lst_mob.xml"))
    end

    subject { Hyperfeed::Client.at(url, :per_page => 20).get }
    its(:per_page)      { should == 20 }
    it { subject.result.size.should == 20 }
    its(:current_page)  { should == 1 }
    its(:total_pages)   { should == 18 }
    its(:total_results) { should == 350 }
  end

  context "with page param" do
    before do
      register_uri(:get, url, :body => fixture("lst_mob.xml"))
    end

    subject { Hyperfeed::Client.at(url, :page => 2).get }
    its(:per_page)      { should == 10 }
    its(:current_page)  { should == 2 }
    its(:total_pages)   { should == 35 }
    its(:total_results) { should == 350 }
  end

  context "with item" do
    before do
      register_uri(:get, url, :body => fixture("lst_mob.xml"))
    end

    subject { Hyperfeed::Client.at(url).get(resource_id) }
    its(:title)     { should == "BMW e maior marca do mundo, diz Forbes" }
    its(:id)        { should == "f91f93b7061233a9c13c20376c450012" }
    its(:subtitle)  { should == "Empresa e a unica montadora no top 10" }
    its(:category)  { should == "mercado" }
    its(:author)    { should == "Vitor Matsubara" }
    its(:enclosure) { should be_a Array }

    context "item enclosure" do
      def subject
        super.enclosure
      end
      its(:size)   { should == 1 }

      it { subject.first.url.should == "http://quatrorodas.abril.com.br/100513_bmw1.jpg" }
      it { subject.first.type.should == "image/jpeg" }
      it { subject.first.title.should == "BMW e maior marca do mundo, diz Forbes" }
    end
  end

  context "with non valid id" do
    before do
      register_uri(:get, url, :body => fixture("lst_mob.xml"))
    end

    subject { Hyperfeed::Client.at(url).get("nonVALIDid") }

    it { should == nil }
  end
end
