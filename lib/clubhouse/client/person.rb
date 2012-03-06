module Clubhouse
  module Client
    class Person
      delegate :name, :email, :email_hash, :group, :website, :membership_date,
               :github_uid, :github_nickname, :permissions, :to => :params

      def initialize(github_nickname)
        self.params = Client.get("people/#{github_nickname}")
      end

      private

      attr_accessor :params

    end
  end
end
