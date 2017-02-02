class User < ActiveRecord::Base
    attr_accessor :login, :email, :surf_data, :swell_score
end
