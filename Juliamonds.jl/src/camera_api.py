
"""
Simply display the contents of the webcam with optional mirroring using OpenCV
via the new Pythonic cv2 interface.  Press <esc> to quit.
"""

import re
import cv2
from time import sleep, time
import pytesseract
from pytesseract import Output
import numpy as np


cam = cv2.VideoCapture(0)
print('cam:', cam)
# cam = cv2.VideoCapture(0)

def show_cam():
    while True:
        ret_val, img = get_non_none_cam()
        # img = img[:800]
        grayImage = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        cv2.imshow('graycsale image3',grayImage)
        (thresh, img) = cv2.threshold(grayImage, 140, 255, cv2.THRESH_BINARY)
        cv2.imshow('my webcam', img)
        if cv2.waitKey(1) == 27:
            break  # esc to quit
    cv2.destroyAllWindows()

def read_img():
    ret_val, img = cam.read()
    return ret_val, img


def get_non_none_cam():
    img = None
    while img is None:
        ret_val, img = cam.read()
        sleep(0.3)
    return ret_val, img    

def grab_text(blacknwhite=True, inverted=False, show=False, threshold=150, verbose=False, lang='eng'):
    ret_val, img = get_non_none_cam()
    if blacknwhite:
        grayImage = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        (thresh, img) = cv2.threshold(grayImage, threshold, 255, cv2.THRESH_BINARY)
    if inverted:
        img = cv2.bitwise_not(img)
        pass
    # rescale = 1.0
    # img = cv2.resize(img, (0,0), fx=rescale, fy=rescale)
    if show:
        cv2.imshow('my webcam', cv2.resize(img, (0,0), fx=0.5, fy=0.5))
    # print(img.shape)
    text = pytesseract.image_to_string(img, lang=lang)
    # print('text:', text)
    verbose and print("text", text)
    # cv2.imshow('my webcam', img)
    if show:
        cv2.waitKey(3000)
    return text


def grab_textnboxes(blacknwhite=True, inverted=False, show=False, verbose=False, threshold=150, lang='eng'):
    t = time()
    ret_val, img = get_non_none_cam()
    verbose and print(time()-t)
    if blacknwhite:
        grayImage = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        (thresh, img) = cv2.threshold(grayImage, threshold, 255, cv2.THRESH_BINARY)
    if inverted:
        img = cv2.bitwise_not(img)
        pass
    if show:
        cv2.imshow('my webcam', cv2.resize(img, (0,0), fx=0.5, fy=0.5))
    t = time()
    d = pytesseract.image_to_data(img, lang=lang, output_type=Output.DICT)
    verbose and print(time() - t)
    data = []
    n_boxes = len(d['text'])
    verbose and print(d['text'])
    # print(d['conf'][-5:])
    for i in range(n_boxes):
        if float(d['conf'][i]) > 0:
            (x, y, w, h) = (d['left'][i], d['top'][i], d['width'][i], d['height'][i])
            verbose and print(d['text'][i], x, y, w, h)
            data.append([d['text'][i], d['left'][i], d['top'][i], d['width'][i], d['height'][i]])
    if show:
        cv2.waitKey(3000)
    return data

if __name__ == '__main__':
    # show_cam()
    show = True
    # grab_textnboxes(inverted=True,blacknwhite=False, show=show)
    # grab_textnboxes(inverted=True, show=show, threshold=160)
    # grab_textnboxes(blacknwhite=False, show=show)
    # data = grab_textnboxes(blacknwhite=False, show=False, inverted=True)
    # print('data:', [d[0] for d in data])
    # grab_textnboxes()



# import cv2

# camera = cv2.VideoCapture(0)

# def test():
# 	while True:
# 		_, image = camera.read()
# 		cv2.imshow("video", image)
# 		if cv2.waitKey(1) & 0xFF == ord('q'):
# 			break
# 	cv2.destroyAllWindows()

# test()