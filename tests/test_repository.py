from __future__ import annotations

import tomllib
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


class RepositoryContractTests(unittest.TestCase):
    def test_release_version_is_at_least_1_0_0(self) -> None:
        with (ROOT / ".hemtt" / "project.toml").open("rb") as project:
            version = tomllib.load(project)["version"]
        self.assertGreaterEqual((version["major"], version["minor"], version["patch"]), (1, 0, 0))

    def test_every_addon_has_a_legacy_pboprefix(self) -> None:
        addon_dirs = [
            path
            for root_name in ("addons", "optionals")
            for path in (ROOT / root_name).glob("*")
            if path.is_dir()
        ]
        self.assertTrue(addon_dirs)
        for addon_dir in addon_dirs:
            with self.subTest(addon=addon_dir.name):
                prefix = addon_dir / "$PBOPREFIX$"
                self.assertTrue(prefix.is_file())
                self.assertTrue(prefix.read_text(encoding="utf-8").strip())


if __name__ == "__main__":
    unittest.main()
