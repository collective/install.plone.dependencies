!#/bin/env bash

. whiptail_messages.sh

WHIPTAIL --title="Yes or No" --yesno "Make a decision, yes or no."

WHIPTAIL --title="Alert box" --msgbox "You should know..."

WHIPTAIL --title="Input Box" --inputbox "Tell me something new."
echo $WHIPTAIL_RESULT