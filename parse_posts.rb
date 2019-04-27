#!/usr/bin/env ruby

require('json')
require('erb')
require('reverse_markdown')
require('fileutils')

class Parser
  POSTS_FOLDER = '_posts'
  SOURCE_FILE = 'posts.json'
  TEMPLATE_FILE = 'post_template.erb'

  def parse_posts
    posts.each do |post|
      markdown = parse_post(post, template)
      save_markdown(post, markdown)
    end
  end

  def save_markdown(post, markdown)
    year_folder = prepare_year_folder(post)
    filepath = File.join(year_folder, filename(post))

    puts "parsing #{filepath}"
    File.open(filepath, 'w+') do |f|
      f.write(markdown)
      f.close
    end
  end

  def prepare_year_folder(post)
    year = post['date'].to_s[0..3]
    year_folder = File.join(POSTS_FOLDER, year)
    FileUtils.mkdir_p(year_folder)
    year_folder
  end

  def parse_post(post, template)
    post['markdown'] = ReverseMarkdown.convert(post['body'])
    template.result(binding)
  end

  def filename(post)
    "#{post['date']}-#{post['title']}.md"
  end

  def posts
    JSON.parse(File.read(SOURCE_FILE))
  end

  def template
    @template ||= ERB.new(File.read(TEMPLATE_FILE))
  end
end

parser = Parser.new
parser.parse_posts
