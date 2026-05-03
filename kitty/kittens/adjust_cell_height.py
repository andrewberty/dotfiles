"""Kitten to adjust cell height without affecting other modify_font settings."""

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

    current_value = 100
    if os.path.exists(conf):
        with open(conf) as f:
            content = f.read()
        match = re.search(r"modify_font\s+cell_height\s+(\d+)%", content)
        if match:
            current_value = int(match.group(1))

    step = 10 if len(args) < 3 else int(args[2])

    if direction == "reset":
        if os.path.exists(conf):
            with open(conf) as f:
                content = f.read()
            content = re.sub(r"modify_font\s+cell_height.*\n?", "", content)
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

    new_value = min(200, max(50, new_value))
    value = f"modify_font cell_height {new_value}%"

    if os.path.exists(conf):
        with open(conf) as f:
            content = f.read()
        if re.search(r"modify_font\s+cell_height", content):
            content = re.sub(
                r"modify_font\s+cell_height.*",
                value,
                content
            )
        else:
            content = content.rstrip("\n") + "\n" + value + "\n"
        with open(conf, "w") as f:
            f.write(content)
    else:
        with open(conf, "w") as f:
            f.write(value + "\n")

    boss.call_remote_control(w, ("load-config",))