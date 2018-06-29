require 'httparty'
require 'pry'
require 'json'

while true
  puts "CRUD RUBY API"
  puts "1) Index"
  puts "2) Show"
  puts "3) Create"
  puts "4) Edit"
  puts "5) Delete"
  puts "q) Quit"
  print ": "
  answer = gets.chomp
  if answer == "1"
    response = HTTParty.get('http://json-server.devpointlabs.com/api/v1/users')
    case response.code
    when 200
      puts "All good!"
    when 404
      puts "Nothing there..."
    when 500...600
      puts "HAD A ERROR #{response.code}"
    end
    j_response = JSON.parse(response.to_s)
    j_response.each do |r|
      print "User: #{r["id"]} - FirstName: #{r["first_name"]} - LastName: #{r["last_name"]} - Phone: #{r["phone_number"]} \n"
    end
  elsif answer == "2"
    puts "Enter the desired ID."
    print ": "
    id = gets.chomp.to_i
    response = HTTParty.get("http://json-server.devpointlabs.com/api/v1/users/#{id}/")
    case response.code
    when 200
      puts "All good!"
    when 404
      puts "Nothing there..."
    when 500...600
      puts "HAD A ERROR #{response.code}"
    end
    j_response = JSON.parse(response.to_s)
    print "User: #{j_response["id"]} - FirstName: #{j_response["first_name"]} - LastName: #{j_response["last_name"]} - Phone: #{j_response["phone_number"]} \n"
  elsif answer == "3"
    print "Enter first name: "
    first_name = gets.chomp
    print "\nEnter last name: "
    last_name = gets.chomp
    print "\nEnter phone number: "
    phone_number = gets.chomp
    response = HTTParty.post("http://json-server.devpointlabs.com/api/v1/users/", 
    :body => { :first_name => first_name.to_s, 
               :last_name => last_name.to_s, 
               :phone_number => phone_number.to_s, 
             }.to_json,
    :headers => { 'Content-Type' => 'application/json' } )
    case response.code
    when 200
      puts "All good!"
    when 404
      puts "Nothing there..."
    when 500...600
      puts "HAD A ERROR #{response.code}"
    end
    puts "Added new user - id: #{response["id"]}, first name: #{response["first_name"]}, last name: #{response["last_name"]}, phone number: #{response["phone_number"]} "
  elsif answer == "4"
    puts "Enter the desired ID."
    print ": "
    id = gets.chomp.to_i
    print "Enter first name: "
    first_name = gets.chomp
    print "\nEnter last name: "
    last_name = gets.chomp
    print "\nEnter phone number: "
    phone_number = gets.chomp
    response = HTTParty.put("http://json-server.devpointlabs.com/api/v1/users/#{id}/", 
    :body => { :first_name => first_name.to_s, 
               :last_name => last_name.to_s, 
               :phone_number => phone_number.to_s, 
             }.to_json,
    :headers => { 'Content-Type' => 'application/json' } )
    case response.code
    when 200
      puts "All good!"
    when 404
      puts "Nothing there..."
    when 500...600
      puts "HAD A ERROR #{response.code}"
    end
    puts "Edited user - id: #{response["id"]}, first name: #{response["first_name"]}, last name: #{response["last_name"]}, phone number: #{response["phone_number"]} "
  elsif answer == "5"
    puts "Enter the desired ID."
    print ": "
    id = gets.chomp.to_i
    response = HTTParty.delete("http://json-server.devpointlabs.com/api/v1/users/#{id}/")
    case response.code
    when 200
      puts "All good!"
    when 404
      puts "Nothing there..."
    when 500...600
      puts "HAD A ERROR #{response.code}"
    end
    j_response = JSON.parse(response.to_s)
    print "Deleted user at id #{id} \n"
  elsif answer == "q"
    break
  end
  puts ""
end
