---
name: better-spec
description: >
  Write RSpec tests following the Better Specs guidelines from betterspecs.org.
  Use this skill whenever the user wants to write, review, refactor, or improve
  RSpec tests for Ruby or Rails applications. Trigger on any mention of RSpec,
  spec files, test writing in Ruby/Rails, or requests to "add tests", "write specs",
  "improve test coverage", "refactor specs", or "make tests better". Also use when
  the user shares existing spec files and asks for feedback, code review, or
  improvements. Do NOT use for non-RSpec test frameworks.
license: MIT
---

# Better Spec — RSpec Writing Guidelines

Write RSpec tests following the [Better Specs](https://www.betterspecs.org/) guidelines.
Apply all rules below by default. When reviewing existing specs, flag violations and offer corrected versions.

---

## 1. Describe Your Methods

Use Ruby doc conventions in `describe` blocks:
- `.method_name` for class methods
- `#method_name` for instance methods
```ruby
# bad
describe 'the authenticate method for User' do
describe 'if the user is an admin' do

# good
describe '.authenticate' do
describe '#admin?' do
```

---

## 2. Use Contexts

Group related tests with `context`. Always start context descriptions with **`when`**, **`with`**, or **`without`**.

```ruby
# bad
it 'has 200 status code if logged in' do
  expect(response).to respond_with 200
end

# good
context 'when logged in' do
  it { is_expected.to respond_with 200 }
end

context 'when logged out' do
  it { is_expected.to respond_with 401 }
end
```

---

## 3. Keep Descriptions Short (≤ 40 characters)

If a description is longer than 40 characters, split it using a context block.

```ruby
# bad
it 'has 422 status code if an unexpected params will be added' do

# good
context 'when not valid' do
  it { is_expected.to respond_with 422 }
end
```

---

## 4. Single Expectation Per Test

Each test should make **one assertion** in isolated unit specs. Multiple expectations are acceptable only in slow integration/DB tests where repeating setup is expensive. When a non-isolated test has multiple expectations, add `:aggregate_failures` so all failures are reported at once rather than stopping at the first one.

```ruby
# good (isolated)
it { is_expected.to respond_with_content_type(:json) }
it { is_expected.to assign_to(:resource) }

# good (not isolated — DB/integration test with multiple expectations)
it 'creates a resource', :aggregate_failures do
  expect(response).to respond_with_content_type(:json)
  expect(response).to assign_to(:resource)
end
```

---

## 5. Test All Possible Cases

Always cover valid, edge, and invalid cases. Think through all possible inputs for every method.

```ruby
# bad
it 'shows the resource'

# good
describe '#destroy' do
  context 'when resource is found' do
    it 'responds with 200'
    it 'shows the resource'
  end

  context 'when resource is not found' do
    it 'responds with 404'
  end

  context 'when resource is not owned' do
    it 'responds with 404'
  end
end
```

---

## 6. Use `expect` Syntax (Never `should`)

Always use `expect(...)` syntax. Use `is_expected.to` for one-liners or implicit subject.
Configure RSpec to enforce this in `spec_helper.rb`.

```ruby
# bad
response.should respond_with_content_type(:json)
it { should respond_with 422 }

# good
expect(response).to respond_with_content_type(:json)
it { is_expected.to respond_with 422 }

# spec_helper.rb
RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
```

---

## 7. Use `subject`

When multiple tests share the same subject, DRY them up with `subject{}`. Use named subjects for clarity.

```ruby
# bad
it { expect(assigns('message')).to match /it was born in Belville/ }

# good
subject { assigns('message') }
it { is_expected.to match /it was born in Billville/ }

# good (named subject)
subject(:hero) { Hero.first }
it 'carries a sword' do
  expect(hero.equipment).to include 'sword'
end
```

---

## 8. Use `let` and `let!`

Prefer `let` over `before` blocks for variable assignment. `let` is lazy-loaded and memoized per test. Use `let!` when the variable must be defined immediately (e.g., to seed the DB).

```ruby
# bad
describe '#type_id' do
  before { @resource = create :device }
  before { @type     = Type.find @resource.type_id }

  it 'sets the type_id field' do
    expect(@resource.type_id).to eq(@type.id)
  end
end

# good
describe '#type_id' do
  let(:resource) { create :device }
  let(:type)     { Type.find resource.type_id }

  it 'sets the type_id field' do
    expect(resource.type_id).to eq(type.id)
  end
end
```

---

## 9. Mock Sparingly

Test real behavior when possible. Use mocks/stubs only when necessary (e.g., external services, unavailable resources). Do not over-mock.

```ruby
# acceptable mock — simulating a not-found resource
context 'when not found' do
  before do
    allow(Resource).to receive(:where).with(created_from: params[:id])
      .and_return(false)
  end

  it { is_expected.to respond_with 404 }
end
```

---

## 10. Create Only the Data You Need

Don't load excessive test data. If you think you need dozens of records, you're probably wrong. Create the minimum required.

```ruby
describe '.top' do
  before { create_list(:user, 3) }
  it { expect(User.top(2)).to have(2).item }
end
```

---

## 11. Use Factories, Not Fixtures

Use FactoryBot factories instead of fixtures. Fixtures are hard to control.
Exception: for pure unit tests, avoid both and test domain logic directly in libraries.

```ruby
# bad
user = User.create(name: 'Genoveffa', surname: 'Piccolina', ...)

# good
user = create :user
```

---

## 12. Use Readable Matchers

Use the most readable built-in RSpec matchers. Check [rspec matchers docs](https://rspec.info/features/3-12/rspec-expectations/built-in-matchers/).

```ruby
# bad
lambda { model.save! }.to raise_error Mongoid::Errors::DocumentNotFound

# good
expect { model.save! }.to raise_error Mongoid::Errors::DocumentNotFound
```

---

## 13. Use Shared Examples

Eliminate duplication with shared examples. Especially useful for controllers with common behaviours.

```ruby
# bad — inline duplication
describe 'GET /devices' do
  # ... lots of repeated logic
end

# good
describe 'GET /devices' do
  let!(:resource) { create :device, created_from: user.id }
  let!(:uri)      { '/devices' }

  it_behaves_like 'a listable resource'
  it_behaves_like 'a paginable resource'
  it_behaves_like 'a searchable resource'
  it_behaves_like 'a filterable list'
end
```

---

## 14. Test at the Right Level

Avoid testing controllers directly — request specs drive behaviour through the full stack (including routing) and cover the same ground more meaningfully.

Request specs (`type: :request`, or files in `spec/requests/`) are a thin wrapper around Rails' integration tests. They let you specify single or multi-request flows across controllers and sessions without needing Capybara. Controller specs can live in `spec/controllers/` but must explicitly set `type: :request` to ensure they run through the full stack.

```ruby
# spec/requests/widget_management_spec.rb
RSpec.describe "Widget management", type: :request do
  it "creates a Widget and redirects to the Widget's page" do
    post "/widgets", params: { widget: { name: "My Widget" } }

    expect(response).to redirect_to(assigns(:widget))
  end

  context 'when requesting JSON' do
    it 'returns a created status' do
      headers = { "ACCEPT" => "application/json" }
      post "/widgets", params: { widget: { name: "My Widget" } }, headers: headers

      expect(response).to have_http_status(:created)
    end
  end
end
```

Note: Capybara is **not** supported in request specs. If you need browser-level JS interaction, use system specs instead.

---

## 15. Don't Use "should" in Descriptions

Write `it` descriptions in the third person present tense, not with "should".

```ruby
# bad
it 'should not change timings' do

# good
it 'does not change timings' do
  expect(consumption.occur_at).to eq(valid.occur_at)
end
```

---

## 16. Stub External HTTP Requests

Use `webmock` or `VCR` for external HTTP calls — never rely on real external services in tests.

```ruby
context 'with unauthorized access' do
  let(:uri) { 'http://api.example.com/types' }
  before    { stub_request(:get, uri).to_return(status: 401, body: fixture('401.json')) }

  it 'gets a not authorized notification' do
    page.driver.get uri
    expect(page).to have_content 'Access denied'
  end
end
```

---

## Checklist When Writing or Reviewing Specs

When generating or reviewing RSpec tests, verify each of these:

- [ ] `describe` uses `.method` or `#method` convention
- [ ] `context` blocks start with `when`, `with`, or `without`
- [ ] Descriptions are ≤ 40 characters
- [ ] Each isolated unit test has a single expectation
- [ ] Non-isolated tests with multiple expectations use `:aggregate_failures`
- [ ] All cases covered: valid, edge, invalid
- [ ] Uses `expect` / `is_expected.to` (no `should`)
- [ ] `subject` used where appropriate
- [ ] `let`/`let!` used instead of `before` + instance variables
- [ ] Mocks used sparingly and only when justified
- [ ] Minimal data created per test
- [ ] FactoryBot used (no raw `.create(...)` with full attributes)
- [ ] Readable RSpec matchers used
- [ ] Shared examples used for repeated patterns
- [ ] Controller behaviour tested via request specs (`spec/requests/`), not controller specs
- [ ] No "should" in `it` descriptions
- [ ] External HTTP calls are stubbed
