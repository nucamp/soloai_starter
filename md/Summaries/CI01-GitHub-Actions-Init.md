• Create a comprehensive GitHub Actions CI/CD workflow that automatically builds, tests, and validates the SaaS application on every push and pull request

• Establish automated quality gates and ensure consistent deployment readiness across all environments to reduce manual testing overhead

• Trigger automated build validation on every push to main/develop branches and execute complete Vitest unit tests and Playwright e2e tests

• Implement multi-environment testing against Node.js 18+ LTS with matrix strategy and cache node_modules and build artifacts for faster execution

• Display test results and coverage reports in GitHub UI and store build outputs for potential deployment use

• Provide clear failure notifications with actionable error messages when builds or tests fail

• Start MySQL, Strapi, and Mautic containers for e2e tests and load test environment variables securely

• Initialize test database with required schema and seed data, and mock external services (OpenAI, Stripe, LemonSqueezy) for reliable testing

• Complete CI pipeline within 10 minutes with unit tests finishing within 2 minutes and e2e tests within 8 minutes

• Achieve 60%+ reduction in subsequent build times through efficient dependency caching and optimize