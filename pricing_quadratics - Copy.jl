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
	Pkg.add("PlutoUI")
	Pkg.add("HypertextLiteral")
	using Plots
	using PlutoUI
	using HypertextLiteral
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
Imagine that you are operating a Lemonade stand at the summer event in your school. You sell each cup for a certain price, $$p_1$$. Unfortunately, there is also a competitor in the event. They are selling their lemonade cup for a certain price, $$p_2$$. How should you decide your price, $$p_1$$ to make the most amount of money? Use the slider below to change the price you charge for each cup, and see how your profit changes. 
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
md"We are charging $(p1_1) dollars each for our cup, and our competitor charges $(p2_1) dollars. We make $(profit1(p1_1, p2_1, a1, h1, c1, z1)) dollars in profits." 

# ╔═╡ cd06bd90-2922-11eb-0348-fd41bf483c07
#compute profit vector
begin
	p1_x = 0:.1:p2_1+c1+sqrt(h1/a1)
	payoff1_x = profit1(p1_x,p2_1, a1, h1, c1, z1)
end;
		

# ╔═╡ 349e4abd-891d-4818-a639-beff83d11ba1
md"Now let us input a few prices. Try and fill in the possible prices per cup of lemonade that you can think of between 0 to 10 dollars, in the boxes below (per cup price)." 

# ╔═╡ 76ba1374-2a7f-41a5-9ea4-4b3084732d74
@bind p1 TextField(default="0")

# ╔═╡ a22f8c00-f553-49e4-b69e-879327a3bcdf
@bind p2 TextField(default="0")

# ╔═╡ 5e8219c8-6213-4d41-a521-3b2cdb87a260
@bind p3 TextField(default="0")

# ╔═╡ 19af6cad-97fb-4104-bd28-56f1bdf8e588
@bind p4 TextField(default="0")

# ╔═╡ b6f4a321-b111-461e-bddc-702d7f024645
@bind p5 TextField(default="0")

# ╔═╡ be72ebc0-2542-489b-8a5d-653393bb38e8
@bind p6 TextField(default="0")

# ╔═╡ 4d702028-b89e-442d-b80a-9e6ea8ca9199
p = [parse(Float64,p1) parse(Float64,p2) parse(Float64,p3) parse(Float64,p4) parse(Float64,p5) parse(Float64,p6) ];

# ╔═╡ 85d12f5a-49e6-455a-aa0d-de43e7dd8970
payoff1_xx = profit1(p,p2_1, a1, h1, c1, z1);

# ╔═╡ ee2ef1c0-4c04-4ee3-9700-b339605ec0c9
md"If the above prices we just filled in were plotted agains the profit we will be making againt the corresponding price, the we will see the plot a below:"

# ╔═╡ 4cb9bf4a-4b11-4944-8420-bc9d0e8ae9b1
begin
	plot(p,payoff1_xx,title=" Your Profit (In dollars) vs Price You Charge per cup of Lemonade",legend=false, seriestype = :scatter)
	plot!(xlims=(-1,12),ylims=(-1,60))
end

# ╔═╡ 760f9d3a-184d-4c88-8a1d-7281d4757380
md"The plot is starting to take some familiar shape, isn't it 🤔? Now if we add sufficient points to plot we can get some better shape, let us ee what happens then."

# ╔═╡ 94849422-2b65-11eb-349a-299e4462a479
md"If you plotted the price $$p_1$$ (per cup price of lemonade) chosen on the slider on the x-axis of the graph, versus your profit on the y-axis, you would see something like the plot below:"

# ╔═╡ 63489f30-2923-11eb-0d71-ed07ae0502a5

begin
	plot(p1_x,payoff1_x,title=" Your Profit (In dollars) vs Price You Charge per cup of Lemonade",legend=false)
	plot!(xlims=(0,10),ylims=(0,60))
end

# ╔═╡ 9bdcecae-2933-11eb-01f9-b752cfa9b383
md"""This makes sense, right? You won't make any money if you charge nothing for your lemonade. However, if you charge too much for your lemonade, you also won't make any money: nobody will buy your very expensive lemonade!

Based on the plot above, what price (in dollars) can you charge to maximize your profits? Change the number in the text box below to the correct amount"""

# ╔═╡ d31ac530-2933-11eb-180f-dda8d96989be
@bind p_max TextField(default="0")

