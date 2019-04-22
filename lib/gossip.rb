class Gossip
  attr_reader :author, :content
  def initialize (author, content)
    @author = author
    @content = content
  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  def self.all
    all_gossips = CSV.read("./db/gossip.csv").map do |csv_line|
      Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end

  def self.find (id)
    row = CSV.read("./db/gossip.csv")[id.to_i]
    Gossip.new(row[0], row[1])
  end

  def self.update (id, author, content)
    gossips = Gossip.all
    gossips[id.to_i] = Gossip.new(author,content)
    CSV.open("./db/gossip.csv",'w') do |csv|
      csv =""
    end
    gossips.each do |gossip|
      gossip.save
    end
  end
end
