"""Kitten to adjust background brightness without changing hue or saturation."""

import colorsys
import os
import re

from kittens.tui.handler import result_handler
from kitty.boss import Boss


def main(args: list[str]) -> None:
    pass


@result_handler(no_ui=True)
def handle_result(args: list[str], answer: str, target_window_id: int, boss: Boss) -> None:
    if len(args) < 2:
        return

    direction = args[1]

    w = boss.window_id_map.get(target_window_id)
    if w is None:
        return

    conf = os.path.expanduser("~/.config/kitty/local.conf")

    if direction == "reset":
        value = "background"
    else:
        if len(args) < 3:
            return
        amount = float(args[2])

        # Read current background from color profile (direct memory access, no IPC)
        bg = w.screen.color_profile.default_bg
        r = bg.red
        g = bg.green
        b = bg.blue

        # RGB -> HSV, adjust only V (brightness), HSV -> RGB
        h, s, v = colorsys.rgb_to_hsv(r / 255, g / 255, b / 255)
        step = amount / 100
        v = min(1.0, v + step) if direction == "brighten" else max(0.0, v - step)
        r2, g2, b2 = colorsys.hsv_to_rgb(h, s, v)

        ri, gi, bi = round(r2 * 255), round(g2 * 255), round(b2 * 255)
        value = f"background #{ri:02x}{gi:02x}{bi:02x}"
    if os.path.exists(conf):
        with open(conf) as f:
            content = f.read()
        if re.search(r"^background\b", content, re.MULTILINE):
            content = re.sub(r"^background\b.*", value, content, flags=re.MULTILINE)
        else:
            content = content.rstrip("\n") + "\n" + value + "\n"
        with open(conf, "w") as f:
            f.write(content)
    else:
        with open(conf, "w") as f:
            f.write(value + "\n")

    boss.call_remote_control(w, ("load-config",))
