require 'rails_helper'

RSpec.describe ConcertsController, type: :controller do
  let(:my_user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:my_concert) { create(:concert, user: my_user) }
  let(:new_concert_attr) do
    {
      address_1: RandomData.random_address,
      city: "Naperville",
      state: "IL",
      title: Faker::Lorem.word,
      show_date: Faker::Date.forward(30),
      show_time: Time.now,
      location_name: Faker::Lorem.word,
      user: my_user
    }
  end

# Guest users
  context "guest user" do
    describe "GET #show" do
      it "returns http success" do
        get :show, {user_id: my_user.id, id: my_concert.id}
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, {user_id: my_user.id, id: my_concert.id}
        expect(response).to render_template("show")
      end

      it "assigns my_concert to @concert" do
        get :show, {user_id: my_user.id, id: my_concert.id}
        expect(assigns(:concert)).to eq(my_concert)
      end
    end

    describe "GET #new" do
      it "returns http redirect" do
        get :new, {user_id: my_user.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "POST #create" do
      it "returns http redirect" do
        post :create, {user_id: my_user.id,
        concert: new_concert_attr }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET #edit" do
      it "returns http redirect" do
        get :edit, {user_id: my_user.id, id: my_concert.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "PUT #update" do
      it "returns http redirect" do
        put :update, {user_id: my_user.id, id: my_concert.id,
        concert: new_concert_attr}

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "DELETE #destroy" do
      it "returns http redirect" do
        delete :destroy, {user_id: my_user.id, id: my_concert.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

# Standard users modifying another user's concert
  context "Standard users modifying another user's concert" do
    before do
      sign_in other_user
    end

    describe "GET #new" do
      it "returns http redirect" do
        get :new, {user_id: my_user.id}
        expect(response).to redirect_to root_path
      end
    end

    describe "POST #create" do
      it "returns http redirect" do
        post :create, {user_id: my_user.id,
        concert: new_concert_attr}
        expect(response).to redirect_to root_path
      end
    end

    describe "GET #show" do
      it "returns http success" do
        get :show, {user_id: my_user.id, id: my_concert.id}
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, {user_id: my_user.id, id: my_concert.id}
        expect(response).to render_template("show")
      end

      it "assigns my_concert to @concert" do
        get :show, {user_id: my_user.id, id: my_concert.id}
        expect(assigns(:concert)).to eq(my_concert)
      end
    end

    describe "GET #edit" do
      it "returns http redirect" do
        get :edit, {user_id: my_user.id, id: my_concert.id}
        expect(response).to redirect_to root_path
      end
    end

    describe "PUT #update" do
      it "returns http redirect" do
        put :update, {user_id: my_user.id, id: my_concert.id,
        concert: new_concert_attr}

        expect(response).to redirect_to root_path
      end
    end

    describe "DELETE #destroy" do
      it "redirects to topic show" do
        delete :destroy, {user_id: my_user.id, id: my_concert.id}

        expect(response).to redirect_to root_path
      end
    end
  end # context end

# Standard users modifying their own concert
  context "Standard users modifying their concert" do
    before do
      sign_in my_user
    end

    describe "GET #new" do
      it "returns http success" do
        get :new, {user_id: my_user.id}
        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        get :new, {user_id: my_user.id}
        expect(response).to render_template("new")
      end

      it "initiates @concert" do
        get :new, {user_id: my_user.id}
        expect(assigns(:concert)).not_to be_nil
      end
    end

    describe "POST #create" do
      # it "increase the number of Concert by 1" do
      #   expect{
      #     post :create, {user_id: my_user.id,
      #     concert: new_concert_attr}
      #   }.to change(Concert, :count).by(1)
      # end

      # it "assigns the new concert to @concert" do
      #   post :create, {user_id: my_user.id,
      #   concert: new_concert_attr}
      #   expect(assigns(:concert)).to eq(Concert.last)
      # end

      # it "redirects to the new concert" do
      #   post :create, {user_id: my_user.id,
      #   concert: new_concert_attr}
      #   expect(response).to redirect_to([my_user, Concert.last])
      # end
    end

    describe "GET #show" do
      it "returns http success" do
        get :show, {user_id: my_user.id, id: my_concert.id}
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, {user_id: my_user.id, id: my_concert.id}
        expect(response).to render_template("show")
      end

      it "assigns my_concert to @concert" do
        get :show, {user_id: my_user.id, id: my_concert.id}
        expect(assigns(:concert)).to eq(my_concert)
      end
    end

    describe "GET #edit" do
      it "returns http success" do
        get :edit, {user_id: my_user.id, id: my_concert.id}
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, {user_id: my_user.id, id: my_concert.id}
        expect(response).to render_template :edit
      end

      it "assign post to be updated to @concert" do
        get :edit, {user_id: my_user.id, id: my_concert.id}
        concert_instance = assigns(:concert)

        expect(concert_instance.id).to eq(my_concert.id)
        expect(concert_instance.title).to eq(my_concert.title)
        expect(concert_instance.address_1).to eq(my_concert.address_1)
      end
    end

    describe "PUT #update" do
      it "updates post with expected attributes" do
        put :update, {user_id: my_user.id, id: my_concert.id,
        concert: new_concert_attr}
        updated_concert = assigns(:concert)

        expect(updated_concert.id).to eq(my_concert.id)
        expect(updated_concert.title).to eq(new_concert_attr[:title])
        expect(updated_concert.address_1).to eq(new_concert_attr[:address_1])
      end

      it "redirects to the updated post" do
        put :update, {user_id: my_user.id, id: my_concert.id,
        concert: new_concert_attr}

        expect(response).to redirect_to([my_user, my_concert])
      end
    end

    describe "DELETE #destroy" do
      it "deletes the concert" do
        delete :destroy, {user_id: my_user.id, id: my_concert.id}

        count = Concert.where({id: my_concert.id}).size
        expect(count).to eq(0)
      end

      # it "redirects to topic show" do
      #   delete :destroy, {user_id: my_user.id, id: my_concert.id}
      #
      #   expect(response).to redirect_to [my_user, my_user.profiles.first]
      # end
    end
  end # context end

# Admin users
  context "admin user modifying any post they don't own" do
    before do
      other_user.admin!
      create_session(other_user)
    end

    describe "GET #new" do
      it "returns http success" do
        get :new, {user_id: my_user.id}
        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        get :new, {user_id: my_user.id}
        expect(response).to render_template("new")
      end

      it "initiates @concert" do
        get :new, {user_id: my_user.id}
        expect(assigns(:concert)).not_to be_nil
      end
    end

    describe "POST #create" do
      it "increase the number of Concert by 1" do
        expect{
          post :create, {user_id: my_user.id,
          concert: new_concert_attr}
        }.to change(Concert, :count).by(1)
      end

      it "assigns the new concert to @concert" do
        post :create, {user_id: my_user.id,
        concert: new_concert_attr}
        expect(assigns(:concert)).to eq(Concert.last)
      end

      it "redirects to the new concert" do
        post :create, {user_id: my_user.id,
        concert: new_concert_attr}
        expect(response).to redirect_to([my_user, Concert.last])
      end
    end

    describe "GET #show" do
      it "returns http success" do
        get :show, {user_id: my_user.id, id: my_concert.id}
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, {user_id: my_user.id, id: my_concert.id}
        expect(response).to render_template("show")
      end

      it "assigns my_concert to @concert" do
        get :show, {user_id: my_user.id, id: my_concert.id}
        expect(assigns(:concert)).to eq(my_concert)
      end
    end

    describe "GET #edit" do
      it "returns http success" do
        get :edit, {user_id: my_user.id, id: my_concert.id}
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, {user_id: my_user.id, id: my_concert.id}
        expect(response).to render_template :edit
      end

      it "assign post to be updated to @concert" do
        get :edit, {user_id: my_user.id, id: my_concert.id}
        concert_instance = assigns(:concert)

        expect(concert_instance.id).to eq(my_concert.id)
        expect(concert_instance.title).to eq(my_concert.title)
        expect(concert_instance.body).to eq(my_concert.body)
      end
    end

    describe "PUT #update" do
      it "updates post with expected attributes" do



        put :update, {user_id: my_user.id, id: my_concert.id,
        concert: new_concert_attr}
        updated_concert = assigns(:concert)

        expect(updated_concert.id).to eq(my_concert.id)
        expect(updated_concert.title).to eq(new_title)
        expect(updated_concert.body).to eq(new_body)
      end

      it "redirects to the updated post" do



        put :update, {user_id: my_user.id, id: my_concert.id,
        concert: new_concert_attr}

        expect(response).to redirect_to([my_user, my_concert])
      end
    end

    describe "DELETE #destroy" do
      it "deletes the concert" do
        delete :destroy, {user_id: my_user.id, id: my_concert.id}

        count = Concert.where({id: my_concert.id}).size
        expect(count).to eq(0)
      end

      it "redirects to topic show" do
        delete :destroy, {user_id: my_user.id, id: my_concert.id}

        expect(response).to redirect_to(my_user)
      end
    end
  end # context end
end
