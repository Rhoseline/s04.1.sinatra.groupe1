class Comment
  attr_reader :parent_id, :text
  @@comments

  def initialize(parent_id, text)
    @parent_id = parent_id # l'id du potin a laquel il est attaché
    @text = text
  end

  def self.get_all
    begin
      json = File.read("./db/comments.json")
    rescue
      File.open("./db/comments.json","w") do |file|
        file.write("{}")
      end
      json = "{}"
    end
    json = JSON.parse(json)
    json.keys.each {|key| #pour chaque clé du hash (chaque id de potin)
      json[key].map! { |hash| #pour chaque commentaire lié au potin
        Comment.new(hash["parent_id"], hash["text"])
      } # transforme le hash en objet Comment
    }
    json
  end

  def self.add (parent_id, text) # pour ajouter un commentaire
    @@comments = Comment.get_all #on récupère ceux qui existent
    if !@@comments[parent_id] #si il n'y a pas de commentaires pour cet id
      @@comments[parent_id]= [] #on mets un array vide
    end
    @@comments[parent_id] << Comment.new(parent_id, text)
    # on ajoute le nouveau commentaire
    Comment.save
  end

  def self.save
    comments = @@comments
    comments.keys.each { |key|
      comments[key].map! { |comment|
        {"parent_id" => comment.parent_id,
         "text" => comment.text
        }
      }
    }
    json = JSON.pretty_generate(comments) # on mets ça joli
    File.open("./db/comments.json","w") do |f|
      f.write(json) # et on réécrit le fichier
    end
    puts "enregistré !!"
  end

  def self.get (parent_id) #récupère les commentaires liés à UN potin
    comments = Comment.get_all
    comments[parent_id] || []
    # return les commentaires du potin OU array vide si nil
  end
end
