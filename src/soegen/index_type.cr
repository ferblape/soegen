module Soegen
  class IndexType
    getter index, name

    def initialize(@index : Index, @name : String)
    end

    def exists?
      request("head").ok_ish?
    end

    def get(id)
    end

    def explain(id, query, options)
      request(:get, "#{id}/_explain", options, query)
    end

    def put(id, source, options)
      request(:put, id, options, source)
    end

    def post(source : String, options={} of String => String)
      request!(:post, "", options, source)
    end

    def post(source, *args)
      post(source.to_json, *args)
    end

    def update
    end

    def delete
    end

    private def request!(*args)
      response = request(*args)

      if !response.ok_ish?
        raise RequestError.new(response)
      end
    end

    private def request(method : Symbol, path = "" : String, *args)
      path = "#{name}/#{path}"
      index.request(method, path, *args)
    end
  end
end
