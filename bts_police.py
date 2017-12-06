# -*- coding: utf-8 -*-

import sys
import re
import github_comment

def search_bts_id(text):
    bts_id = re.search(r"\bLINEAND-\d+\b", text)

    return bts_id

def build_bts_police_comment():
    comment = "![](https://sdl-stickershop.line.naver.jp/products/0/0/8/1169/android/stickers/20135.png)"
    comment += "\n**Seriously?!**"
    comment += "\nYou changed source code without putting BTS number in pull request title, QA team will cry! "
    comment += "Add BTS number in the title and run retest by posting a comment."

    return comment

def main(argv):
    # Usage tools/github/pull_request_diff_file_list.sh remote_HEAD pr_HEAD | bts_police.py branch_name pr_title repo pr_id

    branch_name = argv[0]
    pull_request_title = argv[1]
    repo = argv[2]
    prid = argv[3]

    if not branch_name.startswith("release_"):
        print("The pull request is not targeting to release branch, skip to check. branch name: " + branch_name)
        sys.exit(0)
        return

    src_changed = False

    for line in sys.stdin:
        if (line.startswith("src/")):
            src_changed = True
            break

    if (src_changed and not search_bts_id(pull_request_title)):
        print("Targeting to release branch, but no BTS ID in PR title. Bad boy!!!")
        github_comment.github_comment(repo, prid, build_bts_police_comment())
        sys.exit(1)

if __name__ == '__main__':
    main(sys.argv[1:])
