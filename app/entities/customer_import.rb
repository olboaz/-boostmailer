class CustomerImport

  def create_hash(row)
    begin
      row["delivery_days"] = row["delivery_days"].split(",")
      @supplier = Supplier.new row.to_hash.merge!(company_id: company.id)
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
      nbcsvrow = CSV.open(file.path).count - 1
    rescue Exception => e
      @errors << "Le fichier importé ne peut pas être chargé !"
      return [@errors, 1, "wrong file"]
    end
    firstline = File.open(file.path, &:readline)
    rownumber = 1
    separator_check(firstline)

    CSV.foreach(file.path, :col_sep => @separator, headers: true) do |row|
      create_hash(row)
      if create_hash(row) == "Erreur"
        @errors << "Le fichier importé ne peut pas être chargé !"
        return [@errors, 1, "wrong file"]
      else
        if !@supplier.save
          @errors << ["ligne #{rownumber}", "message d'erreur : #{@supplier.errors.full_messages}"]
        else
          @supplier.save
        end
        rownumber += 1
      end
    end
    return [@errors, nbcsvrow]
  end

end
