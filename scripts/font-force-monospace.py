#!/usr/bin/env python3
"""Force a font to declare itself monospaced.

Some monospaced fonts (e.g. several Nerd Font patches of Iosevka) ship with
`post.isFixedPitch = 0`, so CoreText never reports the monospace trait. kitty
and other monospace-only font pickers then skip the font and fall back to a
default (Menlo). This flips the flags that advertise "I am monospaced":

  - post.isFixedPitch -> 1
  - OS/2 PANOSE bProportion -> 9 (monospaced)

It does NOT touch glyph metrics — only the metadata. Use only on fonts whose
glyphs are actually fixed-width.

Usage:
    font-force-monospace.py FONT.ttf [FONT2.ttf ...]   # patch in place
    font-force-monospace.py FONTDIR                    # patch every .ttf/.otf found
    font-force-monospace.py SRC -o OUTDIR              # write patched copies to OUTDIR
    font-force-monospace.py SRC --filter regular,medium  # only matching filenames

Requires fontTools:  pip install fonttools   (or: uvx --from fonttools ...)
"""
import argparse
import os
import sys

try:
    from fontTools.ttLib import TTFont
except ImportError:
    sys.exit("error: fontTools not installed. Run: pip install fonttools")

FONT_EXTS = (".ttf", ".otf")


def collect(paths, name_filters):
    files = []
    for p in paths:
        if os.path.isdir(p):
            for root, _, names in os.walk(p):
                for n in names:
                    if n.lower().endswith(FONT_EXTS):
                        files.append(os.path.join(root, n))
        elif os.path.isfile(p):
            files.append(p)
        else:
            print(f"skip (not found): {p}", file=sys.stderr)
    if name_filters:
        fl = [f.lower() for f in name_filters]
        files = [f for f in files if any(s in os.path.basename(f).lower() for s in fl)]
    return sorted(set(files))


def patch(src, outdir):
    font = TTFont(src)
    before = font["post"].isFixedPitch
    font["post"].isFixedPitch = 1
    if "OS/2" in font and hasattr(font["OS/2"], "panose"):
        font["OS/2"].panose.bProportion = 9
    dest = os.path.join(outdir, os.path.basename(src)) if outdir else src
    font.save(dest)
    return before, dest


def main():
    ap = argparse.ArgumentParser(description="Force fonts to declare themselves monospaced.")
    ap.add_argument("paths", nargs="+", help="font file(s) or directory")
    ap.add_argument("-o", "--outdir", help="write patched copies here (default: in place)")
    ap.add_argument("--filter", help="comma-separated substrings; only patch matching filenames")
    args = ap.parse_args()

    name_filters = [s.strip() for s in args.filter.split(",")] if args.filter else None
    files = collect(args.paths, name_filters)
    if not files:
        sys.exit("no matching font files found")

    if args.outdir:
        os.makedirs(args.outdir, exist_ok=True)

    for f in files:
        before, dest = patch(f, args.outdir)
        print(f"{os.path.basename(f):48s} isFixedPitch {before} -> 1   ({dest})")

    print(f"\npatched {len(files)} file(s)")


if __name__ == "__main__":
    main()
