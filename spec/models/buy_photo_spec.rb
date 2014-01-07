require 'spec_helper'

describe BuyPhoto do
  describe "Validations" do
    it { should validate_uniqueness_of(:activity_image_id).scoped_to(:parent_id, :album_order_id) }
    it { should validate_presence_of(:activity_image) }
    it { should validate_presence_of(:parent) }
    it { should validate_presence_of(:album_order) }
  end

  describe "Relations" do
    it { should belong_to(:activity_image) }
    it { should belong_to(:parent) }
  end

  describe "::PRICE" do
    it "returns 10" do
      expect(BuyPhoto::PRICE).to eq(10)
    end
  end

  describe ".price" do
    let(:buy_photo1) { BuyPhoto.make! }
    let(:buy_photo2) { BuyPhoto.make! }
    let(:buy_photo3) { BuyPhoto.make! }

    context "direct on class" do
      subject { BuyPhoto.price }

      context "0 BuyPhoto" do
        it "returns 0" do
          expect(subject).to be_zero
        end
      end

      context "With BuyPhoto on database" do
        before { buy_photo1; buy_photo2; buy_photo3 }

        it "not returns 0" do
          expect(subject).to_not be_zero
        end

        it "returns 30" do
          expect(subject).to be(BuyPhoto::PRICE * 3)
        end
      end
    end

    context "ActiveRecord::Relation" do
      context "empty collection" do
        before { buy_photo1 }

        subject { BuyPhoto.where("parent_id <> ?", buy_photo1.parent_id) }

        it "returns zero" do
          expect(subject.price).to eq(0)
        end
      end

      context "with a collection" do
        before { buy_photo1; buy_photo2; buy_photo3 }

        context "searching for buy_photo1.parent_id" do
          subject { BuyPhoto.where(:parent_id => buy_photo1.parent_id) }

          it "not returns zero" do
            expect(subject.price).to_not eq(0)
          end

          it "returns 10*1" do
            expect(subject.price).to eq(BuyPhoto::PRICE * 1)
          end
        end

        context "not searching for buy_photo1.parent_id" do
          subject { BuyPhoto.where("parent_id <> ?", buy_photo1.parent_id) }

          it "not returns zero" do
            expect(subject.price).to_not eq(0)
          end

          it "returns 10*2" do
            expect(subject.price).to eq(BuyPhoto::PRICE * 2)
          end
        end
      end
    end
  end
end
