require 'rails_helper'

class SubclassController < ApplicationController
  def index
    render text: 'ok'
  end
end

describe SubclassController, :type => :controller do
  def skip_routing
    with_routing do |map|
      map.draw do
        get 'subclass/index' => "subclass#index"
      end

      yield
    end
  end

  # This passes.
  specify do
    skip_routing do
      expect(get: '/subclass/index').to route_to("subclass#index")
    end
  end

  # This fails. Why?
  specify do
    skip_routing do
      get :index
      response.body.should == 'ok'
    end
  end
end
