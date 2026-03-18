#!/usr/bin/awk -f
#
# find_longest_mars_mission.awk
# Finds the security code of the longest successful Mars mission in space mission logs.
#
# Usage: awk -f find_longest_mars_mission.awk [space_missions.log]
#        ./find_longest_mars_mission.awk space_missions.log  (Unix, with execute permission)
#
# Input: Pipe-delimited log with fields:
#        Date | Mission ID | Destination | Status | Crew Size | Duration (days) | Success Rate | Security Code
#
# Output: Security code (format: ABC-123-XYZ)

BEGIN {
    FS = "|"
}

# Skip comments and metadata lines
/^#/ { next }
/^[A-Z][A-Z]*:/ { next }

{
    # Trim whitespace from relevant fields
    gsub(/^[ \t]+|[ \t]+$/, "", $3)   # Destination
    gsub(/^[ \t]+|[ \t]+$/, "", $4)   # Status
    gsub(/^[ \t]+|[ \t]+$/, "", $6)   # Duration
    gsub(/^[ \t]+|[ \t]+$/, "", $8)   # Security Code

    if ($3 == "Mars" && $4 == "Completed") {
        duration = $6 + 0
        if (duration > max_duration) {
            max_duration = duration
            security_code = $8
        }
    }
}

END {
    print security_code
}
