require 'sinatra'
require './lib/scale'

class Server < Sinatra::Base
  get '/scale.xml' do
    host = params['host'] || 'hi4050.hardysolutions.com'
    port = params['port'] || 502

    scale = Scale.new(host, port)

    builder do |xml|
      build_xml(xml, scale)
    end
  end

  private

  def build_xml(xml, scale)
    xml.instruct!
    xml.scale do
      ['net', 'gross'].each do |type|
        xml.scaleItem do
          xml.value scale.send("#{type}_weight")
        end
      end
    end
  end
end
