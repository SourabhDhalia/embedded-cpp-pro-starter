## Release Process

Versioning
- Semantic Versioning (MAJOR.MINOR.PATCH). Current starter: 0.1.0.

Cut a release
- Tag: `git tag vX.Y.Z && git push origin vX.Y.Z`
- Workflow: `.github/workflows/release.yml` builds Release and uploads artifacts.
- Artifacts: `host_app`, `firmware` (stub). Add more as needed.

Notes
- Ensure Actions → General → Workflow permissions = Read and write so the release action can upload.