# ╔═╡ f053711e-3661-11eb-310f-dfa02c634d60
md"""The shape of the plot of price versus profit above might look familiar - it is indeed a parabola, upside down! Remember that a function that generates a parabola is a *quadratic* function, which can be written $$ax^2 + bx + c$$. Here $$x$$ is your price $$p_1$$, and the output of the function is your profit. So, we have the following formula: $$profit_1 = Ap_1^2 + Bp_1 + C$$. 

What are the other values? Well, the parabola is upside down, so we know that $a$ must be negative. This gives us the general shape: with low prices, we don't make a lot of money, with high prices, we don't make a lot of money, but there is some price in between that will make us the most money. $$A$$ is currently -2. But what happens to the plot if that changes? Try the slider below and see how it changes the plot.

""" 

# ╔═╡ 4b6afa22-2b67-11eb-2988-19374acc17e5
begin 
	p1_2 = 5;	
	@bind a2 Slider(2:0.5:4,default=a1)
end

# ╔═╡ 48a810f0-2b64-11eb-3359-357168fcaf81
md" $$A=$$ $(-a2)"

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
	plot(p1_x2,payoff1_x2,title="Your Profit (In dollars) vs Price You Charge Per cup of Lemonade",legend=false)
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
md"This can be done by solving the following quadratic equation for $p_1$: $Profit = -2p_1^2 +20p_1$. Also for simplicity, let us call $Profit$ is $P$."

# ╔═╡ 24f81d5d-65dc-4c3c-8774-0d07c60b3425
md"We can re-write the above quation as: $2p_1^2 -20p_1 +P =0$."

# ╔═╡ a442e791-c204-45d0-9a92-ae8d74d4d5ba
md"Now, for a given profit $P =40$, our quadratic equation will look like:"

# ╔═╡ 87954f7f-f71b-4284-8ea9-ad6df83a27e7
#texeq("2p_1^2 -20p_1 + 40 = 0")

md"$2p_1^2 -20p_1 + 40 = 0$"

# ╔═╡ 7b1e059a-c2e4-4679-88af-5f6d301aa4ae
md"We will now learn two methods to solve quadratic equations."

# ╔═╡ 040d7129-eec3-4fff-a247-4bc60f5b6b56
md"""
###### 1. Completing the Square
"""

# ╔═╡ 872d0692-414c-4a83-bbf2-a751859ce684
md"We start with some basic formula that we already know. Let us assume we have two variables $x$ and $a$."

# ╔═╡ dded2a56-ef8c-450c-bb4b-d95212ff471f
md"We know that sum of square of two variables is given by:"

# ╔═╡ 347315a3-cba2-4173-a3f9-a87a84ca5778
md"$(x+a)^2 = x^2 +2ax + a^2$"

# ╔═╡ 50ca24a7-dc10-4ce8-b1a0-39d80cc31987
md"Let us compare our quadratic equation $2p_1^2 -20p_1 + 40 = 0$ with equation above
$x^2 +2ax + a^2$."

# ╔═╡ f9ca70bb-983a-4122-b8a4-f9d1e8c87d2a
md"Here $p_1$ corresponds to $x$. Also, in our formula for the square of the sum of two variables, the coefficient of $x$ is 1. To get there, we will divide our quadratic equation by 2:"

# ╔═╡ 9e76a09f-9a4f-4561-a673-1f5ffe8996ad
md"$2p_1^2 -20p_1 + 40 = 0$"

# ╔═╡ 9e9d9de1-0b4c-4693-9074-d7a22be75fa5
md"After dividing both sides by 2 (or coefficient of squared term), we get:"

# ╔═╡ a94ccf77-313e-48ad-a754-4798134684e2
md"$p_1^2 -10p_1 + 20 = 0$"

# ╔═╡ c14d6bbc-fdae-427e-9b38-649a796ef252
md"Now we again compare our new quadratic equation with $(x+a)^2 = x^2 + 2ax + a^2$"

# ╔═╡ 82972bce-810f-4d29-a81a-6e90361af1b2
md"The coefficient of $p_1$, which we know to be -10, should be equal to $2a$. This means:"

# ╔═╡ eb3e0fec-9b7d-40f1-929e-47772bb20780
md"Choose the correct value of $a$ from options below"

# ╔═╡ 4c5da869-a23e-4704-8428-06390342c793
@bind val_a MultiSelect(["10", "5", "-10", "-5"])

