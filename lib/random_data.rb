module RandomData
  def self.random_address
    options = ['200 W Jefferson Ave', '507 Railway Dr', '2703 Showplace Dr', '1320 S Illinois Rte 59', '1759 W Ogden Ave', '612 Raymond Dr', '2607 W 75th St', '1295 E Ogden Ave']
    options.sample
  end

  def self.random_user
    test_users = (1..5).to_a.map do |n|
      User.new(
        username: Faker::Name.name,
        email:    "test#{n}@example.com",
        password: "testtest"
      )
    end

    test_users.map do |user|
      user.skip_confirmation!
      user.save
    end

    test_users.sample
  end
end
