import sys
from pathlib import Path

import yaml

BANNED = {
    "enrollment",            # actual enrollment, recorded at the end
    "enrollment_type",
    "overall_status",        # the label
    "last_known_status",
    "actual_duration",       # outcome
    "why_stopped",           # only exists once a trial stopped
    "at_risk",               # the label
    "completion_date",
    "primary_completion_date",
    "results_first_submitted_date",
    "were_results_reported",
    "number_of_nsae_subjects",
    "number_of_sae_subjects",
}

FEATURES_FILE = Path("config/features.yml")


def main() -> int:
    if not FEATURES_FILE.exists():
        print(f"{FEATURES_FILE} not found; nothing to check yet.")
        return 0

    config = yaml.safe_load(FEATURES_FILE.read_text()) or {}
    features = set(config.get("features", []))

    violations = sorted(features & BANNED)
    if violations:
        print("LEAKAGE: banned columns found in the feature list:")
        for column in violations:
            print(f"  - {column}")
        print("\nThese are label, cohort, or post-trial columns. Remove them.")
        return 1

    print(f"OK: {len(features)} features, none banned.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
