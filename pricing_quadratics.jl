### A Pluto.jl notebook ###
# v0.19.9

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ ce513430-28fc-11eb-0def-67b283cedb41
begin
	import Pkg
	Pkg.activate(mktempdir())
end

# ╔═╡ 653c8d80-2903-11eb-14c3-b52dd37a0111
begin
	Pkg.add("Plots")
	using Plots
	using PlutoUI
end

# ╔═╡ 5583c650-28f5-11eb-3014-81692bc247a8
md"""
# Practicing Quadratics with Price Games
"""


# ╔═╡ d3579790-69fd-42af-b730-1baa3513a01d
md"""
#### Graphing a function/ equation
"""


# ╔═╡ 51d0afc0-28fd-11eb-2b63-53e23d9755bd
md"""
Imagine that you are a company selling widgets. You sell each widget for a certain price, $$p_1$$. Unfortunately, there is also a competitor in the market. They are selling their widgets for a certain price, $$p_2$$. How should you decide your price, $$p_1$$ to make the most amount of money? Use the slider below to change the price you charge for each widget, and see how your profit changes. 
"""

# ╔═╡ efa32c10-28fc-11eb-0f2e-13eef13572fd
#defining our initial quadratic terms
begin
	a1= 2; # quadratic multiplier
	h1= 50;# max profit
    c1 = 0; # constant price effect		
	z1 = 1; # effect of competitor price 
	p2_1 = 5; #initial competitor price
end;	 

# ╔═╡ 60c46850-2902-11eb-0acd-33c703ce2e24
@bind p1_1 Slider(0:1:z1*p2_1+c1+sqrt(h1/a1),default=2)

# ╔═╡ ef20f2d2-2b64-11eb-0e3f-8be6958ab3db
md" $$p_1=$$ $(p1_1)"

# ╔═╡ 13638050-2907-11eb-00d8-7990376cdbd2
#profit function
function profit1(p1, p2, a, h, c, z)
	return -a.*(p1.-(z.*p2.+c)).^2 .+ h 
end;

# ╔═╡ 360039f0-2902-11eb-03ab-c72d4a43a39e
md"We are charging $(p1_1) dollars each for our widgets, and our competitor charges $(p2_1) dollars. We make $(profit1(p1_1, p2_1, a1, h1, c1, z1)) dollars in profits." 

# ╔═╡ cd06bd90-2922-11eb-0348-fd41bf483c07
#compute profit vector
begin
	p1_x = 0:.1:p2_1+c1+sqrt(h1/a1)
	payoff1_x = profit1(p1_x,p2_1, a1, h1, c1, z1)
end;
		

# ╔═╡ 94849422-2b65-11eb-349a-299e4462a479
md"If you plotted the price $$p_1$$ chosen on the slider on the x-axis of the graph, versus your profit on the y-axis, you would see something like the plot below:"

# ╔═╡ 63489f30-2923-11eb-0d71-ed07ae0502a5

begin
	plot(p1_x,payoff1_x,title=" Your Profit (In \$) vs Price You Charge Per Widget",legend=false)
	plot!(xlims=(0,10),ylims=(0,60))
end

# ╔═╡ 9bdcecae-2933-11eb-01f9-b752cfa9b383
md"""This makes sense, right? If you charge nothing for your widget, you won't make any money. However, if you charge too much for your widget, you also won't make any money: nobdoy would buy your very expensive widget!

Based on the plot above, what price (in dollars) can you charge to maximize your profits? Change the number in the text box below to the correct amount"""

# ╔═╡ d31ac530-2933-11eb-180f-dda8d96989be
@bind p_max TextField(default="0")

# ╔═╡ f053711e-3661-11eb-310f-dfa02c634d60
md"""The shape of the plot of price versus profit above might look familiar - it is indeed a parabola, upside down! Remember that a function that generates a parabola is a *quadratic* function, which can be written $$ax^2 + bx + c$$. Here $$x$$ is your price $$p_1$$, and the output of the function is your profit. So, we have the following formula: $$profit_1 = Ap_1^2 + Bp_1 + C$$. 

What are the other values? Well, the parabola is upside down, so we know that $a$ must be negative. This gives us the general shape: with low prices, we don't make a lot of money, with high prices, we don't make a lot of money, but there is some price in between that will make us the most money. $$a$$ is currently -2. But what happens to the plot if that changes? Try the slider below and see how it changes the plot.

""" 

