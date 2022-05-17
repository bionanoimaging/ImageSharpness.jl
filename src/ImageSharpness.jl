module ImageSharpness

export image_sharpness

using Tullio, NDTools, TiffImages, Colors, Statistics, PrettyTables


function TV(img)
    return @tullio s = sqrt(abs2(img[i, j] - img[i + 1, j]) +
                        abs2(img[i, j] - img[i, j + 1]))
end


"""
    image_sharpness(arr, mode)

Assess image sharpness of an array.
Modes are:

* `:TV`: Total variation
* `:variance`: variance of all pixels
"""
function image_sharpness(arr::AbstractArray{T, 2}, mode=:TV) where T
    if mode == :TV
        return TV(arr)
    elseif mode == :variance
        return var(arr)
    else
        throw(ArgumentError("Invalid mode $mode"))
    end
end

function get_image_names(path, ending="tif")
    files = readdir(path)   
    files = filter(x -> endswith(lowercase(x), ending), files)
    return files
end


"""
    assess_sharpness(path, ending="tif"; mode=:TV)


Assess the image sharpness of images located at `path`.
Only analyze images with a certain `ending` (e.g. `img1.tif`).

Mode for image sharpness can be set with `mode=:TV`.
See [`ImageSharpness.image_sharpness`](@ref) for all options.
"""
function assess_sharpness(path, ending="tif"; mode=:TV)
    imgs = get_image_names(path, ending)
   
    data = Matrix{Any}(undef, length(imgs), 2) 
    for (i, img_f) in enumerate(imgs)
        try 
            img = TiffImages.load(joinpath(path, img_f))
        catch
            continue
        end
        img = Float32.(Gray.(img))
        data[i, 1] = img_f
        data[i, 2] = image_sharpness(img, mode)
    end
    
    data[:, 2] ./= maximum(data[:, 2])
    return pretty_table(HTML, data)

end


end # module
