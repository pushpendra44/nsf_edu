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

# ╔═╡ bfe1210c-6ac8-497d-8ef8-545991488ddb
begin
	import Pkg
	Pkg.activate(mktempdir())
end

# ╔═╡ 6186fee1-e397-49d6-86c9-2d917dbad630
begin
	Pkg.add("Plots")
	using Plots
	using PlutoUI
end

# ╔═╡ 7b8731a0-1c5c-11ed-1da7-b3a72d631d5c
@bind a Slider(0:0.25:10,default=4)

# ╔═╡ 72ef780e-0eb0-4109-a9d2-15d5358523e0
md" $$a=$$ $(a)"

# ╔═╡ e1a42788-271a-4cc3-a9fc-9ee8a47993e8
@bind b Slider(0:0.25:10,default=3)

# ╔═╡ 55f46607-b9b3-42b9-9c7e-7c62ac94b937
md" $$b=$$ $(b)"

# ╔═╡ 0490fe81-c4d5-4765-bcbb-a2ec8ee9f247
c= √(a^2 + b^2)

# ╔═╡ d27017a0-1fcb-49ca-be8c-3e66774bc263
plot(randn(100))

# ╔═╡ 595570c1-25e8-45f0-9de0-8f0223e522cf
@bind ϕ Slider(0:0.20:10,default=1.4)

# ╔═╡ 5caa7e4f-10ee-4612-87b9-b2bde18e34e2
md" $$ϕ=$$ $(ϕ)"

# ╔═╡ cabc09c4-9af5-4cd3-a565-4f2a54aa44b9
r= 0.0:0.1:12.5

# ╔═╡ 176823e3-e5f6-4c21-8e30-180a1dd13431
y1(x)=sin(x)

# ╔═╡ abea4b50-3f98-434b-8031-ec6925b79948
y2(x) = sin(x+ϕ)

# ╔═╡ ae248b24-41ba-4eab-a684-3e0fcf688ffc
plot(r,[y1,y2,(x)-> y1(x) + y2(x)],labels=["y1" "y2" "sum"], ylims=(-2,2))

# ╔═╡ 33d225e8-d832-4103-8680-704b98348518


# ╔═╡ af31dd84-548f-4d98-b9ab-65f1447ea38b


# ╔═╡ 573e8a84-d882-4f1e-828d-bcb07a64a49b


# ╔═╡ c6e39a54-23b9-4260-9ebb-1e6fe49d0a61


# ╔═╡ ebb60304-81b1-41f2-b1d3-4a725cc1e64f


# ╔═╡ 2ea89180-8289-44f8-942d-235500183bd7


# ╔═╡ 3108d645-6c14-446b-be72-ad8483b92add


# ╔═╡ ac6cf705-2273-4c0d-b75f-9844c706a552


# ╔═╡ f0ca539b-3e3f-42ac-8f53-2d2688826f62


# ╔═╡ a040e5e6-5823-4594-b3ba-ba28070adbb8


# ╔═╡ Cell order:
# ╠═7b8731a0-1c5c-11ed-1da7-b3a72d631d5c
# ╟─72ef780e-0eb0-4109-a9d2-15d5358523e0
# ╠═e1a42788-271a-4cc3-a9fc-9ee8a47993e8
# ╟─55f46607-b9b3-42b9-9c7e-7c62ac94b937
# ╠═0490fe81-c4d5-4765-bcbb-a2ec8ee9f247
# ╠═d27017a0-1fcb-49ca-be8c-3e66774bc263
# ╠═595570c1-25e8-45f0-9de0-8f0223e522cf
# ╟─5caa7e4f-10ee-4612-87b9-b2bde18e34e2
# ╠═cabc09c4-9af5-4cd3-a565-4f2a54aa44b9
# ╠═176823e3-e5f6-4c21-8e30-180a1dd13431
# ╠═abea4b50-3f98-434b-8031-ec6925b79948
# ╠═ae248b24-41ba-4eab-a684-3e0fcf688ffc
# ╠═33d225e8-d832-4103-8680-704b98348518
# ╠═af31dd84-548f-4d98-b9ab-65f1447ea38b
# ╠═573e8a84-d882-4f1e-828d-bcb07a64a49b
# ╠═c6e39a54-23b9-4260-9ebb-1e6fe49d0a61
# ╠═ebb60304-81b1-41f2-b1d3-4a725cc1e64f
# ╠═2ea89180-8289-44f8-942d-235500183bd7
# ╠═3108d645-6c14-446b-be72-ad8483b92add
# ╠═ac6cf705-2273-4c0d-b75f-9844c706a552
# ╠═f0ca539b-3e3f-42ac-8f53-2d2688826f62
# ╠═a040e5e6-5823-4594-b3ba-ba28070adbb8
# ╠═bfe1210c-6ac8-497d-8ef8-545991488ddb
# ╠═6186fee1-e397-49d6-86c9-2d917dbad630
