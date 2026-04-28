---
name: yard-documenter
description: >
  Generates YARD documentation comments for Ruby code. Use when asked to
  document, add docs, annotate, or write documentation for any Ruby methods,
  classes, or modules. Also use when asked to add @param, @return, @raise,
  @example, or other YARD tags to Ruby code, even if the user doesn't
  explicitly say "YARD".
license: MIT
---

# YARD Documenter

- Full YARD tag reference: https://rubydoc.info/gems/yard/file/docs/Tags.md
- YARD type parser: https://yardoc.org/types.html

## Instructions

### Required for ALL documented methods

- Short description ending with a period (`.`)
- Always prefix method names with `#` (e.g. `#find_by_email`)
- Keep line length under 100 characters
- At least one `@example` showing basic usage with the following rules:
  - Use single-quotes (`'`) for all strings in the example input code
  - Use double-quotes (`"`) when a string is interpolated in the example input code
  - Use double-quotes (`"`) for strings in the `# =>` output line
- `@note` for important details or side effects when applicable, ending with a period (`.`)
- `@param` for each parameter with type(s) annotation if the method has arguments
- `@raise` for any exceptions that may be raised
- `@return` with type(s) annotation

### Required for complex methods

- `@option` when a `@param` is a `Hash`
- `@see` links to related classes or URLs; prefix method names with `#`
- `@since` the version from the `.gemspec` file, if the project is a gem or Rails engine
- `@overload` when a method can be called in different ways
- Document `Array` types with the types of the array items `Array<String>`

### `@overload` format

~~~ruby
# ...
# @overload set(key, value)
#   Sets a value on key
#   @param key [Symbol] describe key param
#   @param value [Object] describe value param
#
# @overload set(value)
#   Sets a value on the default key `:foo`
#   @param value [Object] describe value param
# ...
#
def set(*args)
end
~~~

### Multi-line tags

~~~ruby
# @tagname This is
#   multi-line tag data
~~~

## Template

Use this structure when documenting methods. Omit any tags that don't apply.

~~~ruby
# Short description.
#
# @note Important detail.
#
# @param name [Types] description
# @param options [Hash] description
# @option options [Types] :key (default_value) description
# @return [Types] description
#
# @raise [ExceptionType] description
#
# @overload method_signature(parameters)
#   Indented docstring for overload
#   @param name [Types] description
#   @return [Types] description
#
# @overload method_signature(parameters)
#   Indented docstring for overload
#   @param name [Types] description
#   @return [Types] description
#
# @example Basic usage
#   code_example
#
# @example Advanced usage
#   code_example
#
# @see RelatedClass description
# @see #related_method description
# @see https://example.com description
#
# @since 1.0.0
#
def method_name(name, options = {})
end
~~~

## Example: Fully Documented Method

Before:

~~~ruby
def find_by_email(email, options = {})
  raise ArgumentError, "Email can't be blank" if email.blank?
  query = where(email: email)
  query = query.where("lower(email) = lower(?)", email) if !options[:case_sensitive]
  query.first
end
~~~

After:

~~~ruby
# Finds a user by their email address.
#
# @param email [String] the email address to search for
# @param options [Hash] optional search modifiers
# @option options [Boolean] :case_sensitive (false) whether to match case exactly
# @return [User, nil] the matching user, or nil if not found
#
# @raise [ArgumentError] if email is blank
#
# @example Basic usage
#   User.find_by_email('alice@example.com')
#
# @example Case-sensitive lookup
#   User.find_by_email('Alice@example.com', case_sensitive: true)
#
# @since 1.2.0
#
def find_by_email(email, options = {})
  raise ArgumentError, "Email can't be blank" if email.blank?
  query = where(email: email)
  query = query.where("lower(email) = lower(?)", email) unless options[:case_sensitive]
  query.first
end
~~~
