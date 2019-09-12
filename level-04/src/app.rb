require 'sinatra'

def get_todos
      @@todos||=Hash.new
end

def add_todo(title,date)
    get_todos()[title]=date  ;
end

def get_key
  @@todos.keys[@id.to_i-1]
end

def get_todo()
  {"title"=>get_key(),"date"=>get_todos[get_key()]}
end

def update_todo(title)
  get_todos[title] = get_todos.delete "#{get_key()}"
end

def delete_todo
  get_todos().delete(get_key())
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
  @todo=get_todo()
  erb :todo
end

post "/todos" do
  add_todo(params[:title],params[:date])
  redirect "/todos"
end

put '/todos/:id' do
  @id=params[:id]
  update_todo(params[:title])
  redirect "/todos"
end

delete "/todos/:id" do
  @id = params[:id]
  delete_todo()
  redirect "/todos"
end
