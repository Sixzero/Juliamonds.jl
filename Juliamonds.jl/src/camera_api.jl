cam = isdefined(Main, :cam) ? cam : nothing
set_cam(newcam) = (global cam; cam=newcam)

module CameraApi

import VideoIO
import GLMakie
using OCReract
import Images
using Boilerplate

img = nothing
read_pro(cam, img::Nothing) = read(cam)
read_pro(cam, img) = read!(cam, img)

show_cam() = begin
  global img
  img = read_pro(Main.cam, img)
  scene = GLMakie.Scene(resolution = size(img'))
  makieimg = GLMakie.image!(scene, img, show_axis = false, scale_plot = false)
  GLMakie.rotate!(scene, -0.5pi)
  display(scene)

  count = 0
  while isopen(scene)
    read!(Main.cam, img)
    makieimg.image = img
    sleep(1/30)
    sleep(1/10)
    @show count += 1
  end
end

get_text(cropshake=false) = begin
  global img
  sleep(1/10)
  img = read_pro(Main.cam, img)
  left,top = rand([1,2,3]), rand([1,2,3]) # sometimes some texts are not recognized, so we augment the picture.
  img_cropped = cropshake ? img[left:end, top:end] : img
  text = run_tesseract(img_cropped)
  text
end

# The fix for the issue:
# https://github.com/JuliaIO/VideoIO.jl/issues/341
Base.cconvert(::Type{Ptr{Ptr{VideoIO.AVDictionary}}}, d::VideoIO.AVDict) = d.ref_ptr_dict

if Main.cam === nothing
  obs_cams = filter(n -> occursin("OBS ", n) || occursin("/dev/video0", n), VideoIO.CAMERA_DEVICES)
  @show obs_cams
  Main.set_cam(VideoIO.opencamera(obs_cams[1]))
end

end
#%%
import VideoIO
VideoIO.CAMERA_DEVICES