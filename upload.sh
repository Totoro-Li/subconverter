#!/bin/bash

# Bearer Token for Authorization
AUTH_TOKEN="6VPk86j2sfg5356g8Om0q26civNbhwm"

USER_AGENT="clash-verge/v1.7.7"

# Declare an associative array for name and remote_url pairs
declare -A SUBSCRIPTIONS=(
    # ["Base"]="https://suc2.sntp.io/api/v1/client/subscribe?token=6c04b13144bb1c0ce2e268a16e08ea8f"
    ["MESL"]="https://911tg3rs.com/api/v1/client/subscribe?token=3a9dfff8e0d66d67186887bf41ea69b8"
    # ["YTOO"]="https://api.stentvessel.top/sub?target=clash&new_name=true&emoji=true&clash.doh=true&filename=YToo_SS&udp=true&url=https%3A%2F%2Fapi.ytoo.xyz%2Fosubscribe.php%3Fsid%3D47047%26token%3DNNRiAXSyaPbe%26sip002%3D1"
    ["ImmTelecom"]="https://gwodkg.sbs/?L1N1YnNjcmlwdGlvbi9TaGFkb3dSb2NrZXRJbXBvcnRTZXJ2aWNlP3Q9c2lwMDAyJnNpZD0xMzI5NyZ0b2tlbj1PcXNqUGRncW42WSZtbT0yMzM4MyYzYTEzNzgzNGNlODA0ODZmOWQ0YjljNg=="
    # ["ACA"]="https://api.acaisbest.online/api/v1/client/subscribe?token=9fbc297af6436d89f41adacb19dda114"
    ["Ue9HlB3"]="https://subapi.zhuo.li/sub?target=clash&url=https%3A%2F%2Fsub-post-get.zhuo.li%2FMESL.yaml%7Chttps%3A%2F%2Fsub-post-get.zhuo.li%2FYTOO.yaml%7Chttps%3A%2F%2Fsub-post-get.zhuo.li%2FImmTelecom.yaml%7Chttps%3A%2F%2Fsub-post-get.zhuo.li%2FHY2.yaml%7Chttps%3A%2F%2Fsub-post-get.zhuo.li%2FWARP.yaml&insert=false&config=config%2FACL4SSR_Online_Full_NoAuto.ini&emoji=true&list=false&tfo=false&scv=true&fdn=false&expand=true&sort=false&udp=true&new_name=true"
    ["xlVNVUL"]="https://subapi.zhuo.li/sub?target=clash&url=https%3A%2F%2Fsub-post-get.zhuo.li%2FHY2.yaml&insert=false&config=config%2FACL4SSR_Online_Mini.ini&emoji=true&list=false&tfo=false&scv=true&fdn=false&expand=true&sort=false&udp=true&new_name=true"
    ["Arjow80"]="https://subapi.zhuo.li/sub?target=clash&url=https%3A%2F%2Fsub-post-get.zhuo.li%2FHY2.yaml&insert=false&config=config%2FACL4SSR_Online_Overseas.ini&emoji=true&list=false&tfo=false&scv=true&fdn=false&expand=true&sort=false&udp=true&new_name=true"
)

# Indexed array of keys in desired order
ORDERED_KEYS=("MESL" "ImmTelecom" "Arjow80" "xlVNVUL" "Ue9HlB3")

declare -A LOCAL_FILES=(
    ["WARP"]="./local-subscriptions/WARP.yaml" 
)

# Process local files
for name in "${!LOCAL_FILES[@]}"; do
    local_file=${LOCAL_FILES[$name]}
    worker_url="https://sub-post-get.zhuo.li/${name}.yaml"

    # Upload the local file
    curl -X POST "$worker_url" \
         -H "Authorization: Bearer $AUTH_TOKEN" \
         -H "Content-Type: application/x-yaml" \
         --data-binary "@${local_file}"
done

for name in "${ORDERED_KEYS[@]}"; do
    # Circumvent strict access policy
    remote_url=${SUBSCRIPTIONS[$name]//https:\/\/subapi.zhuo.li/http:\/\/localhost:25500}
    worker_url="https://sub-post-get.zhuo.li/${name}.yaml"

    # Retrieve the content and directly upload it
    wget --no-proxy -qO- --user-agent="$USER_AGENT" "$remote_url" | \
    curl -X POST "$worker_url" \
         -H "Authorization: Bearer $AUTH_TOKEN" \
         -H "Content-Type: application/x-yaml" \
         --data-binary @-
done