# ╔═╡ 4259cb82-0536-4a60-881a-8588dec6fdbb
	if "-5" ∈ val_a
		"Correct! 👌"
	else
		"Good choice, but not the right one! Try again!"
	end

# ╔═╡ 04b3ca2b-5217-4464-bdd5-1932dbc9413c
md"The last term of our quadratic is 20, which is equivalent to $a^2$ in general formula of $(x+a)^2$."

# ╔═╡ 8f68b3c0-b51b-4219-b34e-8206df44f28e
md"We know $a^2 = 25$. But the last term of our equation is 20, which is not what we want 😒."

# ╔═╡ e1590012-ac9a-44bb-8997-05dbb8272a1c
md"What should we do now? 🤷‍♀️"

# ╔═╡ 9def18dd-ff26-4f30-9c1d-419feb38a106
md"Try chosing one of the options below to see what is our way out of this situation."

# ╔═╡ 71651eab-421e-4659-a493-baba5f6728f9
@bind option MultiSelect(["Add 5 on Right-hand-side ", "Add 5 on Left-hand-side ", "Add 5 on both sides", "Run Away! 😀"])

# ╔═╡ c70d97f5-95b1-4f2e-af65-a8ae7f0d2868
	if "Add 5 on both sides" ∈ option
		"Yum Yum! 👌"
	else
		"Good choice, but not the right one! Try again!"
	end

# ╔═╡ 98f41517-0854-4ae4-bee6-7c7015125981
md"Cool! We now have all the ingredients of this delicious recipe to solve our quadratic equation. We add 5 to both the sides of our equation and we get:"

# ╔═╡ 014894bf-68a1-49f6-a699-31950df4a626
md"$p_1^2 -10p_1 + 20 +5 = 0 +5$"

# ╔═╡ bdaba1e4-1b85-48ab-9ce3-1dbf2e229049
md"$p_1^2 -10p_1 + 25 = 5$"

# ╔═╡ 2b849a00-2816-4d60-b88c-8b296683c57e
md"The left-hand side is now a perfect square. Can you tell the expression for that? Try choosing from following options:"

# ╔═╡ 07c17971-873c-44c3-9698-a61a12aceded
md"1: $(p_1 + 5)^2$"

# ╔═╡ 54fd02ac-6cce-4392-9069-ce9864f3c31e
md"2: $(p_1 - 5)^2$"

# ╔═╡ 9b2e5360-96d0-4774-a9f3-747e9fd8cb7b
md"3: I don't like this! 🤐"

# ╔═╡ 1e71b11b-6bff-40d9-bfcf-6530c7274cf0
@bind corr MultiSelect(["1", "2", "I don't like this! 🤐"])

# ╔═╡ 54e3f9bf-54af-40af-93db-7e55e07e26b7
if "2" ∈ corr
		"Perfect! You are correct.👌"
	else
		"Good choice, but not the right one! Try again!"
	end

# ╔═╡ e8c2100d-0199-41c4-bca7-ae9805426956
md"Now, the complete equation will be:"

# ╔═╡ d9d06ff9-e95b-473f-82f6-daaa7c442249
md"$(p_1-5)^2 = 5$"

# ╔═╡ 78cae168-03f4-44e0-b8dc-3da3007824d5
md"We take the square root of both the sides."

# ╔═╡ ae0f240c-3a61-4e3f-be4e-ff2e513ad534
md"$\sqrt((p_1 -5)^2) = \sqrt(5)$"

# ╔═╡ 6981ae19-6f64-4b80-bf9d-5232025e69e7
md"$p_1  = 5 \pm 2.236$"

# ╔═╡ 4aea273d-685b-4447-8cf9-de5e4759644b
md"We have both the solutions now, we can cpick whatever price of the above. Try chosing one of the options below to see if you made right choice of not."

# ╔═╡ 930c7a9f-3ddd-484d-9f27-ecb19f54ab3b
@bind opt MultiSelect(["7.236", "2.763", "None of them, I think they are wrong!"])

# ╔═╡ 40a1af0c-bbc7-467a-a98a-82a59521db4d
if "2.763" ∈ opt
		md"Great work! 😀 This is because, no matter what price, from the above 2 choices, you pick, you will make the same profit. Remember the inverse parabola graph. If now take a look below!"
	else
		"Good choice, but not the right one! Try again!"
	end

# ╔═╡ 6d3d7b6d-93f0-4ef1-9abe-34a19954c873
begin
	plot(p1_x2,payoff1_x2,title="Your Profit (In dollars) vs Price You Charge Per cup of Lemonade",legend=false)
	plot!(xlims=(0,10),ylims=(0,60))
