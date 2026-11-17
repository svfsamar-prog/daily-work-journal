# Daily Work Journal (Personal Work Tracker)

A clean, responsive, single-file web application for personal daily work logging, reports, and calendar tracking built with vanilla HTML/CSS/JavaScript and backed by Supabase.

Designed with precision to match the provided mobile-first showcase UI (Journal, Calendar, Reports, Profile, Holiday Management, and PDF/Excel exports).

---

## Features
- **Single-File Architecture:** Entire application runs from a single `index.html` file (HTML + CSS + Vanilla JS) with zero build steps or complex toolchains.
- **Supabase Backend:** Secure authentication and Postgres database with Row Level Security (RLS).
- **Daily Journal:**
  - Fast task entry (`Enter` to save, optimistic UI).
  - Multi-status badges: `✔ Done`, `⏳ Pending`, `↻ Follow-up`.
  - Date navigation, multi-day ranges (`To date`), and remarks.
  - "Pending from before" automatic rollover with direct "Mark Done" action.
  - Automatic Sunday handling & custom holiday management with off-day banner and empty-state illustrations.
- **Calendar View:** Monthly grid with legend badges (Today, Has entries, Past working day with no entries, Sunday, Holiday with "H" tag, quick date jump).
- **Reports & Exports:**
  - View summaries by Day, Week, Month, or Custom date range.
  - In-browser **PDF Export** (jsPDF + AutoTable) with styled employee header, tables, and pagination.
  - In-browser **Excel Export** (SheetJS) with 2 sheets: detailed "Journal" and aggregated "Summary" metrics.
- **Profile:** Manage your name, Employee ID, designation, and branch with instant cloud sync.
- **Toasts & Undo:** Dismissable notification toasts for saves, errors with retry, and deleted entries with a 5-second Undo buffer.
- **Dark Mode & Responsive:** Full CSS variable theming with automatic system dark mode support and mobile optimization down to 360px viewports.

---

## Setup Steps

### 1. Supabase Project Setup
> **Note:** A Supabase project named `daily-work-journal` has already been created in your Supabase account:
> - **Project URL:** `https://cnkiubxytibtfxjxaaku.supabase.co`
> - **Tables & RLS:** `profile`, `entries`, and `holidays` have already been initialized via `schema.sql`.

If you are setting up a fresh or different Supabase project:
1. Go to [supabase.com](https://supabase.com) and create a free project.
2. Navigate to **SQL Editor**, paste the contents of [schema.sql](schema.sql), and click **Run**.

### 2. User Authentication Setup
1. In your Supabase Dashboard, go to **Authentication** → **Users**.
2. Click **Add user** → **Create user**:
   - Enter your email and a secure password.
   - Toggle **Auto Confirm User?** to **ON**.
3. Go to **Authentication** → **Sign In / Providers** (or **Email** auth settings):
   - Turn **OFF** *"Allow new users to sign up"* (this keeps your journal strictly private).

### 3. Connect API Keys to `index.html`
1. In the Supabase Dashboard, go to **Project Settings** (gear icon) → **API**.
2. Copy:
   - **Project URL**
   - **anon / public** key (never use the `service_role` key).
3. Open `index.html` and update the config block at the top of the `<script>` section:
   ```javascript
   const SUPABASE_URL = "https://cnkiubxytibtfxjxaaku.supabase.co"; // your Project URL
   const SUPABASE_ANON_KEY = "your_actual_anon_public_key_here";
   ```
   *(Alternatively, if the default key is present, the web app will provide a quick prompt on first sign-in to save your anon key safely in your browser).*

### 4. Deploy to GitHub Pages
1. Create a **PUBLIC** (or Private with GitHub Pro) repository on GitHub.
2. Upload `index.html` (and optionally `schema.sql` and `README.md`).
3. In your GitHub repository, go to **Settings** → **Pages**.
4. Under **Build and deployment** → **Branch**, select `main` (or `master`), path `/ (root)`, and click **Save**.
5. Wait 1–2 minutes, then visit your published GitHub Pages URL.

### 5. Start Journaling
1. Open your published app URL.
2. Sign in with the email and password you created in Step 2.
3. Switch to the **Profile** tab, fill in your details (Name, Employee ID, Designation, Branch), and click **Save Changes**.
4. Jump back to **Journal** and begin logging your daily work tasks!

---

> [!NOTE]
> Free-tier Supabase projects automatically pause after approximately 1 week of inactivity. If you haven't opened the journal in a while and see connection errors, visit your Supabase dashboard and click **Restore**.
