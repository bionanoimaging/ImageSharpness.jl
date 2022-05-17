### A Pluto.jl notebook ###
# v0.19.4

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

# ╔═╡ e273b6a0-d5c5-11ec-0160-390e14c5506f
using Pkg

# ╔═╡ b4268e53-2383-404c-8bb5-8d449b331025
Pkg.activate(".")

# ╔═╡ f0d75658-5dfd-407d-8730-016c4391a87e
using Revise

# ╔═╡ c1557852-f096-4109-a367-3748d8acdd48
using PlutoUI, ImageSharpness, TestImages, IndexFunArrays, Colors, FourierTools, ImageShow

# ╔═╡ 16a3db2d-3dee-4f40-bee3-f6556520245b
img = Float32.(testimage("resolution_test"));

# ╔═╡ aa1209e4-9ce1-4cdf-a909-7e81799bbe52


# ╔═╡ cb0d96df-d1dc-4a84-a140-8a0b0a2de4b0
@bind sigma Slider(0.1:0.1:20, show_value=true)

# ╔═╡ a5910f24-fdf7-4478-95c1-2d6c7f805deb
begin
	kernel = collect(normal(eltype(img), size(img), sigma=sigma));
	kernel ./= sum(kernel)
end

# ╔═╡ 33ce1407-ff92-447f-8a14-daa1a1421631
img_b = conv_psf(img, kernel);

# ╔═╡ 0f6656dc-2b55-4d80-998a-d2b47f6c780f
sum(kernel)

# ╔═╡ 1df0d401-fddf-4184-92a1-652c52ea14ec
Gray.(kernel ./ maximum(kernel));

# ╔═╡ 42d6f552-e6d2-4d25-bde7-572427a7afa6
md"
Sharp image: $(image_sharpness(img))

Blurry image: $(image_sharpness(img_b))
"

# ╔═╡ 70d99409-fc2c-43b7-bd8f-42d303d0bf5e
md"
Sharp image: $(image_sharpness(img, :variance))

Blurry image: $(image_sharpness(img_b, :variance))
"

# ╔═╡ d2eb087f-96a6-462b-a3d0-6f9ccd6ceb94
[Gray.(img_b) Gray.(img)]

# ╔═╡ c787f9f9-7631-4682-8ba7-c57cc20f94be


# ╔═╡ 93a4ef45-4ca8-40b0-b9da-e56a1aca9789
ImageSharpness.assess_sharpness("/home/fxw/Documents/Uni/projects/ELETTRA/images/", mode=:variance)

# ╔═╡ 305a7710-3fa6-46a1-a6b3-5c6bb0e48739
Revise.retry()

# ╔═╡ Cell order:
# ╠═e273b6a0-d5c5-11ec-0160-390e14c5506f
# ╠═b4268e53-2383-404c-8bb5-8d449b331025
# ╠═f0d75658-5dfd-407d-8730-016c4391a87e
# ╠═c1557852-f096-4109-a367-3748d8acdd48
# ╠═16a3db2d-3dee-4f40-bee3-f6556520245b
# ╠═33ce1407-ff92-447f-8a14-daa1a1421631
# ╠═a5910f24-fdf7-4478-95c1-2d6c7f805deb
# ╠═0f6656dc-2b55-4d80-998a-d2b47f6c780f
# ╠═1df0d401-fddf-4184-92a1-652c52ea14ec
# ╠═aa1209e4-9ce1-4cdf-a909-7e81799bbe52
# ╟─cb0d96df-d1dc-4a84-a140-8a0b0a2de4b0
# ╠═42d6f552-e6d2-4d25-bde7-572427a7afa6
# ╠═70d99409-fc2c-43b7-bd8f-42d303d0bf5e
# ╠═d2eb087f-96a6-462b-a3d0-6f9ccd6ceb94
# ╠═c787f9f9-7631-4682-8ba7-c57cc20f94be
# ╠═93a4ef45-4ca8-40b0-b9da-e56a1aca9789
# ╠═305a7710-3fa6-46a1-a6b3-5c6bb0e48739