end

# ╔═╡ 1e968bab-c6d4-4a38-8b8d-7422f5a63760
md"So, given our competitor lemonade stand set their price to $5 a cup, to gain the profit of $50, we should sell our lemonade at the same price, i.e. $5 a cup of lemonade."

# ╔═╡ f643f03f-b6ab-476d-9a21-d9bbcdf98b68
 md"So, now we know that if our competitor Lemonade stand has set their price to a certain vaule then, we can get the price at which we should sell our lemonade to gain the profit we want."   

# ╔═╡ 8b0e1c8d-fe66-4ff3-a346-9820c66ad1e7
md"""
###### 2. Using direct formula
"""

# ╔═╡ 6163acf1-1f45-4ff7-b98b-73e7e19c71b4
md"**Note:** In this case it was easy to complete the square to find the perfect square on one side of the equation. But things can get complicated if the signs of coefficients are negative and also if complex numbers are involved. Plus it needs lot of work if you need to find the price for different profits."

# ╔═╡ addb0185-bcfb-4775-a525-c09b49e8d3c0
md"We will now introduce the formula which will directly give us the vaule of variable for which we are solving the quadratic equation."

# ╔═╡ 988308cf-fab0-4b03-ae7a-4365a8555159
md"For any quadratic equation $x^2 +bx + c =0$, the value of the $x$ is given by:"

# ╔═╡ 09393abe-64e6-451e-86e5-e0cbe4629d92
md"$x = \frac{-b \pm \sqrt(b^2 - 4ac)}{2a}$"

# ╔═╡ 087ba9a3-22e1-4563-9d46-c077f1fab261
md"Now we solve the above quadratic equation using following formula: and get:"

# ╔═╡ ac0bb825-0398-45ae-a1c7-4900476edc10
md"$p_1 = \frac{-(-10) + \sqrt((-10)^2 - 4*1*20)}{2*1}$"

# ╔═╡ 953b86f9-f2e4-4aba-acaf-88916f6a1457
md"We get same two results: $p_1 = 5 \pm 2.236$. And we chose 2.763 for the same reason we saw earlier."

# ╔═╡ 4b792195-364a-4e2c-bd83-ea4f91912229
md"Now, try changing the profit to different values to see your corresponding price."

# ╔═╡ 9699b05f-ccad-4e7d-8ce4-def73eafdb1f
@bind prof Slider(0:5:50,default=50)

# ╔═╡ c42ea703-a097-4a1d-989b-008bafb1fd61
md" $$Profit=$$ $(prof)"

# ╔═╡ e7e2d7af-df93-440b-8bee-cdc60dc106a2
#defining our price quadratic terms
begin
	constant_term = C - prof
end;

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

# ╔═╡ a51d64ab-74c1-4a80-a404-b354ea85ef38
md"Below is the graph for your price versus your profit."

# ╔═╡ a8dc8a6d-da26-460c-ad79-5abcbaa83fd4
begin
	plot(prof_x,price_cal,title="Your Price vs. Your Profit (in \$)",legend=false)
	plot!(xlims=(0,60),ylims=(0,10))
end

# ╔═╡ 0cfde8ea-70c4-4bf9-9c23-c8d5882f6c29
md""

