module TinderHTTP
  module Responsible

    def recommendations_handler
      ->(res) do
        if res.status.between?(400, 599)
          response_struct(message: "Oops! Something seems wrong! status:#{res.status}, headers:#{res.headers}, body:#{res.body}")
        else
          recs = res.body['results']
          non_outers = remove_outs(recs)
          return response_struct(message: 'You are out of likes today.') if non_outers.empty?

          response_struct(result: non_outers)
        end
      end
    end

    def like_handler
      ->(res) do
        if res.status.between?(400, 599)
          response_struct(message: "Oops! Something seems wrong! status:#{res.status}, headers:#{res.headers}, body:#{res.body}")
        else
          response_struct(result: res.body)
        end
      end
    end

    # raise an error intentionally to handle it in client class
    def authentication_handler
      ->(res) do
        if res.status.between?(400, 599)
          raise "Oops! Something seems wrong! status:#{res.status}, headers:#{res.headers}, body:#{res.body}"
        else
          res.body['token']
        end
      end
    end

    private

    def response_struct(result:, message: '')
      OpenStruct.new(
        result: result,
        message: message
      )
    end

    def remove_outs(recs)
      recs.select { |r| !out_of_like?(r) }
    end

    def out_of_like?(rec)
      rec['name'] == 'Tinder Team'
    end
  end
end
