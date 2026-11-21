# Solution - Exercise 1 (CCS6442)

## Part 1

### Requirement 6 - Dead end

**What?**

In requirement 3, I committed `self.username = usrname` on `develop` directly on GitHub and later in requirement 4, I committed `self.bio = the_bio` on my local `develop`, replacing the same line. That is why the two `develop` branches were inconsistent: each had a commit the other did not have. The push was rejected (non-fast-forward), because accepting it would delete the GitHub commit.

Screenshot: `screenshots/step6-rejectedoush.png`

**Answer.**

I ran `pull` (fetch + merge). Git stated a merge conflict in `app/core/user.py`, as expected, because both commits changed the same line. I needed both changes, so I kept both lines, marked resolved, committed the merge and pushed.

Screenshot: `screenshots/step6-conflict-resolved.png`

**Prevention.**

- Pull the latest `develop` before starting local work.
- Do not commit to the same shared branch from two places; it is better to work on a separate feature branch and merge it through a pull request later.

### Requirement 19 - Fixing the bad practice

The PR from `feature/step-4` could not be merged, because the commit message "Some changes" does not describe anything, which makes the history unreadable.

I gave and followed my own review instructions:

1. Created a new branch feature/step4-fixed from `develop`.
2. Made the same change and applied a descriptive commit message.
3. Opened a new PR to `develop` and closed the old PR with a link to the new one.

### Requirement 21 - Release 1.0.0

Gitflow release process:

1. I created `release/1.0.0` from `develop`.
2. I set `version = "1.0.0"` in `pyproject.toml`
3. I merged `release/1.0.0` into `master` through a self assigned PR.
4. Tagged `v1.0.0` on `master` and published a GitHub Release.
5. Merged `release/1.0.0` back into `develop`, so `develop` also has the version change, then deleted the release branch.

### Requirement 22 - New requirement

Why I used a new **feature** branch (`feature/user-str-method`) from `develop`, is because this is a new functionality, not an urgent production bug. It fits in the next release (1.1.0). A hotfix branch is only for urgent production fixes, and a release branch only prepares a version.

### Other notes

- **Push went to the original repo.** After renaming `origin` to `upstream`, `master` still tracked `upstream/master`. Fixed with `git branch --unset-upstream` and a push to `origin/master`.

- **Dependabot.** The settings do not disable version updates, which come from `.github/dependabot.yml`. I removed the file on `master` during the setup, updated `develop`, and deleted the 14 Dependabot branches (closing their PRs).

- **Requirement 12.** `main_runner.py` existed only on `feature/step1`, so `feature/step3` was created from it. Its PR therefore also contains the `feature/step1` commits.

- **Requirement 16.** `feature/step4` started from `develop`, which did not have `main_runner.py`, so the file was created there.

- **Requirement 23.** Hotfix `hotfix/1.0.1` from `master` (the important production bug), merged into `master` (tag `v1.0.1`) and back into `develop`. 1.0.1 is a PATCH version.


## Part 2

 

I used Gitflow for all Part 2 changes:

- new work went on `feature/` branches made from `develop`

- the production version was prepared on a `release/` branch

- the urgent production fix went on a `hotfix/` branch made from `master`

 

Every branch was merged with a Pull Request and then deleted.

 

### 1. Postgres service (`feature/postgres-service`)

- I replaced the `db` service with a new service called `postgres` (image `postgres:16-alpine`, port 5432).

- The `app` service now uses `postgres`.

- The username, password and database name are in an `.env` file. This file is in `.gitignore`, so it is not pushed to GitHub. I only pushed `.env.example`.

- I used a fixed image version, not `latest`, so it does not change by itself.

 
### 2. Checkstatus service (`feature/checkstatus-service`)

- `src/checkstatus.sh` checks every 2 seconds if the database is ready (with `pg_isready`). When it is ready, it prints a message and stops.

- `src/Production-Dockerfile` uses `alpine`, installs `pg_isready` and runs the script every time the container starts.

- I added the `checkstatus` service to `docker-compose.yml`.

- Problem: the first time I got `exec format error`. The reason was that `#!/bin/sh` was not on the first line of the script, I accidently added a new line before it. I fixed it.

 
### 3. Release 1.1.0 (`release/1.1.0`)

- I used a release branch because the new features were ready and I only had to prepare them for production.

- I changed the image to `citycase/assessment2:1.0` and changed the version to 1.1.0.

- Version 1.1.0, because I added new features.

- I merged it into `master`, added the tag `v1.1.0`, and merged it back into `develop`.

- The screenshot with ERROR VERSION is in the release Pull Request.

 
### 4. Hotfix 1.1.1 (`hotfix/1.1.1`)

- The image in 1.1.0 was old. This was a bug in production, so I used a hotfix branch from `master` to fix it fast.

- I changed the image to `citycase/assessment2:2.0`, the newest version on Docker Hub.

- Version 1.1.1, because it is only a fix.

- I merged it into `master`, added the tag `v1.1.1`, and merged it into `develop` so the fix is there too.

 

### Conflicts

I had no merge conflicts in Part 2, because I finished and merged each branch before starting the next one.