require 'rails_helper'

class SubclassController < ApplicationController
  def test
    render text: 'ok'
  end
end

describe SubclassController, :type => :controller do
  def skip_routing
    with_routing do |map|
      map.draw do
        # I've tried both of these versions:
        get ':controller/:action'
        #get 'subclass/:action' => 'subclass'
      end

      yield
    end
  end

  # This passes.
  specify do
    skip_routing do
      expect(get: '/subclass/test').to route_to("subclass#test")
    end
  end

  # This fails. Why?
  specify do
    skip_routing do
      get :test
      response.body.should == 'ok'
    end
  end
end
