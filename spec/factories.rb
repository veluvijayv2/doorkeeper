FactoryBot.define do
  factory :access_grant, class: Doorkeeper::AccessGrant do
    application

    redirect_uri 'https://app.com/callback'
    expires_in 100
    scopes 'public write'

    trait :with_resource_owner do
      after(:build) do |grant|
        resource_owner = create(:doorkeeper_testing_user)

        grant.resource_owner = resource_owner
      end
    end
  end

  factory :access_token, class: Doorkeeper::AccessToken do
    application

    expires_in 2.hours

    factory :clientless_access_token do
      application nil
    end

    trait :with_resource_owner do
      after(:build)  do |token|
        resource_owner = create(:doorkeeper_testing_user)

        token.resource_owner = resource_owner
      end
    end
  end

  factory :application, class: Doorkeeper::Application do
    sequence(:name) { |n| "Application #{n}" }
    redirect_uri 'https://app.com/callback'
  end

  # do not name this factory :user, otherwise it will conflict with factories
  # from applications that use doorkeeper factories in their own tests
  factory :doorkeeper_testing_user, class: :user
end
