THEOS_DEVICE_IP=192.168.2.14

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = weibointl

weibointl_FILES = Tweak.x
weibointl_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
