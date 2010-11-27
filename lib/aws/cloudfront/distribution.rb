module AWS
  module Cloudfront
    class Distribution

      def initialize(id, aws_access_key, aws_secret_key, verbose=false)
        @id = id
        @aws_access_key = aws_access_key
        @aws_secret_key = aws_secret_key
        @verbose = verbose
      end

      def uri
        @uri ||= URI.parse("https://cloudfront.amazonaws.com/2010-07-15/distribution/#{@id}/config")
      end

      def config
        get_config unless @config
        @config
      end

      def etag
        get_config unless @etag
        @etag
      end

      def set_default_root_object(object)
        get_config unless @config
        @config['DefaultRootObject'] = [object]
        put_config
      end

      private

      def get_config
        http = Net::HTTP.new(uri.host, uri.port)
        http.set_debug_output $stderr if @verbose
        http.use_ssl = true
        response, body = http.get(uri.path, build_authorization_headers)

        raise 'Distribution could not be loaded' unless response.kind_of?(Net::HTTPSuccess)

        @etag = response.fetch('Etag')
        @config = XmlSimple.xml_in(body)
      end

      def put_config
        http = Net::HTTP.new(uri.host, uri.port)
        http.set_debug_output $stderr if @verbose
        http.use_ssl = true
        headers = build_authorization_headers
        headers['If-Match'] = @etag
        body = XmlSimple.xml_out(@config, {'RootName' => 'DistributionConfig'})
        response = http.send_request('PUT', uri.path, body, headers)

        unless response.kind_of?(Net::HTTPSuccess)
          raise XmlSimple.xml_in(response.body)['Error'].to_yaml
        end
      end

      def build_signature(date_string)
        digest = OpenSSL::Digest::Digest.new('sha1')
        [OpenSSL::HMAC.digest(digest, @aws_secret_key, date_string)].pack("m").strip
      end

      def build_authorization_headers
        date_string = Time.now.strftime('%a, %d %b %Y %k:%M:%S %Z')

        headers = {}
        headers['Authorization'] = "AWS #{@aws_access_key}:#{build_signature(date_string)}"
        headers['Date'] = date_string
        headers
      end
    end
  end
end
