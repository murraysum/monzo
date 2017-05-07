FactoryGirl.define do
  factory :feed_item, :class => Monzo::FeedItem do
    account_id "acc_00009237aqC8c5umZmrRdh"
    type "basic"
    params ({
      :title => "My custom item",
      :image_url => "http://www.example.com/image.png",
      :background_color => "#FCF1EE",
      :body_color => "#FCF1E1",
      :title_color => "#333",
      :body => "Some body text to display"
    })
    url "https://www.example.com/a_page_to_open_on_tap.html"

    initialize_with do
      new(attributes)
    end
  end
end
