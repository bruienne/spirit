require_relative '../../lib/spirit/script'

Spirit::App.controllers :scripts do

  # Script index
  get '/get/all' do
    id = params[:id] # Client serial

    files = Spirit::Script.all

    data = {
        'scripts' => files
    }

    data.to_plist(plist_format: CFPropertyList::List::FORMAT_XML)
  end

  # Read script
  get '/get/entry' do
    script = Spirit::Script.new params[:id]

    data = {
        'script' => script.contents
    }

    data.to_plist(plist_format: CFPropertyList::List::FORMAT_XML)
  end

  # Create script (or replace)
  post '/set/entry' do
    script = Spirit::Script.new params[:id]
    script.contents = @request_payload['script_file']

    201
  end

  # Delete script
  post '/del/entry' do
    script = Spirit::Script.new params[:id]
    Spirit::Script.delete(script)

    201
  end

  # Rename script
  post '/ren/entry' do
    script = Spirit::Script.new params[:id]
    script.rename! params[:new_id]

    201
  end
end
