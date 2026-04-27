
# Spec-Driven Development Rules

## Core Philosophy

"Plan first. Execute in steps. Log everything. Verify against criteria."

**CRITICAL:** No action is complete until its corresponding log files are updated.

---

## Activation Rules

### MUST Activate When:
- User says: "plan", "spec-driven", "structure this", "phase", "let's build"
- Request involves multiple steps or files
- Request requires design decisions
- Estimated work > 10 minutes
- `.planning/` folder exists in project

### MUST NOT Activate When:
- Single-line fix or typo correction
- Direct question requiring only explanation
- User explicitly says "quick fix" or "just do it"

### On Activation — MANDATORY First Steps:
1. Check if `.planning/STATE.md` exists
2. If NO → Create `.planning/` folder and `STATE.md` immediately
3. If YES → Read `STATE.md` to determine current phase and stage
4. Announce state before any other output

---

## Key Concepts

### Phases

A **phase** is one complete workflow (DISCUSS → PLAN → EXECUTE → VERIFY) for a specific goal.

**New Phase Triggers:**
- `.planning/STATE.md` does not exist
- Request is unrelated to active phase goal (compare explicitly)
- User says: "new phase", "different feature", "start fresh"
- Current phase status is 🟢 Complete

**On New Phase — MANDATORY Steps:**
1. Determine next phase number from `STATE.md`
2. Create directory: `.planning/phase-[number]-[short-title]/`
3. Create ALL four files immediately (even if empty with headers):
   - `SPEC.md`
   - `ROADMAP.md`
   - `EXECUTION-LOG.md`
   - `VERIFICATION-LOG.md`
4. Update `STATE.md` with new phase entry
5. ONLY THEN proceed to DISCUSS stage

**NEVER proceed without creating phase directory and files first.**

---

## Project Structure

```
.planning/
├── STATE.md                          (Global — ALWAYS exists)
├── phase-1-user-auth/
│   ├── SPEC.md
│   ├── ROADMAP.md
│   ├── EXECUTION-LOG.md
│   └── VERIFICATION-LOG.md
├── phase-2-api-endpoints/
│   └── ...
```

---

## The Four Stages

### 1. DISCUSS

Clarify goal. Write spec with **measurable acceptance criteria**.

**Mandatory Actions:**
1. Ask clarifying questions (minimum 2-3 unless goal is crystal clear)
2. Write `SPEC.md` with ALL required sections
3. Acceptance criteria MUST be specific and testable
4. End with: "Spec locked. Ready to plan?"

**Creates:** `.planning/phase-X-title/SPEC.md`

**Updates:** `STATE.md` (Stage → DISCUSS)

**BLOCKED until:** SPEC.md contains at least 3 acceptance criteria

---

### 2. PLAN

Break work into 5–8 tasks. Each task MUST have acceptance criteria.

**Mandatory Actions:**
1. Read SPEC.md acceptance criteria
2. Create tasks that map to acceptance criteria
3. Write `ROADMAP.md` with all tasks
4. Update `STATE.md` with all tasks (Status: ⏳ Pending)

**Creates:** `.planning/phase-X-title/ROADMAP.md`

**Updates:** `STATE.md` (Stage → PLAN, add all tasks)

**BLOCKED until:** Every task has at least one acceptance criterion

---

### 3. EXECUTE

Implement ONE task. Log IMMEDIATELY after.

**Mandatory Actions:**
1. Update `STATE.md` FIRST (Task status → 🔄 In Progress)
2. Implement the task
3. Write to `EXECUTION-LOG.md` IMMEDIATELY after implementation
4. Commit with format: `P[phase]T[task]: description`

**Updates (in order):**
1. `STATE.md` (status → 🔄 In Progress) — BEFORE implementation
2. `EXECUTION-LOG.md` — IMMEDIATELY after implementation
3. `STATE.md` (timestamp) — after logging

**BLOCKED until:** EXECUTION-LOG.md entry is written

---

### 4. VERIFY