# ╔═╡ 68669148-0ebe-4b6d-bd21-8fee64cdf042
md"""
#### Best Response and plotting the linear equation
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
md"Well, that does not seem to be an efficient way to do this."

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

# ╔═╡ ad04bd37-9d68-4671-a34c-0f80916cf503
md"Fill in some values of prices for your lemonade that you can think of between 0 to 50"

# ╔═╡ e55f5791-332e-48c5-8385-f9cac2fa28a7
@bind q1 TextField(default="0")

# ╔═╡ f9f8addd-d448-45b2-b041-79287e8efa7d
@bind q2 TextField(default="0")

# ╔═╡ 6d04a75e-a1ad-47ef-a3f4-931b3f875926
@bind q3 TextField(default="0")

# ╔═╡ 967f2a3c-65a3-4e29-bd8b-329687b4130f
@bind q4 TextField(default="0")

# ╔═╡ 92ea7229-792b-488d-9160-51389cca905a
@bind q5 TextField(default="0")

# ╔═╡ d8744d41-96db-4811-a64a-f547c5943ecd
md"Now fill in some prices of your comptitor."

# ╔═╡ 75068aa8-55e9-4bfa-b485-398d88339905
@bind q6 TextField(default="0")

# ╔═╡ 905ba30e-e07a-495f-84a2-ef809eb77450
@bind q7 TextField(default="0")

# ╔═╡ 032ea186-411b-416f-b1f7-7b12235c992c
@bind q8 TextField(default="0")

# ╔═╡ e9119c43-4f93-40f8-9f3e-c4b4c6a1c404
@bind q9 TextField(default="0")

# ╔═╡ 7c7ed744-0e13-404a-bdda-7c8b7a5fbf39
@bind q10 TextField(default="0")

# ╔═╡ 4136fcf5-6937-4f4c-9985-ce251bcb0492
qq = [parse(Float64,q1) parse(Float64,q2) parse(Float64,q3) parse(Float64,q4) parse(Float64,q5)];

# ╔═╡ 2e2a159b-47c2-4345-a44a-046161258918
qqq = [parse(Float64,q6) parse(Float64,q7) parse(Float64,q8) parse(Float64,q9) parse(Float64,q10)];

# ╔═╡ 70a524d7-7cfc-4f92-a3b2-238a9ec172a0
md"The point we filled in gave us the plot below. This is indeed a graph of straight line!"

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
	x = 0:0.1:20
	price1(x) = z1.*x .+ c1
	price2(x) = z1.*x .+ c1
end;

# ╔═╡ 5f890e95-0372-4eb0-91b7-3439600c697d
pprice1 = price1(qqq);

# ╔═╡ 42f9fff9-633a-4937-b7f4-23098465e2da
pprice2 = price2(qq);

# ╔═╡ dbed1617-8d74-49bf-b139-766e1825ea2d
begin
	plot(pprice2, qq, seriestype = :scatter, legend =false)
	plot!(pprice1, qqq, seriestype = :scatter)
end

# ╔═╡ 0f774279-3692-4b0b-a83a-edec1c2e2ab3
md"Do the equations of best responses look familiar? Yes, they are equations of straight lines. Now let us plot these on a graph, where our y-axis is the price of our company i.e., $p_1$ and the x-axis is $p_2$."

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
md"Finally, we see that we need to keep our price exactly the same as that of the competitor. Also, since $p_1$ and $p_2$ are the same, the simultaneous equations are the same, thus the straight line that we get when we plot, they overlap."

# ╔═╡ 7b55df48-4f44-4f41-b9b0-0940e33fe27f


# ╔═╡ b0653feb-7335-4dcd-9c8b-a64978fff6f0


# ╔═╡ 4d809cbb-14e8-4c71-912f-7a19934f2853


# ╔═╡ 6db26609-715f-47d4-b656-e7c20bfd80df


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

# ╔═╡ 06128939-5539-4971-a309-02e3128b0f3f
js(x) = HypertextLiteral.JavaScript(x)

# ╔═╡ 00474f8d-4005-48f3-ba97-4f096e4ce34f
"""
`texeq(code::String)`
Take an input string and renders it inside an equation environemnt (numbered) using KaTeX
Equations can be given labels by adding `"\\\\label{name}"` inside the `code` string and subsequently referenced in other cells using `eqref("name")`
# Note
Unfortunately backward slashes have to be doubled when creating the TeX code to be put inside the equation
When Pluto will support interpretation of string literal macros, this could be made into a macro
"""
function texeq(code,env="equation")
	code_escaped = code 			|>
	x -> replace(x,"\\" => "\\\\")	|>
	x -> replace(x,"\n" => " ")
	println(code_escaped)
	@htl """
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.13.11/dist/katex.min.css" integrity="sha384-Um5gpz1odJg5Z4HAmzPtgZKdTBHZdw8S29IecapCSB31ligYPhHQZMIlWLYQGVoc" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/katex@0.13.11/dist/katex.min.js" integrity="sha384-YNHdsYkH6gMx9y3mRkmcJ2mFUjTd0qNQQvY9VYZgQd7DcN7env35GzlmFaZ23JGp" crossorigin="anonymous"></script>
	
	<script>
	katex.render('\\\\begin{$(js(env))} $(js(code_escaped)) \\\\end{$(js(env))}',currentScript.parentElement,{
					displayMode: true,
					trust: context => [
						'\\\\htmlId', 
						'\\\\href'
					].includes(context.command),
					macros: {
					  "\\\\label": "\\\\htmlId{#1}{}"
					},
				})
	</script>
	"""
end

# ╔═╡ 91acc894-e8d5-40c8-9560-8c3cc3df9da7
"""
`eqref(label::String)`
Function that create an hyperlink pointing to a previously defined labelled equation using `texeq()`
"""
eqref(label) = @htl """
<a eq_id="$label" id="eqref_$label" href="#$label" class="eq_href">(?)</a>
"""

# ╔═╡ 2962d5c6-9940-4111-a82b-9752bdd089ad
@htl """
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/katex@0.13.11/dist/katex.min.css" integrity="sha384-Um5gpz1odJg5Z4HAmzPtgZKdTBHZdw8S29IecapCSB31ligYPhHQZMIlWLYQGVoc" crossorigin="anonymous">
<style>
a.eq_href {
	text-decoration: none;
}
</style>
		<script src="https://cdn.jsdelivr.net/npm/katex@0.13.11/dist/katex.min.js" integrity="sha384-YNHdsYkH6gMx9y3mRkmcJ2mFUjTd0qNQQvY9VYZgQd7DcN7env35GzlmFaZ23JGp" crossorigin="anonymous"></script>
