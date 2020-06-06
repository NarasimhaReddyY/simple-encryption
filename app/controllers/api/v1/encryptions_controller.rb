class Api::V1::EncryptionsController < Api::V1::BaseController

  def convert
    input_string = params[:input_string]

    if convert_fields_errors.empty?
      mode = params[:mode]
      if mode.eql?("compress")
        result = ::StringFormater.new(input_string).compress
      elsif mode.eql?("decompress")
        result = ::StringFormater.new(input_string).decompress
      end

      if result.length > 0
        render json: { result: result}, status: :ok
      else
        err_message = mode.eql?("compress") ? 'Invalid input' : 'Looks not a valid compressed string'
        render json: { input_string: err_message}, status: :ok
      end
    else
      render json: { input_string: convert_fields_errors}, status: :bad_request
    end
  end


  def start
    if encrypt_fields_errors.empty?
      input_string = params[:input_string]
      mode = params[:mode]
      key = params[:key]

      if mode.eql?("encrypt")
        result = ::StringFormater.new(input_string, key).encrypt
      elsif mode.eql?("decrypt")
        result = ::StringFormater.new(input_string, key).decrypt
      end

      render json: { result: result}, status: :ok
    else
      render json: { errors: encrypt_fields_errors}, status: :bad_request
    end

  end


  private

  def convert_fields_errors
    input_string = params[:input_string]
    mode = params[:mode]
    errors = []

    errors << 'Input string and mode should present' if(input_string.empty? || mode.empty?)
    errors << "Mode shold be `compress` or `decompress`" if !(["compress", "decompress"].include?(mode))
    # more validations can be added
    errors
  end

  def encrypt_fields_errors
    input_string = params[:input_string]
    key = params[:key]
    mode = params[:mode]
    errors = []

    errors << 'Input string and key should present' if(input_string.empty? || key.blank?)
    errors << "Mode shold be `encrypt` or `decrypt`" if !(["encrypt", "decrypt"].include?(mode))
    # more validations can be added
    errors
  end

end
