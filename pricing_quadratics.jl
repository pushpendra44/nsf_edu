### A Pluto.jl notebook ###
# v0.19.11

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
	plot(p1_x,payoff1_x,title="The Price You Charge Per Widget vs. Your Profits - in Dollars",legend=false)
	plot!(xlims=(0,10),ylims=(0,60))
end

# ╔═╡ 9bdcecae-2933-11eb-01f9-b752cfa9b383
md"""This makes sense, right? If you charge nothing for your widget, you won't make any money. However, if you charge too much for your widget, you also won't make any money: nobdoy would buy your very expensive widget!

Based on the plot above, what price (in dollars) can you charge to maximize your profits? Change the number in the text box below to the correct amount"""

# ╔═╡ d31ac530-2933-11eb-180f-dda8d96989be
@bind p_max TextField(default="0")

# ╔═╡ f053711e-3661-11eb-310f-dfa02c634d60
md"""The shape of the plot of price versus profit above might look familiar - it is indeed a parabola, upside down! Remember that a function that generates a parabola is a *quadratic* function, which can be written $$ax^2 + bx + c$$. Here $$x$$ is your price $$p_1$$, and the output of the function is your profit. So, we have the following formula: $$profit_1 = ap_1^2 + bp_1 + c$$. 

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
@bind p2_2 Slider(2:1:8,default=5)

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
	plot(p1_x2,payoff1_x2,title="The Price You Charge Per Widget vs. Your Profits - in Dollars",legend=false)
	plot!(xlims=(0,10),ylims=(0,60))
end

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
# ╟─25379002-3be5-11eb-28e7-35c7828f0b03
# ╟─2fd16772-292a-11eb-00dd-2d5cfc02738f
# ╟─363db0ee-292a-11eb-01fd-bf502e702f62
# ╟─46c457d0-292a-11eb-3384-07fec48a0c4c
# ╟─48dd4cc0-292a-11eb-12a7-93530ba75030
# ╟─ce513430-28fc-11eb-0def-67b283cedb41
# ╟─653c8d80-2903-11eb-14c3-b52dd37a0111
# ╟─d4c21190-28fc-11eb-1bdc-23a173871c11
