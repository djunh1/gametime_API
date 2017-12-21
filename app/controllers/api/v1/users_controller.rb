class Api::V1::UsersController < ApplicationController
  before_action :authenticate_with_token!, only: [:logout]
  #new 4
  def facebook
    if params[:facebook_access_token]
      graph = Koala::Facebook::API.new(params[:facebook_access_token])
      user_data = graph.get_object("me?fields=name,email,id,picture")

      user = User.find_by(email: user_data['email'])
      if user
        #New Token each time logged in.
        user.generate_authentication_token
        user.save
        render json: user, status: :ok
      else
        user = User.new(fullname: user_data['fullname'],
                        email: user_data['email'],
                        uid: user_data['id'],
                        provider: 'Facebook',
                       image: user_data['picture']['data']['url'])
        user.generate_authentication_token
        if user.save
          render json: user, status: :ok
        else
          render json: {error: user.errors}, is_success: false, status: 422
        end

      end
    else
      render json: {error: "Invalid Facebook Token", is_success: false}, status: :unprocessable_entity
    end
  end

  def logout
    #logout , old access token isnt used.  make a new one when logging out.
    user = User.find_by(access_token: params[:access_token])
    user.generate_authentication_token
    user.save
    render json: {is_success: true}, status: :ok
  end

  #new 8 - adding stripe

  def add_card
    user = User.find(current_user.id)

    if user.stripe.id.blank?
      customer = Stripe::Customer.create(
        email: user.email
      )
      user.stripe_id = customer.id
      user.save
    else
      customer = Stripe::Customer.retrieve(user.stripe_id)
    end

    customer.sources.create(source: params[:stripe_token])
    render json: {is_success: true}, status: :ok
  rescue Stripe::CardError => e
    render json: {error: e.message, is_success: false}, status: :not_found
  end
end
