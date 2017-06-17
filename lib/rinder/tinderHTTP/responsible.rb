module TinderHTTP
  module Responsible

    RECOMMENDATIONS_HANDLER =
      lambda do |res|
        if res.status.between?(400, 599)
          response_struct(error: "Oops! Something seems wrong! status:#{res.status}, headers:#{res.headers}, body:#{res.body}", raw_response: res)
        else
          recs = res.body['results']
          non_outers = remove_outs(recs)
          return response_struct(error: 'You are out of likes today.', raw_response: res) if non_outers.empty?

          response_struct(result: non_outers, raw_response: res)
        end
      end


    LIKE_HANDLER =
      lambda do |res|
        if res.status.between?(400, 599)
          response_struct(message: "Oops! Something seems wrong! status:#{res.status}, headers:#{res.headers}, body:#{res.body}")
        else
          response_struct(result: res.body, raw_response: res)
        end
      end

    AUTHENTICATION_HANDLER =
      lambda do |res|
        if res.status.between?(400, 599)
          response_struct(message: "Oops! Something seems wrong! status:#{res.status}, headers:#{res.headers}, body:#{res.body}")
        else
          response_struct(result: res.body['token'], raw_response: res)
        end
      end

    class << self
      private

      def response_struct(result: '', error: '', raw_response: '')
        OpenStruct.new(
          result: result,
          error: error,
          raw_response: raw_response
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
end
