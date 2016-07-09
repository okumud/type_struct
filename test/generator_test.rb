require "type_struct/ext"
require "type_struct/generator"

module GeneratorTest
  def test_parse(t)
    hash = {
      message: 'hello',
      posts:   [
        {
          id:    123,
          title: "hi",
          time:  123.456,
          show:  true,
        },
      ],
      author:  {
        name: "ksss",
        age:  30,
      },
      strs:    %w(aaa bbb ccc),
      aaary:   [[[true, false]]],
      links:   [],
      friends: {},
    }
    result = TypeStruct::Generator.new.parse("AutoGeneratedStruct", hash)
    expect = <<DEFINITION
Post = TypeStruct.new(
  id: Integer,
  title: String,
  time: Float,
  show: TrueClass | FalseClass,
)
Author = TypeStruct.new(
  name: String,
  age: Integer,
)
AutoGeneratedStruct = TypeStruct.new(
  message: String,
  posts: ArrayOf(Post),
  author: Author,
  strs: ArrayOf(String),
  aaary: ArrayOf(ArrayOf(ArrayOf(TrueClass | FalseClass))),
  links: Array,
  friends: Hash,
)
DEFINITION
    unless result == expect
      t.error("unexpected result\nresult:\n#{result}\nexpect:\n#{expect}")
    end
  end
end
