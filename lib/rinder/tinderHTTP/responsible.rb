module TinderHTTP
  module Responsible

    def recommendations_handler
      ->(res) do
        if !res.status.between?(200, 299)
          users_struct([], "Something went wrong! status:#{res.status}, headers:#{res.headers}, body:#{res.body}"
        else
          recs = res['results']
          non_outers = remove_outs(recs)
          return users_struct([], 'You are out of likes today.') if non_outers.size == 0

          users_struct(non_outers)
        end
      end
    end

    def authentication_handler

    end

    private

    def users_struct(users, message = '')
      OpenStruct.new(
        users: users,
        message: message
      )
    end

    def remove_outs(recs)
      recs.select{|r| !r.out_of_like?(r)}
    end

    def out_of_like?(rec)
      rec['name'] == 'Tinder Team'
    end
  end
end
