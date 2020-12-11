get_model() {
    case $os in
        Linux)
            if [[ -d /system/app/ && -d /system/priv-app ]]; then
                model="$(getprop ro.product.brand) $(getprop ro.product.model)"

            elif [[ -f /sys/devices/virtual/dmi/id/product_name ||
                    -f /sys/devices/virtual/dmi/id/product_version ]]; then
                model=$(< /sys/devices/virtual/dmi/id/product_name)
                model+=" $(< /sys/devices/virtual/dmi/id/product_version)"

            elif [[ -f /sys/firmware/devicetree/base/model ]]; then
                model=$(< /sys/firmware/devicetree/base/model)

            elif [[ -f /tmp/sysinfo/model ]]; then
                model=$(< /tmp/sysinfo/model)
            fi
        ;;

        "Mac OS X"|"macOS")
            if [[ $(kextstat | grep -F -e "FakeSMC" -e "VirtualSMC") != "" ]]; then
                model="Hackintosh (SMBIOS: $(sysctl -n hw.model))"
            else
                model=$(sysctl -n hw.model)
            fi
        ;;

        "iPhone OS")
            case $kernel_machine in
                iPad1,1):            "iPad" ;;
                iPad2,[1-4]):        "iPad 2" ;;
                iPad3,[1-3]):        "iPad 3" ;;
                iPad3,[4-6]):        "iPad 4" ;;
                iPad6,1[12]):        "iPad 5" ;;
                iPad7,[5-6]):        "iPad 6" ;;
                iPad7,1[12]):        "iPad 7" ;;
                iPad4,[1-3]):        "iPad Air" ;;
                iPad5,[3-4]):        "iPad Air 2" ;;
                iPad11,[3-4]):       "iPad Air 3" ;;
                iPad6,[7-8]):        "iPad Pro (12.9 Inch)" ;;
                iPad6,[3-4]):        "iPad Pro (9.7 Inch)" ;;
                iPad7,[1-2]):        "iPad Pro 2 (12.9 Inch)" ;;
                iPad7,[3-4]):        "iPad Pro (10.5 Inch)" ;;
                iPad8,[1-4]):        "iPad Pro (11 Inch)" ;;
                iPad8,[5-8]):        "iPad Pro 3 (12.9 Inch)" ;;
                iPad8,9 | iPad8,10): "iPad Pro 4 (11 Inch)" ;;
                iPad8,1[1-2]):       "iPad Pro 4 (12.9 Inch)" ;;
                iPad2,[5-7]):        "iPad mini" ;;
                iPad4,[4-6]):        "iPad mini 2" ;;
                iPad4,[7-9]):        "iPad mini 3" ;;
                iPad5,[1-2]):        "iPad mini 4" ;;
                iPad11,[1-2]):       "iPad mini 5" ;;

                iPhone1,1):     "iPhone" ;;
                iPhone1,2):     "iPhone 3G" ;;
                iPhone2,1):     "iPhone 3GS" ;;
                iPhone3,[1-3]): "iPhone 4" ;;
                iPhone4,1):     "iPhone 4S" ;;
                iPhone5,[1-2]): "iPhone 5" ;;
                iPhone5,[3-4]): "iPhone 5c" ;;
                iPhone6,[1-2]): "iPhone 5s" ;;
                iPhone7,2):     "iPhone 6" ;;
                iPhone7,1):     "iPhone 6 Plus" ;;
                iPhone8,1):     "iPhone 6s" ;;
                iPhone8,2):     "iPhone 6s Plus" ;;
                iPhone8,4):     "iPhone SE" ;;
                iPhone9,[13]):  "iPhone 7" ;;
                iPhone9,[24]):  "iPhone 7 Plus" ;;
                iPhone10,[14]): "iPhone 8" ;;
                iPhone10,[25]): "iPhone 8 Plus" ;;
                iPhone10,[36]): "iPhone X" ;;
                iPhone11,2):    "iPhone XS" ;;
                iPhone11,[46]): "iPhone XS Max" ;;
                iPhone11,8):    "iPhone XR" ;;
                iPhone12,1):    "iPhone 11" ;;
                iPhone12,3):    "iPhone 11 Pro" ;;
                iPhone12,5):    "iPhone 11 Pro Max" ;;
                iPhone12,8):    "iPhone SE 2020" ;;

                iPod1,1): "iPod touch" ;;
                ipod2,1): "iPod touch 2G" ;;
                ipod3,1): "iPod touch 3G" ;;
                ipod4,1): "iPod touch 4G" ;;
                ipod5,1): "iPod touch 5G" ;;
                ipod7,1): "iPod touch 6G" ;;
            esac

            model=$_
        ;;