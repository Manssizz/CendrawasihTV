#!/system/bin/sh
settings put secure install_non_market_apps 1
PKGS=/system/preinstall/
DATA=/system/bin/data.sh

echo "Welcome to CendrawasihTV"
echo "Preparation for installing..."
echo "DON'T CLOSE OR POWEROFF YOUR DEVICE!!!"

#find /system/app_install/ -name "*\.apk" -exec sh -c '$1 "Installing $(basename $0 .apk)"; pm install $0' {} "$TOAST" \;
#find $PKGS -name "*\.apk" -exec sh -c '$1 "Installing $(basename $0 .apk)"; pm install $0' {} \;
find $PKGS -name "*\.apk" -exec sh /system/bin/pm install {} \;

sh $DATA
sleep 1
done

# NO NEED to delete these APKs since we keep a mark under data partition.
# And the mark will be wiped out after doing factory reset, so you can install
# these APKs again if files are still there.
# rm -rf $PKGS

