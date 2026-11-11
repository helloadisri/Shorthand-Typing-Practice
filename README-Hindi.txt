SHORTHAND & ENGLISH TYPING PRACTICE WEBSITE
============================================

IS PACKAGE MEIN:
1. index.html             - Website ka main code
2. supabase-schema.sql    - Database aur security rules

WEBSITE MEIN KYA HAI?
- Free student registration aur login
- Shorthand exercise list
- Exercise image + English transcription checking
- Wrong, missing aur extra words ka count
- Punctuation check
- English typing test: 5, 10, 15, 20 aur 30 minutes
- Gross WPM, Net WPM aur accuracy
- Student results database mein save
- Admin dashboard: exercise add/delete aur results dekhna
- Starting mein koi fee ya payment gateway nahi

SETUP (EK BAAR KARNA HAI)
-------------------------
STEP 1: SUPABASE PROJECT
1. supabase.com par account banao aur New Project banao.
2. Project open karke SQL Editor par jao.
3. supabase-schema.sql ki poori coding paste karke Run karo.
4. Project Settings > API (ya Connect/API Keys) mein Project URL aur anon/public key copy karo.

STEP 2: WEBSITE CONFIG
1. index.html ko Notepad ya kisi code editor mein kholo.
2. Neeche CONFIGURATION section dhoondo.
3. PASTE_YOUR_SUPABASE_PROJECT_URL_HERE ki jagah apna Project URL paste karo.
4. PASTE_YOUR_SUPABASE_ANON_KEY_HERE ki jagah anon/public key paste karo.
5. File save karo. Service role/secret key kabhi website mein mat paste karna.

STEP 3: NETLIFY PAR PUBLISH
1. Netlify par login karo.
2. Is folder ke andar ki index.html file (ya poora folder ZIP karke) deploy karo.
3. Website ka Netlify link open karke registration test karo.

STEP 4: KHUD KO ADMIN BANAO
1. Website par apne email se pehle normal student registration karo.
2. Supabase > SQL Editor kholo.
3. supabase-schema.sql ke bilkul end mein diye gaye UPDATE command ko uncomment karo.
4. YOUR_EMAIL ki jagah wahi email likho jisse registration kiya hai.
5. Query Run karo, phir website se logout karke dobara login karo.
6. Ab Admin tab dikhna chahiye.

SHORTHAND EXERCISE ADD KARNA
1. Shorthand image ko Supabase Storage mein upload karo.
2. Storage bucket ko public banao aur image ka public URL copy karo.
3. Admin tab mein title, image URL aur exact correct English transcription paste karo.
4. Save Exercise dabao.

IMPORTANT LIMITATIONS / NOTES
-----------------------------
- Student login aur data alag-alag devices par kaam karne ke liye Supabase zaroori hai.
- Student accounts email/password se bante hain. Supabase email confirmation setting ke mutabik confirmation email aa sakta hai.
- Browser mein dikhne wali WPM/accuracy practice estimate hai; official exam result nahi.
- Abhi spelling suggestions/dictionary-based correction nahi hai. Checker words, missing/extra/wrong tokens aur punctuation differences count karta hai.
- Admin account ko SQL se promote karna hota hai; public registration se koi khud admin nahi ban sakta.
- Public launch se pehle apne hi test account se registration, login, practice aur admin functions check kar lena.
