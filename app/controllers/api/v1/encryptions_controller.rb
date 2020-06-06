class Api::V1::EncryptionsController < Api::V1::BaseController

  def convert
    input_string = params[:input_string]

    if input_string.empty?
      render json: { input_string: 'Should not be empty'}, status: :bad_request
    else
      mode = params[:mode]
      if mode.eql?("compress")
        result = StringFormater.new(input_string).compress
      elsif mode.eql?("decompress")
        result = StringFormater.new(input_string).decompress
      end

      if result.length
        render json: { result: result}, status: :ok
      else
        err_message = mode.eql?("compress") ? 'Invalid input' : 'Looks not a valid compressed string'
        render json: { input_string: err_message}, status: :ok
      end

    end
  end

end