# ╔═╡ 4b6afa22-2b67-11eb-2988-19374acc17e5
begin 
	p1_2 = 5;	
	@bind a2 Slider(2:0.5:4,default=a1)
end

# ╔═╡ 48a810f0-2b64-11eb-3359-357168fcaf81
md" $$a=$$ $(-a2)"

# ╔═╡ e9dd9c20-2b68-11eb-0ff5-2bb89d25d440
@bind p2_2 Slider(2:0.5:8,default=5)

# ╔═╡ 182aa320-2b69-11eb-318f-111c47f097cf
md" $$p_2=$$ $(p2_2)"

# ╔═╡ 5e47db20-2b69-11eb-1728-19dcfb42a6e3
#compute profit vector
begin
	# price of player one
	p1_x2 = 0:.1:10;
	payoff1_x2 = profit1(p1_x2,p2_2, a2, h1, c1, z1)
end;
	

# ╔═╡ da57a6f0-2b69-11eb-0222-b7e10b1ee072

begin
	plot(p1_x2,payoff1_x2,title="Your Profit (In \$) vs Price You Charge Per Widget",legend=false)
	plot!(xlims=(0,10),ylims=(0,60))
end

# ╔═╡ 1d8703bc-7615-45c6-a9b8-9e96bd574075
begin
	A= -a1
	B = 2*a1*(z1*p2_2 + c1)
	C = -a1*(z1*p2_2 + c1)^2 + h1
end;

# ╔═╡ 3b1e8d42-f0a0-4465-bbb6-e1194591104f
begin
	A2= -a1
	B2 = 2*a1*(z1*p1_1 + c1)
	C2 = -a1*(z1*p1_1 + c1)^2 + h1
end;

# ╔═╡ 7d2c5acd-99b2-4331-ad1a-b564141242d7
md"""
#### Rearranging Equations and Solving Quadratic Equations
"""

# ╔═╡ d8fabfcd-3024-4eed-8269-50ebc0219382
md"The expression for above graph is $A p_1^2 + B p_1 + C$, where:"

# ╔═╡ e1d79823-f6ce-41f8-a59e-1bd9ea5dc7bf
md"$A = - a$"

# ╔═╡ e4740cdb-3173-462b-a52a-7a137e92b176
md"$B = 2a*(z*p_2 + c)$"

# ╔═╡ 3cc380ba-087c-4652-a5fc-0b38fc924988
md"$C = - a*(z*p_2 + c)^2 + h$"

# ╔═╡ 967025d7-6a41-4cbc-922d-0929bc131e31
md"Now if we substitute all the values of $A,B,$ and $C$, we will get the following quadratic expression:" 

# ╔═╡ 2b4c8d2a-c630-4880-b159-c688e807a7cb
md"$-2p_1^2 +20p_1 + 0$"

# ╔═╡ 1e2c2cf3-0203-41ad-b77b-e4299f05699d
md"The above expression is a quadratic function, which in our case represents the profit made by our firm. So we can write this as $Profit = -2p_1^2 +20p_1$."

# ╔═╡ ebc960a0-ef78-400a-acfe-beff3c29f1ea
md"Now let us assume that the other firm has already set their price $p_2 =5$. Given that, how much should you set your price $p_1$ to, so that your profit is 40." 

# ╔═╡ cbd49c5b-30b6-4cdd-9579-b12ebb1ea452
md"This can be done by solving the following quadratic equation for $p_1$: $Profit = -2p_1^2 +20p_1$."

# ╔═╡ 24f81d5d-65dc-4c3c-8774-0d07c60b3425
md"We can re-write the above quation as: $2p_1^2 -20p_1 +Profit =0$."

# ╔═╡ e13baa1b-8673-4604-b9b1-81f2c0065c62
@bind prof Slider(0:5:50,default=40)

# ╔═╡ a9a1aa52-a1e0-4138-b319-ca0d5e396ec1
md" $$Profit=$$ $(prof)"

# ╔═╡ 00c57980-2e5c-4fa6-9201-b1747a67dcf5
#defining our price quadratic terms
begin
	constant_term = C - prof
end;

# ╔═╡ 087ba9a3-22e1-4563-9d46-c077f1fab261
md"Now solve the above quadratic equation using following formula: and get:"

