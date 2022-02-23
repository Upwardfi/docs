
def parse_payload(struct)
  result = "{\n\t"
  references = struct["payload"]["References"]

  references.each do |reference|
    result+=format_field_value(reference)
  end
  
  result = result.chomp(",\n\t")+"\n\t}"

  return result
end

def parse_response(struct)
  return format_json(struct["response"],1)
end

def parse_parameters(struct)
  result = "Name | Type | Description"+"\n"
  result += "--------- | ------- | ------ | --------\n"
  references = struct["payload"]["References"]

  references.each do |reference|
    result+=format_parameters(reference)+"\n"
  end

  return result
end

def format_field_value(reference)
  result = '"' + reference['Field'] + '"' + ': '

  if reference["Value"].instance_of? Integer then
    result += reference["Value"].to_s
  end
  
  if reference["Value"].instance_of? String then
    result += '"'+reference["Value"]+'"'
  end

  if reference["Value"].instance_of? Hash then
    result += format_json(reference["Value"],2)    
  end

  result += ",\n\t"
end

def format_json(json,tabcount)
  result = "{\n"
  result += print_tabs(tabcount)
  
  json.each do |index,value|
    result += '"' + index + '"' + ': '
    
    if value.instance_of? Integer then
      result += value.to_s
    end
    
    if value.instance_of? String then
      result += '"'+value+'"'
    end

    if value.instance_of? Hash then
      result += format_json(value,tabcount+1)    
    end

    result += ",\n"+print_tabs(tabcount)
  end

  result = result.chomp(",\n"+print_tabs(tabcount))+"\n"+print_tabs(tabcount-1)+"}"

  return result
end

def print_tabs(count)
  result = ""
  for a in 1..count do
  result += "\t"
  end
  return result
end

def format_parameters(json)
  separator = " | "
  result = '`' + json["Field"] + '`' + separator
  result += get_field_type(json["Value"]) + separator
  result += json["Description"]
  
  return result
end

def get_field_type(field)
  if field.instance_of? Integer then
    return "Int"
  end
  
  if field.instance_of? String then
    return "String"
  end

  if field.instance_of? Hash then
    return "Json"
  end
end