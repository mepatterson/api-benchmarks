require 'digest/sha1'
require 'securerandom'
require 'faker'

class Item < ActiveRecord::Base

  validates :name, presence: true
  validates :uuid, presence: true
  validates :hash_code, presence: true
  validates :description, presence: true

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
    # this generates 1 million records for benchmarking
    def generate_million
      puts "Generating 1,000,000 items..."
      1_000_000.times do |n|
        name = Faker::Company.bs.titleize
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