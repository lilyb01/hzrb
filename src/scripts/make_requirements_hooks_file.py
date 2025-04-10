import os
from typing import Set

from build_site import read_info, get_extra_comics_list, get_extra_comic_info, get_option
from utils import find_project_root, str_to_list


def get_requirements(theme: str) -> Set[str]:
    requirements_path = f"{CONTENT_DIR}/themes/{theme}/scripts/requirements.txt"
    if os.path.exists(requirements_path):
        with open(requirements_path) as f:
            return set(str_to_list(f.read().replace("\r", ""), delimiter="\n"))
    return set()


def main():
    global CONTENT_DIR
    comic_info = read_info("comic_info.ini")
    theme = get_option(comic_info, "Comic Settings", "Theme", default="default")
    CONTENT_DIR = get_option(comic_info, "Comic Settings", "Content folder", default="content")
    find_project_root(CONTENT_DIR)
    requirements = get_requirements(theme)
    print(requirements)
    # Build any extra comics that may be needed
    for extra_comic in get_extra_comics_list(comic_info):
        print(extra_comic)
        extra_comic_info = get_extra_comic_info(extra_comic, comic_info, CONTENT_DIR)
        theme = get_option(extra_comic_info, "Comic Settings", "Theme")
        if theme:
            requirements.update(get_requirements(theme))
            print(requirements)
    with open("src/scripts/requirements_hooks.txt", "w") as f:
        f.write("\n".join(requirements))


if __name__ == "__main__":
    main()
