"""Kitten to adjust font size without affecting other settings."""

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

    current_value = 13.0
    if os.path.exists(conf):
        with open(conf) as f:
            content = f.read()
        match = re.search(r"^font_size\s+(\d+(?:\.\d+)?)", content, re.MULTILINE)
        if match:
            current_value = float(match.group(1))

    step = 1.0 if len(args) < 3 else float(args[2])

    if direction == "reset":
        if os.path.exists(conf):
            with open(conf) as f:
                content = f.read()
            content = re.sub(r"^font_size.*\n?", "", content, flags=re.MULTILINE)
            with open(conf, "w") as f:
                f.write(content)
        boss.call_remote_control(w, ("load-config",))
        return
    elif direction == "increase":
        new_value = current_value + step
    elif direction == "decrease":
        new_value = current_value - step
    else:
        return

    new_value = min(50.0, max(4.0, new_value))
    if new_value == int(new_value):
        value = f"font_size {int(new_value)}"
    else:
        value = f"font_size {new_value}"

    if os.path.exists(conf):
        with open(conf) as f:
            content = f.read()
        if re.search(r"^font_size", content, re.MULTILINE):
            content = re.sub(
                r"^font_size.*",
                value,
                content,
                flags=re.MULTILINE
            )
        else:
            content = content.rstrip("\n") + "\n" + value + "\n"
        with open(conf, "w") as f:
            f.write(content)
    else:
        with open(conf, "w") as f:
            f.write(value + "\n")

    boss.call_remote_control(w, ("load-config",))