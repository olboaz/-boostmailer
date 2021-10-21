class CustomerImport
  attr_reader :user

  def initialize(user:)
    @user = user
  end

  def create_hash(row)
    begin
      @cust_hash_errors = []
      @customerhash = Hash.new
      @customerhash ["restaurant_name"] = row["restaurant"]
      if row["restaurant"].nil?
        @cust_hash_errors << ["ligne #{@rownumber} - Le nom du restaurant doit être renseigné"]
      end
      @customerhash ["first_name"] = row["prenom"]
      @customerhash ["last_name"] = row["nom"]
      @customerhash ["email"] = row["mail"]
      if row["mail"].nil?
        @cust_hash_errors << ["ligne #{@rownumber} - Le mail doit être renseigné"]
      end
      @customerhash ["address"] = row["adresse"]
      @customerhash.merge!(user_id: user.id)

      if @cust_hash_errors.count > 0
        return "Erreur"
      end
    rescue Exception => e
      return "Erreur"
    end
  end

  def separator_check(line)
    separators = [",", ";", "\t", "|", "#"]
    @separator = ""
    separators.each do |sep|
      if line.match(sep)
        return @separator = sep
      end
    end
  end

  def import(file)
    @errors = []

    begin
      nbcsvrow = CSV.open(file.path, encoding: "ISO8859-1:utf-8").count - 1
    rescue Exception => e
      @errors << "Le fichier importé ne peut pas être chargé !"
      #return [@errors, 1, "wrong file"]
    end
    firstline = File.open(file.path, &:readline)
    rownumber = 1
    separator_check(firstline)

    CSV.foreach(file.path, :col_sep => @separator, headers: true, encoding: "ISO8859-1:utf-8") do |row|
      create_hash(row)
      @customer = Customer.new(@customerhash)

      if create_hash(row) == "Erreur"
        @errors <<  @cust_hash_errors
        return [@errors, 1, "wrong file"]
      else
        if Customer.where(restaurant_name: row["restaurant"]).present?
          @errors << ["ligne #{@rownumber} - #{row["restaurant"]} existe déjà" ]
        end
        if !@customer.save
        else
          @customer.save
        end
        rownumber += 1
      end
    end
    return [@errors, nbcsvrow]
  end

end
