# How to put this on GitHub (no coding, ~10 minutes)

You do **not** need to install anything or use a terminal. GitHub lets you drag files into your web browser. Here's the whole process.

## 1. Make a free GitHub account
Go to **github.com** and sign up (free). Verify your email.

## 2. Create an empty repository
1. Click the **+** in the top-right → **New repository**.
2. **Repository name:** `hla-engageability` (or anything you like).
3. Add a short description, e.g. *"HLA class I engageability — Claude Science Hackathon 2026."*
4. Choose **Public** (so the judges can see it).
5. **Do NOT** check "Add a README" — you already have one.
6. Click **Create repository**.

## 3. Upload this folder
1. On the new empty repo page, click the link **"uploading an existing file"** (or the **Add file → Upload files** button).
2. Open the unzipped `hla-engageability` folder on your computer.
3. Select **everything inside it** (all the files and folders) and **drag them into the browser** upload area. GitHub keeps the folder structure automatically.
   - If drag-and-drop is finicky, click **"choose your files"** and select them. You can upload folders too.
   - It may take a minute — there are figures and tables.
4. Scroll down, leave the default "commit" message, and click **Commit changes**.

That's it — your repo is live. The URL will look like `github.com/<your-username>/hla-engageability`. That link is what you submit.

## 4. (Optional) Check it looks right
- The front page should show your `README.md` rendered automatically — that's your project summary.
- Click into `arms/` to see each experiment; `notebooks/reproduce_headline.ipynb` will display the B\*58:01 reproduction with its output.

## What's already inside (so you know it's complete)
- **README.md** — the project summary and headline results (shows on the front page).
- **arms/** — every experiment's methods, results, figures, and data tables.
- **data/derived/** — the aggregated tables behind the headline numbers.
- **notebooks/reproduce_headline.ipynb** — a runnable notebook that reproduces B\*58:01 (0.665 / FDR 0.003) from the committed table.
- **prereg/** — the pre-registration documents.
- **docs/** — framing, figure index, video script, reviewer Q&A.
- **DATA_ACCESS.md / data/download/** — where every public dataset came from and how to fetch it.

## Notes
- Everything here uses **public data only** — nothing patient-identifiable, safe to make public.
- The big raw datasets are **not** included on purpose (they're huge and public); `data/download/fetch_public_data.sh` says exactly where to get them.
- If you later want the actual analysis code in the repo, use the prompts in `docs/EXPORT_PROMPTS.md` — but the methods docs + data + reproduction notebook already make this a complete, reproducible submission.
