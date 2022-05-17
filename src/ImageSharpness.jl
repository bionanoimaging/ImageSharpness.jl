module ImageSharpness

export image_sharpness

using Tullio, NDTools, TiffImages, Colors

function TV(img)
    return @tullio s = sqrt(abs2(img[i, j] - img[i + 1, j]) +
                        abs2(img[i, j] - img[i, j + 1]))
end


function image_sharpness(arr::AbstractArray{T, 2}, mode=:TV) where T
    if mode == :TV
        return TV(arr)
    else
        throw(ArgumentError("Invalid mode $mode"))
    end
end

function get_image_names(path, ending="tif")
    files = readdir(path)   
    files = filter(x -> endswith(lowercase(x), ending), files)
    return files
end



function assess_sharpness(path, ending="tif")
    imgs = get_image_names(path, ending)
    
    for img_f in imgs
        img = TiffImages.load(joinpath(path, img_f))
        @show img_f,  image_sharpness(Float32.(Gray.(img.data))) 
    end


end



end # module
