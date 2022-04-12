try:
    from src.scripts.build_site import delete_output_file_space
    from src.scripts.build_site import read_info, get_option
except ImportError:
    # Some people have issues with the above import. Try this one as well, just to see if it works.
    from build_site import delete_output_file_space
    from build_site import read_info, get_option
from utils import find_project_root

comic_info = read_info("comic_info.ini")
CONTENT_DIR = get_option(comic_info, "Comic Settings", "Content folder", default="content")

find_project_root(CONTENT_DIR)
delete_output_file_space()
