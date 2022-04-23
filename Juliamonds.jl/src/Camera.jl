module Camera
include("camera_api_pywrapper.jl")

reload() = CameraApi.reload()
get_text(;kw...) = CameraApi.get_text(;kw...)
show_cam(;kw...) = CameraApi.show_cam(;kw...)
read_img(;kw...) = CameraApi.read_img(;kw...)
get_textnboxes(;kw...) = CameraApi.get_textnboxes(;kw...)
wait_till_text(req::AbstractString; blacklist=[], kw...) = wait_till_text(req=[req], blacklist=blacklist; kw...)
wait_till_text(;req::Vector, blacklist=[], verbose=false, kw...) = begin
  @show (req, blacklist)
  while true
    text = get_text(threshold=150; kw...)
    verbose && @show text
    ok_texts = map(t -> occursin(t, text), req)
    no_texts = map(t -> !occursin(t, text), blacklist)
    all(ok_texts) && all(no_texts) && return true
    verbose && @show (ok_texts, no_texts)
    # @show text

  end
end

__init__() = begin
  # reload()
  # @show get_text()
  # get_textnboxes()
end


end