class SignUtils
  SALT = ENV['SIGN_SALT']

  class << self
    def sign(string)
      Digest::SHA256.hexdigest "#{SALT}#{string}"
    end

    def validate(string, hash)
      sign(string) == hash
    end
  end
end