-- This File is for using in a build pipeline
-- To replace all variables in this file with enviromentvariables use the node terratex.env.js (nodejs is required)
-- be sure that all variables are set in the build enviroment
config={}
config["owner"]="${OWNER}"
config["supportmail"]="${EMAIL}"
config["domains"]={"${DOMAIN}"}
config["maindomain"]="https://${DOMAIN}"
config["bugdomain"]="${BUG_URL}";
config["teamspeak"]="${DOMAIN}"
config["clantag"]="${CLAN_TAG}"
config["communityname"]="${COMMUNITY}"
config["mappername"]="${MAPPER}"
config["scriptername"]="${SCRIPTER}"
config["dailyrestarttype"]="${RESTART_TYPE}"
config["afk.punish"]="${AFK_PUNISH}"
config["afk.stop_play_time"]=${AFK_STOP_PLAY_TIME}
config["gold.price"]=${GOLD_PRICE}
config["feature.stardard_of_living"]=${FEATURE_SOL}
config["feature.limiter.pizza"]=${FEATURE_LIMIT_PIZZA}
config["feature.limiter.faggio"]=${FEATURE_LIMIT_FAGGIO}
config["feature.limiter.quad"]=${FEATURE_LIMIT_QUAD}
config["feature.limiter.muntruck"]=${FEATURE_LIMIT_MUNTRUCK}
config["api.user"]=${API_USER}
config["api.password"]=${API_PASSWORD}
