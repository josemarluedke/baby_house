require 'spec_helper'

describe BuyPhotosController do
  describe "#create" do
    let!(:parent) { Parent.make! }
    let!(:activity_image) { ActivityImage.make! }
    let!(:buy_photo) { BuyPhoto.make!(parent: parent, activity_image: activity_image)}

    context "Remove a photo from AlbumOrder" do
      context "Signed parent" do
      end

      context "Guest parent" do
        it "Not changes AlbumOrder count" do
          expect{
            post(:create, { activity_image_id: activity_image.id })
          }.to_not change(AlbumOrder, :count)
        end

        it "Not changes BuyPhoto count" do
          expect{
            post(:create, { activity_image_id: activity_image.id })
          }.to_not change(BuyPhoto, :count)
        end

        context "making post before" do
          before { post(:create, { activity_image_id: activity_image.id }) }

          it { expect(response).to redirect_to(new_parent_session_path) }
          it { expect(flash).to_not be_empty }
          it { expect(flash[:alert]).to be_present }
          it { expect(flash[:alert]).to eq(I18n.t("devise.failure.unauthenticated")) }
        end
      end
    end

    context "Adding a photo to AlbumOrder" do
      context "Signed parent" do
        before { sign_in parent }
      end

      context "Guest parent" do
        it "Not changes AlbumOrder count" do
          expect{
            post(:create, { activity_image_id: activity_image.id })
          }.to_not change(AlbumOrder, :count)
        end

        it "Not changes BuyPhoto count" do
          expect{
            post(:create, { activity_image_id: activity_image.id })
          }.to_not change(BuyPhoto, :count)
        end

        context "making post before" do
          before { post(:create, { activity_image_id: activity_image.id }) }

          it { expect(response).to redirect_to(new_parent_session_path) }
          context "flash message" do
            it { expect(flash).to_not be_empty }
            it { expect(flash[:alert]).to be_present }
            it { expect(flash[:alert]).to eq(I18n.t("devise.failure.unauthenticated")) }
          end
        end
      end
    end
  end
end