# ╔═╡ ac0bb825-0398-45ae-a1c7-4900476edc10
md"$p_1 = \frac{-B + \sqrt(B^2 - 4AC)}{2A}$"

# ╔═╡ 59b96ff3-da67-44c4-963b-2c60a41c7c41
#price p1 function
function price(constant_term_x, A_x, B_x)
	return (-(B_x) .+sqrt.((B_x)^2 .-(4*A_x .*constant_term_x))) ./(2*A_x) 
end;

# ╔═╡ 4b527b18-b936-4531-967c-53026d5466bb
md" $$p_1=$$ $(price(constant_term,A,B))"

# ╔═╡ 30ac2283-67d6-40d1-920b-ce6ffb89b655
begin
	prof_x = 0:5:50
	c_t_x = C .- prof_x
	price_cal = price(c_t_x, A, B)
end;

# ╔═╡ a8dc8a6d-da26-460c-ad79-5abcbaa83fd4
begin
	plot(prof_x,price_cal,title="Your Profit vs. Your Price (in \$)",legend=false)
	plot!(xlims=(0,60),ylims=(0,10))
end

# ╔═╡ 0cfde8ea-70c4-4bf9-9c23-c8d5882f6c29
md""

# ╔═╡ 68669148-0ebe-4b6d-bd21-8fee64cdf042
md"""
#### Best Response - plotting the linear equation
"""

# ╔═╡ 3baa1d44-d7a1-454e-82ca-462fa5973944
md" We know the formula for profit is given by:$A p_1^2 + B p_1 + C$, thus we can write the following:"

# ╔═╡ abc5e1cf-5993-4058-b468-62fff03c7551
md"$Profit = A p_1^2 + B p_1 + C$"

# ╔═╡ ff78c74c-c612-4f5a-ab96-d4457108b96f
begin
	cof_A = A
	cof_B = B
	cof_C = C
end;

# ╔═╡ c37e05ad-d796-40e9-8e91-c9b59f6a3b53
begin
	cof_A2 = A2
	cof_B2 = B2
	cof_C2 = C2
end;

# ╔═╡ 28ae083a-1963-42de-af42-e99b32a2ea9c
md"If we plug in all the values of the coefficients in to the above formula of $Profit$, then we get the following:"

# ╔═╡ 78799609-569b-4fcc-9782-748b3ee351b2
md" $$Profit_1=$$ $(cof_A)$$p_1^2$$ + $(cof_B)$$p_1$$ + $(cof_C)"

# ╔═╡ 70889a16-347d-4f7e-a43e-eb1840dc56c4
md"Now similalry we can write the expression of $Profit$ for your competitor as:"

# ╔═╡ 02b8aaa7-e511-4cd0-b7be-eef84eae7c05
md" $$Profit_2=$$ $(cof_A2)$$p_2^2$$ + $(cof_B2)$$p_2$$ + $(cof_C2)"

# ╔═╡ a84f0cda-c4e8-442a-b4a0-d09fe1fbf79a
md"All looks nice now. But if we notice, we have been playing around with the values of our price $p_1$ to get the best possible $profit$ for our company."

# ╔═╡ f7bdc8e8-f6ba-47ec-b782-8b322f115a1c
md"Well, that sounds like lot of guessing around and it is always a hit or miss."

# ╔═╡ 75e70d30-b47b-4ff7-8810-7d554600f90d
md"What if we have some formula or equation/s to solve and get our best price or if we say more elegantly then our best response to competitor's price. And that would be nice, right!"

# ╔═╡ 0f26a8a2-0223-411c-8467-bbf34d8a1dc3
md"We already know the $Profit$ formula for our company and competitor's company. Now, we will introduce the best response function for both companies."

# ╔═╡ ee69ce13-849b-40fb-a7cd-a7ca5a59f7db
md"The best reponse function for our company is given by:"

# ╔═╡ e58d6c0e-219c-4733-83b8-805273fd4045
md"$p_1 = z p_2 + c$"

# ╔═╡ 803329b8-c617-4d39-ac19-0e27c328e770
md"Similarly, the best response for our competitor's company is given by:"

# ╔═╡ c2eab38b-abc3-48b2-b113-97f5d982c0b7
md"$p_2 = z p_1 + c$"

