require 'sinatra'
require 'sqlite3'
require 'pry'
db = SQLite3::Database.new "pets.db"

# pets = {
#   0=> {
#     id: 0,
#     name: "fluffy",
#     type: "hamster"
#   }
# }
#
# counter = 1

get '/pets' do

  all = db.execute("SELECT name, type, id FROM pets");
  #puts all[0][0]
  puts all
  erb :sqlindex, locals: { pets: all }
  #erb :index, locals: { pets: pets }

end

post'/pet' do

  db.execute("INSERT INTO pets (name, type) VALUES (?, ?)", params[:name], params[:type])
  person = db.execute( "SELECT MAX(ID) name, type FROM pets");

  redirect '/pets'
#   newpet = {
#     id: counter,
#     name: params["name"],
#     type: params["type"]
#   }
#
#   pets[counter] = newpet
#   counter += 1
#   redirect '/pets'
#
end

get '/pet/:id' do

  all = db.execute("SELECT id, name, type FROM pets WHERE id=#{params[:id]}")
  erb :sqlshow, locals: { thispet: all }

  # thispet = pets[params[:id].to_i]
  # erb :show, locals: { thispet: thispet }

end
#
put '/pet/:id' do

  db.execute("UPDATE pets SET name=? WHERE id=#{params[:id]}", params[:name])

  redirect '/pets'

#   pet = pets[params[:id].to_i]
#   pet[:name] = params["newname"]
#   redirect '/pets'
#
end
#
delete '/pet/:id' do
  db.execute("DELETE FROM pets WHERE id=?", params[:id])

  redirect '/pets'

#   pets.delete(params[:id].to_i)
#   redirect '/pets'
end
