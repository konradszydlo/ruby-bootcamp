require 'set'

class User

  attr_reader :roles, :username, :password

  def initialize(username, password)
    @username = username
    @password = password
    @roles = Set.new get_user_roles
  end

  def get_user_roles
    userdata = self.class.find_user_data username
    userdata['roles']
  end

  def add_role(role)
    roles << role
  end

  def in_role?(role)
    roles.include? role
  end

  def self.find_user_data(username)
    users = get_users
    users.find do |user|
      user['username'] == username
    end
  end

  def self.find_by_username(username)
    data = find_user_data username
    User.new data['username'], data['password']
  end

  def self.get_users
    file = File.read('data/users.json')
    data = JSON.parse(file)
    data['users']
  end

end