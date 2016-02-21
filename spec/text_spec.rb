require_relative "spec_helper"

describe "PDF::Core::Text" do
  before do
    class TextMock
      include PDF::Core::Text

      attr_reader :text

      def add_content(str)
        @text ||= ""
        @text << str
      end
    end
    @mock = TextMock.new
  end
  describe "horizontal_text_scaling" do
    describe "called without argument" do
      before do
        @result = @mock.horizontal_text_scaling
      end
      it "functions as accessor" do
        expect(@result).to eq(100)
      end
    end
    describe "called with argument" do
      before do
        @mock.horizontal_text_scaling(110) do
          @mock.add_content("TEST")
        end
      end
      it "resets horizontal_text_scaling to original value" do
        expect(@mock.horizontal_text_scaling).to eq(100)
      end
      it "outputs correct PDF content" do
        expect(@mock.text).to eq("\n110.0 TzTEST\n100.0 Tz")
      end
    end
  end
end
