#!/usr/bin/env sh

# Initialize variables and source global control
scrDir=$(dirname "$(realpath "$0")")
source "$scrDir/globalcontrol.sh"

# Set up directories
waybar_dir="${confDir}/waybar"
modules_dir="$waybar_dir/modules"
conf_ctl="$waybar_dir/config.ctl"
in_file="$waybar_dir/modules/style.css"
src_file="${confDir}/hypr/themes/theme.conf"

# Use the named temporary directory
temp_dir="/tmp/waybar_temp"
mkdir -p "$temp_dir"

# Set output file in temp directory
out_file="$temp_dir/style.css"

# Check if temporary config.ctl exists, if not, initialize it
if [ ! -f "$temp_dir/config.ctl" ]; then
    echo "Initializing temporary config.ctl"
    cat "$conf_ctl" > "$temp_dir/config.ctl"
fi

conf_ctl="$temp_dir/config.ctl"

# Calculate height from control file or monitor resolution
b_height=$(grep '^1|' "$conf_ctl" | cut -d '|' -f 2)

if [ -z "$b_height" ] || [ "$b_height" == "0" ]; then
    y_monres=$(cat /sys/class/drm/*/modes | head -1 | cut -d 'x' -f 2)
    b_height=$(( y_monres*3/100 ))
fi

# Calculate values based on height
export b_radius=$(( b_height*70/100 ))   # block rad 70% of height (type1)
export c_radius=$(( b_height*25/100 ))   # block rad 25% of height {type2}
export t_radius=$(( b_height*25/100 ))   # tooltip rad 25% of height
export e_margin=$(( b_height*30/100 ))   # block margin 30% of height
export e_paddin=$(( b_height*10/100 ))   # block padding 10% of height
export g_margin=$(( b_height*14/100 ))   # module margin 14% of height
export g_paddin=$(( b_height*15/100 ))   # module padding 15% of height
export w_radius=$(( b_height*30/100 ))   # workspace rad 30% of height
export w_margin=$(( b_height*10/100 ))   # workspace margin 10% of height
export w_paddin=$(( b_height*10/100 ))   # workspace padding 10% of height
export w_padact=$(( b_height*40/100 ))   # workspace active padding 40% of height
export s_fontpx=$(( b_height*34/100 ))   # font size 34% of height

[ "$b_height" -lt 30 ] && export e_paddin=0
[ "$s_fontpx" -lt 10 ] && export s_fontpx=10

# Adjust values for vertical/horizontal orientation
export w_position=$(grep '^1|' "$conf_ctl" | cut -d '|' -f 3)
case ${w_position} in
    top|bottom)
        export x1g_margin=${g_margin}
        export x2g_margin=0
        export x3g_margin=${g_margin}
        export x4g_margin=0
        export x1rb_radius=0
        export x2rb_radius=${b_radius}
        export x3rb_radius=${b_radius}
        export x4rb_radius=0
        export x1lb_radius=${b_radius}
        export x2lb_radius=0
        export x3lb_radius=0
        export x4lb_radius=${b_radius}
        export x1rc_radius=0
        export x2rc_radius=${c_radius}
        export x3rc_radius=${c_radius}
        export x4rc_radius=0
        export x1lc_radius=${c_radius}
        export x2lc_radius=0
        export x3lc_radius=0
        export x4lc_radius=${c_radius}
        export x1="top"
        export x2="bottom"
        export x3="left" 
        export x4="right" ;;
    left|right)
        export x1g_margin=0
        export x2g_margin=${g_margin}
        export x3g_margin=0
        export x4g_margin=${g_margin}
        export x1rb_radius=0
        export x2rb_radius=0
        export x3rb_radius=${b_radius}
        export x4rb_radius=${b_radius}
        export x1lb_radius=${b_radius}
        export x2lb_radius=${b_radius}
        export x3lb_radius=0
        export x4lb_radius=0
        export x1rc_radius=0
        export x2rc_radius=${c_radius}
        export x3rc_radius=${c_radius}
        export x4rc_radius=0
        export x1lc_radius=${c_radius}
        export x2lc_radius=0
        export x3lc_radius=0
        export x4lc_radius=${c_radius}
        export x1="left"
        export x2="right"
        export x3="top" 
        export x4="bottom" ;;
esac

# List modules and generate theme style
export modules_ls=$(grep -m 1 '".*.": {'  --exclude="$modules_dir/footer.jsonc" "$modules_dir"/*.jsonc | cut -d '"' -f 2 | awk -F '/' '{ if($1=="custom") print "#custom-"$NF"," ; else print "#"$NF","}')
envsubst < "$in_file" > "$out_file"

# Override rounded corners if necessary
hypr_border=$(awk -F '=' '{if($1~" rounding ") print $2}' "$src_file" | sed 's/ //g')
[ "$hypr_border" == "0" ] && sed -i "/border-radius: /c\    border-radius: 0px;" "$out_file"

# Copy generated style to the actual waybar directory (if not on NixOS)
[ -z "$NIX_PATH" ] && cp "$out_file" "$waybar_dir/style.css"

