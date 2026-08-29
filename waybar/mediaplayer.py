#!/usr/bin/env python3
import json
import urllib.request
import urllib.parse
import sys

def get_media_info():
    # Force Beefweb to parse track metadata arrays via encoded URL parameters
    query = urllib.parse.urlencode({"columns": "%artist%,%title%"})
    url = f"http://localhost:8880/api/player?{query}"
    
    try:
        req = urllib.request.Request(url)
        with urllib.request.urlopen(req, timeout=1) as response:
            root_data = json.loads(response.read().decode())
            
            # Navigate into the top-level "player" object key from the schema
            player = root_data.get("player", {})
            
            state = player.get("playbackState", "stopped")
            active_item = player.get("activeItem", {})
            
            if state == "stopped" or not active_item:
                return {"text": "Foobar2000 is stopped", "class": "stopped"}
            
            # The columns array is now accessible inside player -> activeItem
            columns = active_item.get("columns", [])
            
            artist = ""
            title = "unknown track"
            
            if len(columns) >= 2:
                artist = columns[0].strip()
                title = columns[1].strip()
            elif len(columns) == 1:
                title = columns[0].strip()
                
            # Build your preferred clean, lowercase typography string
            display_text = f"{artist} - {title}" if artist else title
            display_text = display_text.lower().replace("&", "&amp;")
            
            icon = "  " if state == "playing" else "  "
            return {"text": f"{display_text}", "class": state}
            
    except Exception:
        # Graceful placeholder fallback if foobar2000 is closed completely
        return {"text": "Foobar2000 is stopped", "class": "stopped"}

if __name__ == "__main__":
    sys.stdout.write(json.dumps(get_media_info()) + "\n")