<script id="katex-eqnum-script">
const a_vec = [] // This will hold the list of a tags with custom click, used for cleaning listeners up upon invalidation
const eqrefClick = (e) => {
	e.preventDefault() // This prevent normal scrolling to link
	const a = e.target
	const eq_id = a.getAttribute('eq_id')
	window.location.hash = 'eqref-' + eq_id // This is to be able to use the back function to resume previous view, 'eqref-' is added in front to avoid the viewport actually going to the equation without having control of the scroll
	const eq = document.getElementById(eq_id)
	eq.scrollIntoView({
		behavior: 'smooth',
		block: 'center',
	})
}
const checkCounter = (item, i) => {
	return item.classList.contains('enclosing')	?
	i											:
	i + 1
}
const updateCallback = () => {
a_vec.splice(0,a_vec.length) // Reset the array
const eqs = document.querySelectorAll('span.enclosing, span.eqn-num')
let i = 0;
eqs.forEach(item => {
	i = checkCounter(item,i)
	console.log('item',i,'=',item)
	if (item.classList.contains('enclosing')) {
		const id = item.id
		const a_vals = document.querySelectorAll(`[eq_id=\${id}]`)
		a_vals !== null && a_vals.forEach(a => {
			a_vec.push(a) // Add this to the vector
			a.innerText = `(\${i+1})`
			a.addEventListener('click',eqrefClick)
		})
	}
})
}
const notebook = document.querySelector("pluto-notebook")
// We have a mutationobserver for each cell:
const observers = {
	current: [],
}
const createCellObservers = () => {
	observers.current.forEach((o) => o.disconnect())
	observers.current = Array.from(notebook.querySelectorAll("pluto-cell")).map(el => {
		const o = new MutationObserver(updateCallback)
		o.observe(el, {attributeFilter: ["class"]})
		return o
	})
}
createCellObservers()
// And one for the notebook's child list, which updates our cell observers:
const notebookObserver = new MutationObserver(() => {
	updateCallback()
	createCellObservers()
})
notebookObserver.observe(notebook, {childList: true})
invalidation.then(() => {
	notebookObserver.disconnect()
	observers.current.forEach((o) => o.disconnect())
	a_vec.forEach(a => a.removeEventListener('click',eqrefClick))
})
</script>
"""

# ╔═╡ d4c21190-28fc-11eb-1bdc-23a173871c11
plotly();

# ╔═╡ 6908c884-b757-40c7-928a-2d8f2c69d67b


# ╔═╡ 4689cc6f-6147-4b9c-a957-5372fb39bf37


# ╔═╡ 7d18136f-77b8-49b8-b854-e9327792999d


# ╔═╡ 6962f00a-ae7b-44ac-92bc-09610d77089c


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
# ╟─349e4abd-891d-4818-a639-beff83d11ba1
# ╟─76ba1374-2a7f-41a5-9ea4-4b3084732d74
# ╟─a22f8c00-f553-49e4-b69e-879327a3bcdf
# ╟─5e8219c8-6213-4d41-a521-3b2cdb87a260
# ╟─19af6cad-97fb-4104-bd28-56f1bdf8e588
# ╟─b6f4a321-b111-461e-bddc-702d7f024645
# ╟─be72ebc0-2542-489b-8a5d-653393bb38e8
# ╟─4d702028-b89e-442d-b80a-9e6ea8ca9199
# ╟─85d12f5a-49e6-455a-aa0d-de43e7dd8970
# ╟─ee2ef1c0-4c04-4ee3-9700-b339605ec0c9
# ╟─4cb9bf4a-4b11-4944-8420-bc9d0e8ae9b1
# ╟─760f9d3a-184d-4c88-8a1d-7281d4757380
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
# ╟─a442e791-c204-45d0-9a92-ae8d74d4d5ba
# ╟─87954f7f-f71b-4284-8ea9-ad6df83a27e7
# ╟─7b1e059a-c2e4-4679-88af-5f6d301aa4ae
# ╟─040d7129-eec3-4fff-a247-4bc60f5b6b56
# ╟─872d0692-414c-4a83-bbf2-a751859ce684
# ╟─dded2a56-ef8c-450c-bb4b-d95212ff471f
# ╟─347315a3-cba2-4173-a3f9-a87a84ca5778
# ╟─50ca24a7-dc10-4ce8-b1a0-39d80cc31987
# ╟─f9ca70bb-983a-4122-b8a4-f9d1e8c87d2a
# ╟─9e76a09f-9a4f-4561-a673-1f5ffe8996ad
# ╟─9e9d9de1-0b4c-4693-9074-d7a22be75fa5
# ╟─a94ccf77-313e-48ad-a754-4798134684e2
# ╟─c14d6bbc-fdae-427e-9b38-649a796ef252
# ╟─82972bce-810f-4d29-a81a-6e90361af1b2
# ╟─eb3e0fec-9b7d-40f1-929e-47772bb20780
# ╟─4c5da869-a23e-4704-8428-06390342c793
# ╟─4259cb82-0536-4a60-881a-8588dec6fdbb
# ╟─04b3ca2b-5217-4464-bdd5-1932dbc9413c
# ╟─8f68b3c0-b51b-4219-b34e-8206df44f28e
# ╟─e1590012-ac9a-44bb-8997-05dbb8272a1c
# ╟─9def18dd-ff26-4f30-9c1d-419feb38a106
# ╟─71651eab-421e-4659-a493-baba5f6728f9
# ╟─c70d97f5-95b1-4f2e-af65-a8ae7f0d2868
# ╟─98f41517-0854-4ae4-bee6-7c7015125981
# ╟─014894bf-68a1-49f6-a699-31950df4a626
# ╟─bdaba1e4-1b85-48ab-9ce3-1dbf2e229049
# ╟─2b849a00-2816-4d60-b88c-8b296683c57e
# ╟─07c17971-873c-44c3-9698-a61a12aceded
# ╟─54fd02ac-6cce-4392-9069-ce9864f3c31e
# ╟─9b2e5360-96d0-4774-a9f3-747e9fd8cb7b
# ╟─1e71b11b-6bff-40d9-bfcf-6530c7274cf0
# ╟─54e3f9bf-54af-40af-93db-7e55e07e26b7
# ╟─e8c2100d-0199-41c4-bca7-ae9805426956
# ╟─d9d06ff9-e95b-473f-82f6-daaa7c442249
# ╟─78cae168-03f4-44e0-b8dc-3da3007824d5
# ╟─ae0f240c-3a61-4e3f-be4e-ff2e513ad534
# ╟─6981ae19-6f64-4b80-bf9d-5232025e69e7
# ╟─4aea273d-685b-4447-8cf9-de5e4759644b
# ╟─930c7a9f-3ddd-484d-9f27-ecb19f54ab3b
# ╟─40a1af0c-bbc7-467a-a98a-82a59521db4d
# ╟─6d3d7b6d-93f0-4ef1-9abe-34a19954c873
# ╟─1e968bab-c6d4-4a38-8b8d-7422f5a63760
# ╟─f643f03f-b6ab-476d-9a21-d9bbcdf98b68
# ╟─8b0e1c8d-fe66-4ff3-a346-9820c66ad1e7
# ╟─6163acf1-1f45-4ff7-b98b-73e7e19c71b4
# ╟─addb0185-bcfb-4775-a525-c09b49e8d3c0
# ╟─988308cf-fab0-4b03-ae7a-4365a8555159
# ╟─09393abe-64e6-451e-86e5-e0cbe4629d92
# ╟─087ba9a3-22e1-4563-9d46-c077f1fab261
# ╟─ac0bb825-0398-45ae-a1c7-4900476edc10
# ╟─953b86f9-f2e4-4aba-acaf-88916f6a1457
# ╟─4b792195-364a-4e2c-bd83-ea4f91912229
# ╟─9699b05f-ccad-4e7d-8ce4-def73eafdb1f
# ╟─c42ea703-a097-4a1d-989b-008bafb1fd61
# ╟─e7e2d7af-df93-440b-8bee-cdc60dc106a2
# ╟─4b527b18-b936-4531-967c-53026d5466bb
# ╟─59b96ff3-da67-44c4-963b-2c60a41c7c41
# ╟─30ac2283-67d6-40d1-920b-ce6ffb89b655
# ╟─a51d64ab-74c1-4a80-a404-b354ea85ef38
# ╟─a8dc8a6d-da26-460c-ad79-5abcbaa83fd4
# ╟─0cfde8ea-70c4-4bf9-9c23-c8d5882f6c29
# ╟─68669148-0ebe-4b6d-bd21-8fee64cdf042
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
# ╟─ad04bd37-9d68-4671-a34c-0f80916cf503
# ╟─e55f5791-332e-48c5-8385-f9cac2fa28a7
# ╟─f9f8addd-d448-45b2-b041-79287e8efa7d
# ╟─6d04a75e-a1ad-47ef-a3f4-931b3f875926
# ╟─967f2a3c-65a3-4e29-bd8b-329687b4130f
# ╟─92ea7229-792b-488d-9160-51389cca905a
# ╟─d8744d41-96db-4811-a64a-f547c5943ecd
# ╟─75068aa8-55e9-4bfa-b485-398d88339905
# ╟─905ba30e-e07a-495f-84a2-ef809eb77450
# ╟─032ea186-411b-416f-b1f7-7b12235c992c
# ╟─e9119c43-4f93-40f8-9f3e-c4b4c6a1c404
# ╟─7c7ed744-0e13-404a-bdda-7c8b7a5fbf39
# ╟─4136fcf5-6937-4f4c-9985-ce251bcb0492
# ╟─2e2a159b-47c2-4345-a44a-046161258918
# ╟─5f890e95-0372-4eb0-91b7-3439600c697d
# ╟─42f9fff9-633a-4937-b7f4-23098465e2da
# ╟─70a524d7-7cfc-4f92-a3b2-238a9ec172a0
# ╟─dbed1617-8d74-49bf-b139-766e1825ea2d
# ╟─6268858c-2ec0-4c94-b407-22a756487d42
# ╟─8ae41a84-55db-43e8-a5ac-65b45bc4ff0b
# ╟─04c3526b-4211-4aa0-9401-32aaf8fff08c
# ╟─0f774279-3692-4b0b-a83a-edec1c2e2ab3
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
# ╟─7b55df48-4f44-4f41-b9b0-0940e33fe27f
# ╟─b0653feb-7335-4dcd-9c8b-a64978fff6f0
# ╟─4d809cbb-14e8-4c71-912f-7a19934f2853
# ╟─6db26609-715f-47d4-b656-e7c20bfd80df
# ╟─25379002-3be5-11eb-28e7-35c7828f0b03
# ╟─2fd16772-292a-11eb-00dd-2d5cfc02738f
# ╟─363db0ee-292a-11eb-01fd-bf502e702f62
# ╟─46c457d0-292a-11eb-3384-07fec48a0c4c
# ╟─48dd4cc0-292a-11eb-12a7-93530ba75030
# ╟─06128939-5539-4971-a309-02e3128b0f3f
# ╟─00474f8d-4005-48f3-ba97-4f096e4ce34f
# ╟─91acc894-e8d5-40c8-9560-8c3cc3df9da7
# ╟─2962d5c6-9940-4111-a82b-9752bdd089ad
# ╟─ce513430-28fc-11eb-0def-67b283cedb41
# ╟─653c8d80-2903-11eb-14c3-b52dd37a0111
# ╟─d4c21190-28fc-11eb-1bdc-23a173871c11
# ╠═6908c884-b757-40c7-928a-2d8f2c69d67b
# ╠═4689cc6f-6147-4b9c-a957-5372fb39bf37
# ╠═7d18136f-77b8-49b8-b854-e9327792999d
# ╠═6962f00a-ae7b-44ac-92bc-09610d77089c
