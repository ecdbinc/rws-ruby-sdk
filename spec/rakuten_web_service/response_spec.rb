require 'spec_helper'

describe RakutenWebService::Response do

  describe "#genre_information" do
    subject { RakutenWebService::Response.new(RWS::Ichiba::Item, json).genre_information }

    context "When the response has no GenreInformation key" do
      let(:json) { {} }

      it { is_expected.to be_nil }
    end

    context "When GenreInformation is empty" do
      let(:json) { { 'GenreInformation' => [] } }

      it { is_expected.to be_nil }
    end

    context "When GenreInformation is given" do
      let(:json) do
        {
          'GenreInformation' => [
            {
              'ancestors' => [],
              'genre' => { 'genreId' => 100316, 'nameJa' => '水・ソフトドリンク', 'level' => 1, 'itemCount' => 9588 },
              'children' => [
                { 'genreId' => 201351, 'nameJa' => '水・炭酸水', 'level' => 2, 'itemCount' => 192 }
              ]
            }
          ]
        }
      end

      it { is_expected.to be_a(RakutenWebService::GenreInformation) }

      specify "its children keep itemCount in params" do
        expect(subject.children.first['itemCount']).to eq(192)
      end
    end
  end

  describe "Pagenate helpers" do
    let(:resource_class) { double(:resource_class) }

    subject { RakutenWebService::Response.new(resource_class, json) }

    context "When page is less than pageCount" do
      let(:json) do
        {
          'page' => 1, 'pageCount' => 2
        }
      end

      it { is_expected.to be_next_page }
      it { is_expected.to_not be_last_page }
      it { is_expected.to_not be_previous_page }
      it { is_expected.to be_first_page }
    end
    context "When page is equal to pageCount" do
      let(:json) do
        {
          'page' => 2, 'pageCount' => 2
        }
      end

      it { is_expected.to_not be_next_page }
      it { is_expected.to be_last_page }
      it { is_expected.to be_previous_page }
      it { is_expected.to_not be_first_page }
    end
    context "When current page is in pages" do
      let(:json) do
        {
          'page' => 2, 'pageCount' => 3
        }
      end

      it { is_expected.to be_next_page }
      it { is_expected.to_not be_last_page }
      it { is_expected.to be_previous_page }
      it { is_expected.to_not be_last_page }
    end
  end
end
