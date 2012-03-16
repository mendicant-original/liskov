1module Clubhouse
  module Client
    PersonNotFound = Class.new(Exception)

    class Person
      delegate :name, :email, :email_hash, :group, :website, :membership_date,
               :github_uid, :github_nickname, :permissions, :to => :params

      def initialize(github_nickname)
        self.params = Client.get("people/#{github_nickname}")

        raise PersonNotFound if params.nil?
      end

      private

      attr_accessor :params

    end
  end
end
