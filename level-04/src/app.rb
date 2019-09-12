require 'sinatra'
# Your app

def get_todos
      @@todos||=[]
end

def add_todo(title,date)
    get_todos.push(title:'date')
end

def get_todo()
   
end

def update_todo(title)
  
end

def delete_todo
  
end

get '/' do
  redirect '/todos'
end

get '/todos' do
  @todos = get_todos()
  erb :todos
end

get '/todos/:id' do
  @id=params[:id]
  @todo=get_todo(params)
  erb :todo
end

put '/todos/:id' do
  @id=params[:id]
  update_todo(params[:title])
  redirect "/todos"
end

post "/todos" do
  add_todo(params[:title],params[:date])
  redirect "/todos"
end

delete "/todos/:id" do
  @id = params[:id]
  delete_todo()
  redirect "/todos"
end
