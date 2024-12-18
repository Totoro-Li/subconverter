#!/bin/bash

# Bearer Token for Authorization
AUTH_TOKEN="6VPk86j2sfg5356g8Om0q26civNbhwm"

USER_AGENT="clash-verge/v1.7.7"

# Declare an associative array for name and remote_url pairs
declare -A SUBSCRIPTIONS=(
    ["Base"]="https://911tg3rs.com/api/v1/client/subscribe?token=73204e05be6761f3cee1c95bf2bb5b7c"
    ["WD"]="https://wd-red.com/subscribe/njvpka-psmcucs3"
    ["ACA"]="https://frieren.acaisbest.online/api/v1/client/subscribe?token=08b698049827c28ca624c94ef35ed094"
    # ["Arjow80"]="https://subapi.zhuo.li/sub?target=clash&url=https%3A%2F%2Fsub-post-get.zhuo.li%2FHY2.yaml&insert=false&config=config%2FACL4SSR_Online_Overseas.ini&emoji=true&list=false&tfo=false&scv=true&fdn=false&expand=true&sort=false&udp=true&new_name=true"
    # ["Austria_Taiwan"]="https://subapi.zhuo.li/sub?target=clash&url=https%3A%2F%2Fsub-post-get.zhuo.li%2FBase.yaml&insert=false&config=config%2FAUX_Austria_Taiwan.ini&emoji=true&list=false&tfo=false&scv=true&fdn=false&expand=true&sort=false&udp=true&new_name=true"
    ["ZB9V7waPO0yC2Xon2G"]="https://subapi.zhuo.li/sub?target=clash&url=https%3A%2F%2Fsub-post-get.zhuo.li%2FBase.yaml%7Chttps%3A%2F%2Fsub-post-get.zhuo.li%2FWD.yaml%7Chttps%3A%2F%2Fsub-post-get.zhuo.li%2FACA.yaml&insert=false&config=config%2FACL4SSR_Online_Full_NoAuto.ini&emoji=true&list=false&tfo=false&scv=true&fdn=false&expand=true&sort=false&udp=true&new_name=true"
    ["xlVNVUL"]="https://subapi.zhuo.li/sub?target=clash&url=https%3A%2F%2Fsub-post-get.zhuo.li%2FWD.yaml&insert=false&config=config%2FACL4SSR_Online_Mini.ini&emoji=true&list=false&tfo=false&scv=true&fdn=false&expand=true&sort=false&udp=true&new_name=true"
)

# Indexed array of keys in desired order
ORDERED_KEYS=("WD" "Base" "ACA" "xlVNVUL" "ZB9V7waPO0yC2Xon2G")

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
