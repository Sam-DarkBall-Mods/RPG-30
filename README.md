# RPG-30 Hook

[![CI](https://github.com/Sam-DarkBall-Mods/RPG-30/actions/workflows/ci.yml/badge.svg)](https://github.com/Sam-DarkBall-Mods/RPG-30/actions/workflows/ci.yml)

The RPG-30 Kryuk disposable anti-tank launcher for Arma 3, from the
[Steam Workshop item](https://steamcommunity.com/sharedfiles/filedetails/?id=3042754975).

## Requirements

- Arma 3
- [CBA_A3](https://steamcommunity.com/sharedfiles/filedetails/?id=450814997)

## Build

```bash
python3 -B tools/validate_repository.py
python3 -B -m unittest discover -s tests -p "test_*.py" -v
hemtt check
hemtt build
```

The addon is packed without binarization: the model and materials are already
binarized in the Workshop release. The PBO keeps the `rpg_30` prefix and the
`rpg_30` signing key, so existing servers keep working.

## License

See [LICENSES.md](LICENSES.md) and [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).
