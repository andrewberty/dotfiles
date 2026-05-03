"""Kitten to manually enter a background color."""


def main(args: list[str]) -> None:
    try:
        print("\033[1;36mEnter hex color (e.g. 1a1a2e) or press Enter to clear:\033[0m")
        print("\033[1;35m> \033[0m", end="", flush=True)
        answer = input()
    except Exception:
        return

    if not answer or len(answer.strip()) == 0:
        value = "background"
    else:
        color = answer.strip().lstrip("#")
        value = f"background #{color}"

    import os
    conf = os.path.expanduser("~/.config/kitty/local.conf")

    if os.path.exists(conf):
        with open(conf) as f:
            content = f.read()
        lines = content.splitlines()
        new_lines = [line for line in lines if not line.startswith("background")]
        new_lines.append(value)
        content = "\n".join(new_lines) + "\n"
    else:
        content = value + "\n"

    with open(conf, "w") as f:
        f.write(content)

    os.system("kitten @ load-config")