# ╔═╡ fb5a8d0b-9eda-4a5a-9cb0-e5d8db5cff16
md"Do the equations of best responses look familiar? Yes, they are equations of straight lines. Now let us plot these on a graph, where our y-axis is the price of our company i.e., $p_1$ and the x-axis is $p_2$."

# ╔═╡ 6268858c-2ec0-4c94-b407-22a756487d42
# compute values for best response for company 1
begin
	p2_n = 0:0.1:20
	p1_n = 1 .*p2_n .+ 0
end;

# ╔═╡ 8ae41a84-55db-43e8-a5ac-65b45bc4ff0b
# compute values for best response for company 2
begin
	p1_1n = 0:0.1:20
	p2_2n = 1 .*p1_1n .+ 0
end;

# ╔═╡ 04c3526b-4211-4aa0-9401-32aaf8fff08c
begin
	price1(x) = z1*x + c1
	price2(x) = z1*x + c1
end;

# ╔═╡ 08be3f21-5cae-4c69-88fe-9c0abc8f2345
begin
	plot(price2, 0, 50)
	plot!(price1, 0, 50)
end

# ╔═╡ 2981ffa5-f9d6-422f-8e70-3c515800149f
md"Hmmm! 😒. Doesn't look right. Looks like there is only one line, but we did plot two equations. So what happened? Yes, they are overlapping. Let us find out why is that happening."

# ╔═╡ 82a5a7e7-4130-453e-afca-113d3102aeee
md"Before we get into 'Tell me why?' 🤔 business, let us see what the above graph tell us. Any ideas?"

# ╔═╡ a093d64d-1626-4c31-96fa-698de1313c6d
md"We know that the y-axis is price of our company and the x-axis is the price of the competitor company. Now try to hover your cursor or try to touch the line on the graph above. You will notice that both the coordinates have the same value. This means that we need to keep our price same as that of the competitor to get maximum profit."  

# ╔═╡ 8b6d080e-b567-4e7d-84aa-db68dc0617a2
md"We found our best response, but we also need to find why our plot seem to have only one line. Also, plotting these graphs is not always a good idea. Looks like lot of work, doesn't it?"

# ╔═╡ dbb8934c-49dd-4ddd-a3ef-78560b8b5390
md"So, let us do this smartly. We have two linear equations and two variables. We can simply solve them to get the value."

# ╔═╡ 58b1c989-5d9c-479e-8731-8e275993ddd6
md" Now to get the best response, we need to solve these equations simultaneously. Once we do that we will have the best response value of $p_1$ and $p_2$."

# ╔═╡ 6bdead12-af4d-482b-9df0-d9079914aa4b
md"The two equations are:"

# ╔═╡ d1f200ac-cd49-49b7-9872-284d00b132a4
md"$p_1 = z p_2 + c$"

# ╔═╡ 67dad664-363f-4e1a-91dd-48567fef0f7d
md"$p_2 = z p_1 + c$"

# ╔═╡ 2b0ab11b-feb4-4806-b8b4-e0ef31cca966
md"If we slightly rearrange them, then we get following:"

# ╔═╡ 5e6e6ef1-c204-4539-ad9b-22701757aca0
md"$p_1 - z p_2 = c$"

# ╔═╡ bb5bb265-47e5-4cf1-9e7f-e4d732129da6
md"$p_2 - z p_1 = c$"

# ╔═╡ d1ab33d9-24c8-4907-836b-871881e2f6e6
md"Now, the right hand side of both equations is same. So we can equate them, doing so we get:"

# ╔═╡ d1836b8c-04ff-472c-87b5-5d17fd598800
md"$p_1 - z p_2 = p_2 - z p_1$"

# ╔═╡ 258ff35e-4ebb-4f86-b998-e22de4cd3c80
md"Doing some rearrangement, we have:"

# ╔═╡ e824214a-358f-444e-9edb-28dd02771385
md"$(1+z) p_1 = (1+z) p_2$"

# ╔═╡ e67739be-8640-48ef-97c4-96783526b31f
md"$p_1  = p_2$"

# ╔═╡ ed889af3-b640-403b-b295-8ff164b26194
md"Finally, we see that we need to keep our prices exactly same as that of the competitor. Also, since $p_1$ and $p_2$ are same, the simultaneous equations are same, thus the straight line that we get when we plot, they overlap."

# ╔═╡ 25379002-3be5-11eb-28e7-35c7828f0b03
md""" ### Function Library and Dependencies"""

