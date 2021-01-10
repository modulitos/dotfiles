import sys
import os
import time
import subprocess
from pathlib import Path


def timer(seconds: int, message: str):
    message = message if message else "time is up!"
    for remaining in range(seconds, 0, -1):
        sys.stdout.write("\r")
        minutes_left = remaining // 60
        seconds_left = remaining % 60
        sys.stdout.write(f"{minutes_left:2d}:{seconds_left:02d}")
        sys.stdout.flush()
        time.sleep(1)

    print(f"message: {message}")
    home = str(Path.home())

    # if macos:
    subprocess.run(
        ["osascript", "-e", f'display notification "" with title "{message}"']
    )
    bell_path = os.path.join(home, "sounds/bell-ringing-04.wav")
    subprocess.run(["afplay", bell_path])


# TODO: if linux:
# notify-send "Time is up!" "$message"
# subprocess.run(
# ["notify-send", '"Time is up!"', f'{message}']
# )
#  subprocess.run(["play", bell_path])
# play ~/sounds/bell-ringing-04.wav
