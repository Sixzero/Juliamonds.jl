module CameraApi
using PyCall

loginuser = ENV["USER"]
pypkgdir = dirname(@__FILE__)
@show pypkgdir
# pushfirst!(PyVector(pyimport("sys")["path"]), "")
py"""
import sys
# sys.path.insert(0, ".")
print("-$pypkgdir", $pypkgdir)
sys.path.insert(0, $pypkgdir)
"""
# push!(pyimport("sys")."path", pypkgdir)
camera_api = pyimport("camera_api")

reload() = begin
  @warn "Currently reload causes segmentation fault, so we are not reloading, please test it!"
  # global camera_api
  # camera_api = pyimport("importlib").reload(camera_api)
end
show_cam(;kw...) = camera_api.show_cam(;kw...)
get_text(;kw...) = camera_api.grab_text(;kw...)
read_img(;kw...) = camera_api.read_img(;kw...)
get_textnboxes(;kw...) = camera_api.grab_textnboxes(;kw...)

end

#%%
#%%
# import GLMakie, VideoIO

# cam = VideoIO.opencamera()

# img = read(cam)
# scene = GLMakie.Scene(resolution = size(img'))
# makieimg = GLMakie.image!(scene, img, show_axis = false, scale_plot = false)
# GLMakie.rotate!(scene, -0.5pi)
# display(scene)

# while isopen(scene)
#     read!(cam, img)
#     makieimg.image = img
#     sleep(1/VideoIO.framerate(cam))
# end

# close(cam)
# @edit VideoIO.VideoReader(VideoIO.AVInput(source))
# imgs = []
# text = "43% OB BO: ul D4\n\n06 30 555 5594 - now #\nie PayPal: az On biztonsagi ko... eo os\n\nMARK AS READ REPLY (y\n\nEnter your code\n\nWe sent a security code to 06 3+ «ss «093.\n\n \n\n \n\nSecurity code Resend\nTry another way\n\nNeed any help? We can help\n\nIf you accept cookies, we'll use them to improve\nand customize your experience and enable our\npartners to show you personalized PayPal ads\n\nwhen you visit other sites. Manage cookies and\n\nlearn more\n\nUs Privacy Legal Worldwide\n\n \n\n \n\n \n"
# text = "14522 OB BO: Bal B®\n\n06 30 555 5594 - Messages - now =A\n- PayPal: az On biztonsagi kodja: 952395. Ez\n\n10 perc mulva lejar. Ez a kodot ne ossza\n\nmeg senkivel.\n\nPayPal: az On biztonsagi kodja: 298480. Ez\n\n10 perc mulva lejar. Ez a kodot ne ossza\n\nmeg senkivel.\n\nPayPal: az On biztonsagi kodja: 826145. Ez\n\n10 perc mulva lejar. Ez a kodot ne ossza\n\n \n\nmeg senkivel.\nMARK AS READ REPLY (ee!\n\n \n\n  \n\nTry another way\n\nNeed any help? We can help\n\nIf you accept cookies, we'll use them to improve\nand customize your experience and enable our\npartners to show you personalized PayPal ads\nwhen you visit other sites. Manage cookies and\n\nlearn more\n\nContact Us Privacy Legal Worldwide\n\n \n\n \n\n \n"
text = "53208 BO -- Baal E\n\n06 30 555 5594 - Messages - now = A\n\n- = PayPal: az On biztonsagi kodja: 1652432 =\n10 perc mulva lejar. Ez a kodot ne ossza\nmeg senkivel.\n\n \n\nMARK AS READ REPLY\n\nEnter your code\n\nWe sent a security code to 06 3+ «ss «093.\n\n \n\n \n\nSecurity code Resend |\n\nTry another way\n\n \n\n \n\nNeed any help? We can help\n\nIf you accept cookies, we'll use them to improve\nand customize your experience and enable our\npartners to show you personalized PayPal ads\nwhen you visit other sites. Manage cookies and\n\nlearn more\n\nContact Us Privacy Legal Worldwide\n\n \n\n \n"
# @test is_paypal_sms_small(text)
# @test is_paypal_sms_small("or: attempt to access 0-element Vector{Union{Nothing, SubS")
# @test get_paypal_sms_number(text)
# wait_for_paypel_sms(source)
