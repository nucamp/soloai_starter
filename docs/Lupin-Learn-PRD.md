# Product Requirements Document (PRD) — Reverse engineered from Lupin Learn

## 1. Project Title
Lupin Learn — AI Tools to Save Time for Teachers.

## 2. Overview
**What are you building?**  
A web platform that bundles a suite of AI tools designed specifically for K-12 and higher education instructors to automate repetitive tasks, generate curriculum content, grade assignments, and support student interactions.

**Why does it matter?**  
Teachers face heavy administrative and repetitive workloads. Lupin Learn aims to reduce teacher workload by up to 10 hours per week through a set of educator-focused AI tools, freeing teachers to focus on instruction and student outcomes.

## 3. Goals & Success Criteria
**Goals (this phase):**
- Launch a polished marketing site showcasing core tools and benefits for teachers.
- Provide a clear product tour and list of AI tools to drive sign ups.
- Enable account creation and a credit-based trial/purchase flow to convert educators.

**Non-Goals:**
- Building a full LMS integration library in the initial phase beyond basic connectors.
- Enterprise-grade SSO and district-level admin tooling in the first release.

**Success Metrics:**
- Homepage communicates value proposition clearly and shows the full tools catalog.
- Trial sign up conversion rate of new visitors to registered users targets (e.g., 5 percent).
- At least 40 AI tools documented and discoverable from the site.

## 4. Target Users & Use Cases
**Primary Persona(s):**
- Classroom teacher who needs to reduce time spent on grading, lesson planning, and parent communication.
- Instructional coaches or department leads who prototype curriculum and need fast lesson generation.
- School administrators evaluating tools to reduce teacher burnout.

**Use Cases:**
- As a *teacher*, I want an auto grader so I can quickly provide unbiased, constructive feedback on student assignments.
- As a *teacher*, I want a lesson producer to generate curriculum-aligned lesson plans so I can save prep time.
- As a *teacher*, I want a chatbot that answers student questions outside class so I can offload repetitive student support.

## 5. Scope
**In Scope:**
- Marketing site sections: Home, Benefits, AI Tools list, Pricing, FAQ, multi-language toggles.
- User authentication with sign up and login flows.
- Credit-based pricing and promotional code handling.
- Implement the 10 highest priority AI tools as MVP backend services: Auto Grader, Quiz Creator, Chatbot, Lesson Producer, Presentation Producer, Professional Email, Image Producer, Report Card Producer, Text Summarizer, YouTube Summarizer.

**Out of Scope:**
- Full integration with every LMS out of the gate.
- District procurement workflows.
- Offline desktop app.

## 6. Core Features / Requirements
*(Organized as user stories with priority)*

- Feature: Auto Grader (P0)  
  - As a teacher, I can upload student submissions and receive a scored evaluation with constructive feedback so that grading time is reduced.

- Feature: Lesson Producer (P0)  
  - As a teacher, I can generate curriculum-aligned lesson plans with objectives, activities, and assessments so that I can prepare class faster.

- Feature: Chatbot for Students (P0)  
  - As a teacher, I can spin up a class chatbot to answer student questions and provide personalized support.

- Feature: Quiz Creator + LMS Export (P0)  
  - Generate quizzes in multiple formats and export or integrate with common LMS platforms.

- Feature: Content Generators (P1)  
  - Presentation Producer, Image Producer, Social Media Post generator, Quote of the Day.

- Feature: Reporting (P1)  
  - Report Card Producer that generates personalized report cards using templates.

- Feature: YouTube and Text Summarizers (P1)  
  - Tools to summarize long lectures or resources for quick use.

- Feature: Onboarding and Multilanguage Support (P1)  
  - Onboard teachers with a quick tour and ensure localized UI for listed languages on the site.

- Feature: Pricing and Credit System (P1)  
  - Implement credit packs, promotional codes, and free trial credits.

## 7. Requirements Checklist
- [ ] Marketing content for Home, Benefits, AI Tools, Pricing, FAQ available and editable.
- [ ] Authentication sign up and login implemented.
- [ ] At least 10 core AI tools implemented server-side for MVP.
- [ ] Credit-based billing implemented with promo code support.
- [ ] Multilanguage selection available and translations provided for primary flows.
- [ ] Instrument analytics: homepage events, sign up funnel, tool launches.

## 8. Risks & Assumptions
**Risks:**
- Quality and fairness of AI grading may be questioned, generating trust issues among teachers and parents.
- Data privacy and FERPA compliance concerns when processing student work.
- Overpromising time savings could lead to churn if real-world results vary.
- Integration complexity with multiple LMS platforms.

**Assumptions:**
- Teachers will be comfortable uploading non-sensitive sample student data to evaluate tools.
- The platform can rely on third-party LLM providers for core AI capabilities while maintaining acceptable cost per request.
- A credit model aligns with teacher procurement and individual buyer behavior.

## 9. Open Questions
- Which LMS platforms are highest priority for integration and what APIs are required?
- What specific data retention and privacy policies are required to be FERPA compliant?
- What sample datasets and rubric formats will auto grader accept initially?
- Should district/district-admin features be prioritized or deferred to Phase 2?
- Exact pricing tiers, credit values, and conversion rates between credits and real use need to be confirmed from Pricing page details.

## 10. Timeline (Phase-based)
- **Week 1:** Finalize marketing content and multilang toggles, implement sign up/login, stub pricing and promo code UI.
- **Week 2:** Implement core backend for Auto Grader, Lesson Producer, Chatbot; implement credit accounting.
- **Week 3:** Add Quiz Creator with LMS export, Presentation and Image Producer, reporting pipeline.
- **Week 4:** QA, privacy and security review, pilot with a small group of teachers, polish UX and documentation.

## 11. Appendix
**Notes from the website that informed this PRD**  
- Value proposition: "Less Tedious Work, More Teaching that Matters" and explicit claim of saving "up to 10 hours a week."
- Catalog of 40+ AI tools listed on the site.
