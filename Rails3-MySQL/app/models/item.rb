require 'digest/sha1'
require 'securerandom'
require 'faker'

class Item < ActiveRecord::Base

  validates :name, presence: true
  validates :uuid, presence: true
  validates :hash_code, presence: true
  validates :description, presence: true

  attr_accessible :name, :description

  # translates :name, :description

  before_validation(:on => :create) do
    assign_uuid
    generate_hash_code
  end

  def assign_uuid
    self.uuid = SecureRandom.uuid
  end

  def generate_hash_code
    self.hash_code = Digest::SHA1.hexdigest "#{name}-#{uuid}-#{Time.now.to_f}"
  end


  class << self

    def generate_tons(count = 1_000_000)
      puts "Generating #{count} items..."
      count.times do |n|
        name = Faker::Company.bs.titleize
        # this will create a randomized segment space of 10,000 integers (0..9999)
        # when indexed, this ensures that we are randomly selecting inside a sub-set of
        #   only 100 records whenever we do a .random(), instead of scanning 1mil records
        puts "#{n} / #{name}"
        i = Item.create({
          name: name,
          description: Faker::Lorem.paragraph
          })
        puts "... #{i ? 'saved.' : 'FAIL'}"
      end
    end


    # attempt at a reasonably-performant way to randomly pick a single record
    # without resorting to a nasty full table scan using ORDER RANDOM
    # CAVEAT EMPTOR: 
    #   with a lot of gaps in the ID sequence, this becomes less uniformly random
    def random
      if minimum = self.minimum(:id)
        where("id >= ?", ::Random.new.rand(minimum..self.maximum(:id))).first
      else
        nil
      end
    end

  end

end