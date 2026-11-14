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