Check task against EACH acceptance criterion. Log EVERY result.

**Mandatory Actions:**
1. Read task's acceptance criteria from ROADMAP.md
2. Test EACH criterion explicitly
3. Write EACH criterion result to `VERIFICATION-LOG.md`
4. Update `STATE.md` (status → ✅ Done or ❌ Failed)
5. Update `ROADMAP.md` (task status)

**Updates (in order):**
1. `VERIFICATION-LOG.md` — one row PER criterion
2. `STATE.md` — task final status
3. `ROADMAP.md` — task status column

**On Failure:**
- Log the failure in VERIFICATION-LOG.md with details
- Update STATE.md with ❌ Failed status
- Return to EXECUTE for retry
- After 2 consecutive failures → Return to DISCUSS

**BLOCKED until:** All criteria logged in VERIFICATION-LOG.md

---

## Agent Rules — STRICT ENFORCEMENT

### Rule 1: State Announcement
Every response MUST start with:
```
Spec-Driven | Phase: [#] | Stage: [STAGE] | Task: [#/N/A]
```

### Rule 2: Phase Decision
On EVERY new user message:
1. Read current phase goal from STATE.md
2. Compare with new request
3. If unrelated → Create new phase (follow New Phase steps)
4. If related → Continue current phase

### Rule 3: File Integrity
- NEVER modify this rules file
- ALWAYS create all phase files on new phase
- NEVER skip file creation "to save time"

### Rule 4: Logging is Non-Negotiable
```
NO IMPLEMENTATION WITHOUT LOGGING.
NO VERIFICATION WITHOUT LOGGING.
NO STAGE TRANSITION WITHOUT STATE.MD UPDATE.
```

After ANY of these actions, IMMEDIATELY update logs:
- Task started → STATE.md
- Code written → EXECUTION-LOG.md + STATE.md
- Error occurred → EXECUTION-LOG.md (log the error)
- Test run → VERIFICATION-LOG.md
- Task done → STATE.md + ROADMAP.md

### Rule 5: Error Handling
When errors occur:
1. FIRST: Log error in EXECUTION-LOG.md with timestamp
2. THEN: Update STATE.md (add to Blockers if blocking)
3. FINALLY: Attempt resolution
4. Log resolution attempt in EXECUTION-LOG.md

**Errors are NOT an excuse to skip logging.**

### Rule 6: Acceptance Criteria
- SPEC.md MUST have ≥3 acceptance criteria
- Each ROADMAP.md task MUST have ≥1 acceptance criterion
- VERIFY stage MUST check and log EACH criterion

### Rule 7: Completion
- Phase complete → Update STATE.md, say: "Phase [X] complete. Next?"
- All phases complete → "All phases complete. What's next?"

---

## File Templates

### STATE.md (Global)

```markdown
# Project State

**Updated:** [YYYY-MM-DD HH:MM]
**Status:** [🟡 In Progress / 🟢 Complete / 🔴 Blocked]
**Active Phase:** [# or N/A]
**Active Stage:** [DISCUSS / PLAN / EXECUTE / VERIFY]
**Active Task:** [P#T# or N/A]

## Phases

| Phase | Title | Status |
|-------|-------|--------|
| 1 | [title] | 🟡 In Progress / 🟢 Complete / 🔴 Blocked |

## Tasks

| Phase | Task | Description | Status | Completed |
|-------|------|-------------|--------|-----------|
| 1 | 1 | [description] | ⏳ Pending / 🔄 In Progress / ✅ Done / ❌ Failed | - |

## Blockers

| Phase | Task | Issue | Since |
|-------|------|-------|-------|
| - | - | None | - |

## Next Action
[Clear next step]
```

### SPEC.md (Per Phase)

```markdown
# Phase [X] Spec: [Title]

**Locked:** [YYYY-MM-DD]

## Goal
[2-3 sentences]

## Why
[Problem being solved]

## Acceptance Criteria
- [ ] AC1: [Specific, testable condition]
- [ ] AC2: [Specific, testable condition]
- [ ] AC3: [Specific, testable condition]

## Constraints
- [Constraint 1]

## Out of Scope
- [What this phase does NOT cover]
```

