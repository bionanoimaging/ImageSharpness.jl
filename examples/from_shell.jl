using ImageSharpness

 # How to use:
 #
 # julia> includet("from_shell.jl")
 # 
 # julia> main()



function main()
    ImageSharpness.assess_sharpness("/home/fxw/Documents/Uni/projects/ELETTRA/images/", mode=:TV, use_HTML=false)
end
