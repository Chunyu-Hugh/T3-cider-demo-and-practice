
#!/bin/bash

USER_HOME=$(eval echo ~${USER})
BASE_DIR="$USER_HOME/practice/practice3"
# Create base directory structure
mkdir -p "$BASE_DIR/detective_challenge"
cd "$BASE_DIR/detective_challenge"

# Create subdirectories to increase complexity
mkdir -p office/{documents,emails,calendar}
mkdir -p warehouse/{inventory,shipping,receiving}
mkdir -p archives/{2022,2023}/{Q1,Q2,Q3,Q4}
mkdir -p lab/{experiments,results,equipment}
mkdir -p server_room/{logs,backups,configs}
mkdir -p maintenance/tools

# Create initial clue file
cat > README.txt << 'EOF'
WELCOME TO THE DATA DETECTIVE CHALLENGE

Your mission is to locate a critical file containing security credentials.
The file has been hidden somewhere in this system.

Your first clue is in the server logs from yesterday.
Check the server_room/logs directory for a file with exactly 44 lines and include the clue we need.

Good luck, detective.
EOF

# Create decoy and clue files in server_room/logs
# Create several log files with varying line counts
for i in {1..10}; do
  # Generate random line count between 30 and 50, but ensure only one has exactly 42
  if [ $i -eq 5 ]; then
    LINE_COUNT=42
  else
    LINE_COUNT=$((RANDOM % 20 + 30))
  fi
  
  # Create log file with appropriate number of lines
  LOG_FILE="server_room/logs/system_log_$i.txt"
  echo "# System Log File $i" > $LOG_FILE
  echo "# Generated: $(date)" >> $LOG_FILE
  
  for j in $(seq 1 $LINE_COUNT); do
    if [ $i -eq 5 ] && [ $j -eq 37 ]; then
      echo "[INFO] Next clue: Look for the largest inventory file in the warehouse directory. The line containing 'SKU19385' has your next clue." >> $LOG_FILE
    else
      echo "[$(date +%T)] Log entry $j: System status normal" >> $LOG_FILE
    fi
  done
done

# Create warehouse inventory files of different sizes
for i in {1..5}; do
  # Make the third file the largest
  if [ $i -eq 3 ]; then
    LINE_COUNT=200
  else
    LINE_COUNT=$((RANDOM % 100 + 50))
  fi
  
  INVENTORY_FILE="warehouse/inventory/stock_list_$i.csv"
  echo "ItemID,Description,Quantity,Location" > $INVENTORY_FILE
  
  for j in $(seq 1 $LINE_COUNT); do
    SKU="SKU$((10000 + RANDOM % 10000))"
    QTY=$((RANDOM % 100))
    LOC="Aisle-$((RANDOM % 20 + 1))-Shelf-$((RANDOM % 10 + 1))"
    
    if [ $i -eq 3 ] && [ $SKU = "SKU19385" ]; then
      echo "$SKU,Special Item,42,$LOC,Note: Check archives/2023/Q2 for file access_codes.txt - line 7 contains next clue" >> $INVENTORY_FILE
    else
      echo "$SKU,Regular Item,$QTY,$LOC" >> $INVENTORY_FILE
    fi
  done
  
  # Ensure SKU19385 exists in the largest file
  if [ $i -eq 3 ]; then
    echo "SKU19385,Special Item,42,Aisle-15-Shelf-3,Note: Check archives/2023/Q2 for file access_codes.txt - line 10 contains next clue" >> $INVENTORY_FILE
  fi
done

# Create archives with the next clue
mkdir -p archives/2023/Q2/classified
touch archives/2023/Q2/project_notes.txt
touch archives/2023/Q2/meeting_minutes.txt

cat > archives/2023/Q2/access_codes.txt << 'EOF'
# Access Codes - Q2 2023
# CONFIDENTIAL

Code 1: 7851-ALPHA
Code 2: 2945-BETA
Code 3: 6723-GAMMA
Code 4: 3310-DELTA
Code 5: 9458-EPSILON
Code 6: 1298-ZETA
Code 7: 5142-ETA - Note: The lab results file with exactly 1024 bytes contains your next clue
Code 8: 8867-THETA
EOF

# Create lab results files of different sizes
for i in {1..8}; do
  RESULTS_FILE="lab/results/experiment_$i.dat"
  
  # Make one file exactly 1024 bytes
  if [ $i -eq 4 ]; then
    dd if=/dev/zero bs=1024 count=1 | tr '\0' 'X' > $RESULTS_FILE
    # Replace some content with the clue
    CLUE="IMPORTANT: Check the largest file in the office/emails directory for your next instruction."
    POSITION=$((RANDOM % 900))
    echo "${CLUE}" | dd of=$RESULTS_FILE bs=1 seek=$POSITION conv=notrunc
  else
    # Create files of random sizes
    SIZE=$((RANDOM % 2000 + 500))
    dd if=/dev/zero bs=$SIZE count=1 | tr '\0' 'X' > $RESULTS_FILE
  fi
done

# Create email files with dates
for i in {1..10}; do
  EMAIL_FILE="office/emails/email_$i.eml"
  
  # Format date string for each email, making the last one the most recent
  if [ $i -eq 10 ]; then
    DATE_STR=$(date -d "now" "+%Y-%m-%d %H:%M:%S")
  else
    DAYS_AGO=$((10 - i))
    DATE_STR=$(date -d "$DAYS_AGO days ago" "+%Y-%m-%d %H:%M:%S")
  fi
  
  cat > $EMAIL_FILE << EOF
From: sender$i@example.com
To: recipient@example.com
Date: $DATE_STR
Subject: Important Message $i

Email body content goes here.
This is a sample email for the detective challenge.

EOF

  # Add the clue to the most recent email
  if [ $i -eq 10 ]; then
    cat >> $EMAIL_FILE << 'EOF'
ALERT: Security credentials have been moved.
The file is hidden as a dot file in the maintenance/tools directory.
The filename begins with .security_
To find the exact filename, look for a file that has exactly 3 lines.

EOF
  fi
done

# Create hidden files in maintenance/tools
touch maintenance/tools/.security_backup.old
touch maintenance/tools/.security_temp.bak
touch maintenance/tools/.security_credentials.txt

# Only one has exactly 3 lines
echo "Username: admin_user" > maintenance/tools/.security_credentials.txt
echo "Password: S3cur3P@ssw0rd!" >> maintenance/tools/.security_credentials.txt
echo "API Key: 9a8b7c6d5e4f3g2h1i" >> maintenance/tools/.security_credentials.txt

echo "This is a decoy file with more than 3 lines" > maintenance/tools/.security_backup.old
echo "Line 2" >> maintenance/tools/.security_backup.old
echo "Line 3" >> maintenance/tools/.security_backup.old
echo "Line 4" >> maintenance/tools/.security_backup.old
echo "Line 5" >> maintenance/tools/.security_backup.old

echo "Another decoy" > maintenance/tools/.security_temp.bak
echo "With a different line count" >> maintenance/tools/.security_temp.bak

echo "Data Detective Challenge setup complete. Start with README.txt in the main directory."
