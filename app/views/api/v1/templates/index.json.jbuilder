json.array! @templates do |template|
    json.extract! template, :id, :name, :content
  end