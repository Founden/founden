# API (v1) misc controller class
class Api::V1::MiscController < Api::V1::ApplicationController
  # Websockets support
  include Tubesock::Hijack

  # Streams available activities
  def websocket
    hijack do |tubesock|
      # Listen on its own thread
      socket_thread = Thread.new do
        current_account.on_notifications do |obj|
          tubesock.send_data _render_option_json(
            obj, {:serializer => UpdateSerializer})
        end
      end

      tubesock.onmessage do |msg|
        tubesock.send_data _('Error: 405')
      end

      tubesock.onclose do
        # Stop listening when client leaves
        socket_thread.kill
      end
    end
  end

  # Creates an MD5 hash out of a string
  def md5
    render :json => { :hash => Digest::MD5.hexdigest(md5_query.to_s) }
  end

  private

  # Allowed parameters for MD5 hashing request
  def md5_query
    params.require(:query)
  end
end