### ROADMAP.md (Per Phase)

```markdown
# Phase [X] Roadmap: [Title]

**Created:** [YYYY-MM-DD]
**Tasks:** [0/Y complete]

| Task | Description | Depends On | Acceptance Criteria | Status |
|------|-------------|------------|---------------------|--------|
| 1 | [Do X] | None | - AC1<br>- AC2 | ⏳ Pending |
| 2 | [Do Y] | 1 | - AC3 | ⏳ Pending |
```

### EXECUTION-LOG.md (Per Phase)

```markdown
# Phase [X] Execution Log

| Time | Task | Action | Summary | Files Changed | Commit |
|------|------|--------|---------|---------------|--------|
| YYYY-MM-DD HH:MM | 1 | START | Beginning task | - | - |
| YYYY-MM-DD HH:MM | 1 | DONE | [What was done] | [files] | P1T1: msg |
| YYYY-MM-DD HH:MM | 1 | ERROR | [Error description] | - | - |
```

### VERIFICATION-LOG.md (Per Phase)

```markdown
# Phase [X] Verification Log

| Time | Task | Criterion | Result | Notes |
|------|------|-----------|--------|-------|
| YYYY-MM-DD HH:MM | 1 | AC1: [criterion text] | ✅ Pass / ❌ Fail | [details] |
| YYYY-MM-DD HH:MM | 1 | AC2: [criterion text] | ✅ Pass / ❌ Fail | [details] |
```

---

## Workflow Checklist

```
□ NEW REQUEST RECEIVED
    □ Read STATE.md (or create if missing)
    □ Compare request to active phase goal
    □ Decision: Continue phase OR Create new phase
    
□ NEW PHASE (if needed)
    □ Create .planning/phase-X-title/ directory
    □ Create SPEC.md (empty template)
    □ Create ROADMAP.md (empty template)
    □ Create EXECUTION-LOG.md (empty template)
    □ Create VERIFICATION-LOG.md (empty template)
    □ Update STATE.md with new phase
    
□ DISCUSS
    □ Ask clarifying questions
    □ Write SPEC.md with ≥3 acceptance criteria
    □ Update STATE.md (Stage: DISCUSS)
    □ Say: "Spec locked. Ready to plan?"
    
□ PLAN
    □ Create tasks from acceptance criteria
    □ Write ROADMAP.md with task acceptance criteria
    □ Update STATE.md (Stage: PLAN, add all tasks)
    
□ EXECUTE (per task)
    □ Update STATE.md (task → 🔄 In Progress)
    □ Implement task
    □ Log to EXECUTION-LOG.md immediately
    □ Update STATE.md timestamp
    
□ VERIFY (per task)
    □ Check EACH acceptance criterion
    □ Log EACH criterion in VERIFICATION-LOG.md
    □ Update ROADMAP.md (task status)
    □ Update STATE.md (task → ✅ Done or ❌ Failed)
    
□ PHASE COMPLETE
    □ Update STATE.md (phase → 🟢 Complete)
    □ Say: "Phase [X] complete. Next?"
```

---

## Enforcement Summary

| Action | Required Updates | Blocked Until |
|--------|------------------|---------------|
| New phase | Create directory + 4 files + STATE.md | All files exist |
| DISCUSS complete | SPEC.md + STATE.md | ≥3 acceptance criteria |
| PLAN complete | ROADMAP.md + STATE.md | All tasks have criteria |
| Task start | STATE.md (In Progress) | Status updated |
| Task done | EXECUTION-LOG.md + STATE.md | Log entry written |
| Error occurs | EXECUTION-LOG.md | Error logged |
| Verify task | VERIFICATION-LOG.md (per criterion) + STATE.md + ROADMAP.md | All criteria logged |

---

*Plan. Execute. Log. Verify. No exceptions.*
