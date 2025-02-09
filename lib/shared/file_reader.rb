module FileReader
  def read_to_string(file:)
    File.read(file)
  end
end
