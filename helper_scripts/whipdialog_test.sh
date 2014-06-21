!#/bin/env bash

. whiptail_messages.sh

WHIPTAIL --title="Yes or No" --yesno "Make a decision, yes or no."
DECISION=$?

WHIPTAIL --title="Alert box" --msgbox "You should know..."

WHIPTAIL --title="Input Box" --inputbox "Tell me something new."
INBOX=$WHIPTAIL_RESULT

WHIPTAIL --title="Password Box" --passwordbox "Tell me something private."
PRIVATE=$WHIPTAIL_RESULT

echo
echo $DECISION
echo $INBOX
echo $PRIVATE