# ╔═╡ 2fd16772-292a-11eb-00dd-2d5cfc02738f
hint(text) = Markdown.MD(Markdown.Admonition("hint", "Hint", [text]));

# ╔═╡ 363db0ee-292a-11eb-01fd-bf502e702f62
almost(text) = Markdown.MD(Markdown.Admonition("warning", "Almost there!", [text]));

# ╔═╡ 46c457d0-292a-11eb-3384-07fec48a0c4c
keep_working(text=md"The answer is not quite right.") = Markdown.MD(Markdown.Admonition("danger", "Keep working on it!", [text]));

# ╔═╡ 48dd4cc0-292a-11eb-12a7-93530ba75030
correct(text=md"Great! You got the right answer! Let's move on to the next section.") = Markdown.MD(Markdown.Admonition("correct", "Got it!", [text]));

# ╔═╡ 130d779e-2934-11eb-30f9-07aa74fbf031
if p_max==string(z1*p2_1)
	best_price = z1*p2_1;
	correct(md"Correct! $(best_price) dollars per widget is the price that gives you the highest possible profit")
else
	keep_working(md"Your price is not quite right.")
end

# ╔═╡ d4c21190-28fc-11eb-1bdc-23a173871c11
plotly();

# ╔═╡ Cell order:
# ╟─5583c650-28f5-11eb-3014-81692bc247a8
# ╟─d3579790-69fd-42af-b730-1baa3513a01d
# ╟─51d0afc0-28fd-11eb-2b63-53e23d9755bd
# ╟─efa32c10-28fc-11eb-0f2e-13eef13572fd
# ╟─60c46850-2902-11eb-0acd-33c703ce2e24
# ╟─ef20f2d2-2b64-11eb-0e3f-8be6958ab3db
# ╟─360039f0-2902-11eb-03ab-c72d4a43a39e
# ╟─13638050-2907-11eb-00d8-7990376cdbd2
# ╟─cd06bd90-2922-11eb-0348-fd41bf483c07
# ╟─94849422-2b65-11eb-349a-299e4462a479
# ╟─63489f30-2923-11eb-0d71-ed07ae0502a5
# ╟─9bdcecae-2933-11eb-01f9-b752cfa9b383
# ╟─d31ac530-2933-11eb-180f-dda8d96989be
# ╟─130d779e-2934-11eb-30f9-07aa74fbf031
# ╟─f053711e-3661-11eb-310f-dfa02c634d60
# ╟─4b6afa22-2b67-11eb-2988-19374acc17e5
# ╟─48a810f0-2b64-11eb-3359-357168fcaf81
# ╟─e9dd9c20-2b68-11eb-0ff5-2bb89d25d440
# ╟─182aa320-2b69-11eb-318f-111c47f097cf
# ╟─5e47db20-2b69-11eb-1728-19dcfb42a6e3
# ╟─da57a6f0-2b69-11eb-0222-b7e10b1ee072
# ╟─1d8703bc-7615-45c6-a9b8-9e96bd574075
# ╟─3b1e8d42-f0a0-4465-bbb6-e1194591104f
# ╟─7d2c5acd-99b2-4331-ad1a-b564141242d7
# ╟─d8fabfcd-3024-4eed-8269-50ebc0219382
# ╟─e1d79823-f6ce-41f8-a59e-1bd9ea5dc7bf
# ╟─e4740cdb-3173-462b-a52a-7a137e92b176
# ╟─3cc380ba-087c-4652-a5fc-0b38fc924988
# ╟─967025d7-6a41-4cbc-922d-0929bc131e31
# ╟─2b4c8d2a-c630-4880-b159-c688e807a7cb
# ╟─1e2c2cf3-0203-41ad-b77b-e4299f05699d
# ╟─ebc960a0-ef78-400a-acfe-beff3c29f1ea
# ╟─cbd49c5b-30b6-4cdd-9579-b12ebb1ea452
# ╟─24f81d5d-65dc-4c3c-8774-0d07c60b3425
# ╟─e13baa1b-8673-4604-b9b1-81f2c0065c62
# ╟─a9a1aa52-a1e0-4138-b319-ca0d5e396ec1
# ╟─00c57980-2e5c-4fa6-9201-b1747a67dcf5
# ╟─087ba9a3-22e1-4563-9d46-c077f1fab261
# ╟─ac0bb825-0398-45ae-a1c7-4900476edc10
# ╟─4b527b18-b936-4531-967c-53026d5466bb
# ╟─59b96ff3-da67-44c4-963b-2c60a41c7c41
# ╟─30ac2283-67d6-40d1-920b-ce6ffb89b655
# ╟─a8dc8a6d-da26-460c-ad79-5abcbaa83fd4
# ╟─0cfde8ea-70c4-4bf9-9c23-c8d5882f6c29
# ╠═68669148-0ebe-4b6d-bd21-8fee64cdf042
# ╟─3baa1d44-d7a1-454e-82ca-462fa5973944
# ╟─abc5e1cf-5993-4058-b468-62fff03c7551
# ╟─ff78c74c-c612-4f5a-ab96-d4457108b96f
# ╟─c37e05ad-d796-40e9-8e91-c9b59f6a3b53
# ╟─28ae083a-1963-42de-af42-e99b32a2ea9c
# ╟─78799609-569b-4fcc-9782-748b3ee351b2
# ╟─70889a16-347d-4f7e-a43e-eb1840dc56c4
# ╟─02b8aaa7-e511-4cd0-b7be-eef84eae7c05
# ╟─a84f0cda-c4e8-442a-b4a0-d09fe1fbf79a
# ╟─f7bdc8e8-f6ba-47ec-b782-8b322f115a1c
# ╟─75e70d30-b47b-4ff7-8810-7d554600f90d
# ╟─0f26a8a2-0223-411c-8467-bbf34d8a1dc3
# ╟─ee69ce13-849b-40fb-a7cd-a7ca5a59f7db
# ╟─e58d6c0e-219c-4733-83b8-805273fd4045
# ╟─803329b8-c617-4d39-ac19-0e27c328e770
# ╟─c2eab38b-abc3-48b2-b113-97f5d982c0b7
# ╟─fb5a8d0b-9eda-4a5a-9cb0-e5d8db5cff16
# ╟─6268858c-2ec0-4c94-b407-22a756487d42
# ╟─8ae41a84-55db-43e8-a5ac-65b45bc4ff0b
# ╟─04c3526b-4211-4aa0-9401-32aaf8fff08c
# ╟─08be3f21-5cae-4c69-88fe-9c0abc8f2345
# ╟─2981ffa5-f9d6-422f-8e70-3c515800149f
# ╟─82a5a7e7-4130-453e-afca-113d3102aeee
# ╟─a093d64d-1626-4c31-96fa-698de1313c6d
# ╟─8b6d080e-b567-4e7d-84aa-db68dc0617a2
# ╟─dbb8934c-49dd-4ddd-a3ef-78560b8b5390
# ╟─58b1c989-5d9c-479e-8731-8e275993ddd6
# ╟─6bdead12-af4d-482b-9df0-d9079914aa4b
# ╟─d1f200ac-cd49-49b7-9872-284d00b132a4
# ╟─67dad664-363f-4e1a-91dd-48567fef0f7d
# ╟─2b0ab11b-feb4-4806-b8b4-e0ef31cca966
# ╟─5e6e6ef1-c204-4539-ad9b-22701757aca0
# ╟─bb5bb265-47e5-4cf1-9e7f-e4d732129da6
# ╟─d1ab33d9-24c8-4907-836b-871881e2f6e6
# ╟─d1836b8c-04ff-472c-87b5-5d17fd598800
# ╟─258ff35e-4ebb-4f86-b998-e22de4cd3c80
# ╟─e824214a-358f-444e-9edb-28dd02771385
# ╟─e67739be-8640-48ef-97c4-96783526b31f
# ╟─ed889af3-b640-403b-b295-8ff164b26194
# ╠═25379002-3be5-11eb-28e7-35c7828f0b03
# ╟─2fd16772-292a-11eb-00dd-2d5cfc02738f
# ╟─363db0ee-292a-11eb-01fd-bf502e702f62
# ╟─46c457d0-292a-11eb-3384-07fec48a0c4c
# ╟─48dd4cc0-292a-11eb-12a7-93530ba75030
# ╟─ce513430-28fc-11eb-0def-67b283cedb41
# ╟─653c8d80-2903-11eb-14c3-b52dd37a0111
# ╟─d4c21190-28fc-11eb-1bdc-23a173871c11
