#!/usr/bin/env python3

import glob
import os.path
import re
import sys


class convert:
    def main(self):
        self.do_conversion(
            "libs/*/build.jam",
            [self.convert_project_depsvar, self.convert_target],
        )
        self.do_conversion(
            "libs/numeric/*/build.jam",
            [self.convert_project_depsvar, self.convert_target],
        )

    def convert_noop(self, content):
        return content

    def convert_project_depsvar(self, content):
        project_i = content.find("project /boost")
        project_j = content.find("    ;", project_i) + 6
        libs = []
        header_txt = content[0 : project_i - 1]
        project_def = ""
        for l in content[project_i:project_j].splitlines():
            m = re.match(r"        <library>(/boost/.+)", l)
            if m:
                libs.append(m.group(1))
            # elif l == "    ;":
            #     project_def = project_def + "\n        <library>$(boost_dependencies)"
            #     project_def = project_def + "\n" + l
            else:
                project_def = project_def + "\n" + l
        return f"""\
{header_txt}
constant boost_dependencies :\n    {"\n    ".join(libs)} ;
{project_def}
{content[project_j:]}
"""

    def convert_target(self, content):
        # name = re.search(r"^project /boost/(.+)$", content, flags=re.M).group(1)
        alias_re = r"^    \[ alias boost_[^ ]+ \]$"
        alias_match = re.search(alias_re, content, flags=re.M)
        while alias_match:
            alias_new = alias_match.group(0).replace(
                " ]", " : : : : <library>$(boost_dependencies) ]"
            )
            content = content.replace(alias_match.group(0), alias_new)
            alias_match = re.search(alias_re, content, flags=re.M)
        return content

    def do_conversion(self, pattern, programs):
        for path in glob.iglob(pattern):
            if not os.path.isfile(path):
                continue
            content = None
            with open(path) as f:
                print("====", path)
                content = f.read()
            if content:
                # print(content)
                for p in programs:
                    content = p(content)
                    # print(f"---- ---- ----\n{content}")
                # print("====")
                with open(path, "wt") as f:
                    f.write(content)


convert().main()
