#!/bin/bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

clear
echo ""
echo -e "${CYAN}=================================${NC}"
echo -e "${CYAN}   VPN BOT — УСТАНОВКА TERMUX   ${NC}"
echo -e "${CYAN}=================================${NC}"
echo ""

# ── 1. Пакеты ────────────────────────────────────────────────────
echo -e "${YELLOW}[1/4] Устанавливаем пакеты...${NC}"
pkg update -y 2>/dev/null
pkg install -y git python 2>/dev/null
echo -e "${GREEN}✅ Готово${NC}"
echo ""

# ── 2. Клонирование ──────────────────────────────────────────────
echo -e "${YELLOW}[2/4] Загружаем бота с GitHub...${NC}"
rm -rf "$HOME/vpn_bot"
git clone https://github.com/wwindddy31-hash/VPNBOT "$HOME/vpn_bot"
cd "$HOME/vpn_bot"
echo -e "${GREEN}✅ Готово${NC}"
echo ""

# ── 3. Библиотеки ────────────────────────────────────────────────
echo -e "${YELLOW}[3/4] Устанавливаем библиотеки...${NC}"
pip uninstall -y python-telegram-bot httpx httpcore 2>/dev/null
pip install "python-telegram-bot==21.5" "httpx>=0.27.0" "anyio>=4.0.0" "certifi" "requests" "urllib3"
echo -e "${GREEN}✅ Готово${NC}"
echo ""

# ── 4. Настройка ─────────────────────────────────────────────────
echo -e "${YELLOW}[4/4] Настройка бота...${NC}"
echo ""
echo -e "${CYAN}Отвечайте на вопросы и нажимайте Enter${NC}"
echo ""

echo -e "${CYAN}🤖 Токен бота (от @BotFather):${NC}"
read BOT_TOKEN
echo -e "${CYAN}👤 Ваш Telegram ID (от @userinfobot):${NC}"
read ADMIN_ID
echo -e "${CYAN}🌐 URL Marzban (https://1.2.3.4:8000):${NC}"
read MARZBAN_URL
echo -e "${CYAN}🔑 Логин Marzban:${NC}"
read MARZBAN_USER
echo -e "${CYAN}🔒 Пароль Marzban:${NC}"
read MARZBAN_PASS
echo -e "${CYAN}💬 Username поддержки (@support):${NC}"
read SUPPORT_USERNAME
echo -e "${CYAN}📢 Канал отзывов (@reviews):${NC}"
read REVIEWS_CHANNEL
echo -e "${CYAN}💳 ЮМани кошелёк (Enter — пропустить):${NC}"
read YOOMONEY_WALLET
echo -e "${CYAN}🔐 ЮМани секрет (Enter — пропустить):${NC}"
read YOOMONEY_SECRET
echo -e "${CYAN}🪙 ЮМани токен (Enter — пропустить):${NC}"
read YOOMONEY_TOKEN

cd "$HOME/vpn_bot"
sed -i "s|YOUR_BOT_TOKEN|${BOT_TOKEN}|g"              bot.py
sed -i "s|123456789|${ADMIN_ID}|g"                    bot.py
sed -i "s|https://YOUR_MARZBAN_URL|${MARZBAN_URL}|g"  bot.py
sed -i "s|YOUR_MARZBAN_USERNAME|${MARZBAN_USER}|g"    bot.py
sed -i "s|YOUR_MARZBAN_PASSWORD|${MARZBAN_PASS}|g"    bot.py
sed -i "s|@your_support|${SUPPORT_USERNAME}|g"        bot.py
sed -i "s|@your_reviews_channel|${REVIEWS_CHANNEL}|g" bot.py
[ -n "$YOOMONEY_WALLET" ] && sed -i "s|YOUR_YOOMONEY_WALLET|${YOOMONEY_WALLET}|g" bot.py
[ -n "$YOOMONEY_SECRET" ] && sed -i "s|YOUR_YOOMONEY_SECRET|${YOOMONEY_SECRET}|g" bot.py
[ -n "$YOOMONEY_TOKEN"  ] && sed -i "s|YOUR_YOOMONEY_TOKEN|${YOOMONEY_TOKEN}|g"   bot.py

echo ""
echo -e "${GREEN}=================================${NC}"
echo -e "${GREEN}      ✅ УСТАНОВКА ГОТОВА!       ${NC}"
echo -e "${GREEN}=================================${NC}"
echo ""
echo -e "${YELLOW}Запустить бота сейчас? (y/n):${NC}"
read RUN
if [ "$RUN" = "y" ] || [ "$RUN" = "Y" ]; then
    echo -e "${GREEN}🚀 Запускаем...${NC}"
    cd "$HOME/vpn_bot" && python bot.py
fi
