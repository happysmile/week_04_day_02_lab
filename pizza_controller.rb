require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry' )
require_relative( './models/pizza_order.rb' )
also_reload('./models/*')

# this controller route will return some html that shows
# all the pizza orders in a nice list

get '/pizza-orders' do
  # we need to get all the pizza orders 🥰
  @orders = PizzaOrder.all()
  p @orders
  # then we will pass the pizza orders into a global variable @
  # then render the index route html
  erb(:index)
end

# this route should return a html page that has a form to
# create a new pizza orders

get '/pizza-orders/new' do
  erb(:new)
end

# this route should accept POST requests on pizza Orders
# then take the posts parameters
# then create a new pizza order

post '/pizza-orders' do
  @order = PizzaOrder.new(params)
  @order.save()
  erb(:create)
end

# this route should return a html page that has a pre-filled form to
# edit a new pizza order

get '/pizza-orders/edit/:id' do
  order_id = params[:id]
  @order = PizzaOrder.find(order_id)
  erb(:edit)
end

# this route should accept POST requests on pizza Orders/id
# then take the post parameters
# then update the pizza order

post '/pizza-orders/:id' do
  order_id = params[:id]
  @order = PizzaOrder.find(order_id)
  @order.first_name = params['first_name']
  @order.last_name = params['last_name']
  @order.topping = params['topping']
  @order.quantity = params['quantity'].to_i
  @order.update()
  erb(:update)
end


# this route should delete a pizza order and redirect to the home page

post '/pizza-orders/delete/:id' do
  order_id = params[:id]
  order = PizzaOrder.find(order_id)
  order.delete()
  redirect '/pizza-orders'
end


# this route should return some html that shows
# a single pizza order

get '/pizza-orders/:id' do
  # first grab the order ID from the URL
  order_id = params[:id]
  # get pizza order - by calling the class method find() on PizzaOrder
  # and by passing in the id we've got from params
  @order = PizzaOrder.find(order_id)
  # render the show page for that order
  erb(:show)
end
