#!/usr/bin/env ruby
# frozen_string_literal: true

require "date"
require "fileutils"
require "yaml"

ROOT = File.expand_path("..", __dir__)
TODAY = Date.today.iso8601

RAW_GLOB = File.join(ROOT, "raw", "inbox", "*", "transcript.md")
SOURCES_DIR = File.join(ROOT, "wiki", "sources")
ENTITIES_DIR = File.join(ROOT, "wiki", "entities")
DASHBOARDS_DIR = File.join(ROOT, "wiki", "dashboards")
LOG_PATH = File.join(ROOT, "log.md")

def read_frontmatter(path)
  text = File.read(path)
  match = text.match(/\A---\n(.*?)\n---\n/m)
  raise "Missing frontmatter in #{path}" unless match

  YAML.safe_load(match[1], permitted_classes: [Date], aliases: false) || {}
end

def clean_text(text)
  text.to_s.gsub(/\s+/, " ").strip
end

def escape_yaml(value)
  value.to_s.gsub("\\", "\\\\").gsub('"', '\"')
end

def sanitize_filename(name)
  cleaned = name.to_s
    .gsub(/[\/:]/, " - ")
    .gsub(/[?*"<>|]/, "")
    .gsub(/\s+/, " ")
    .strip
  cleaned.empty? ? "Untitled" : cleaned
end

def slugify(text)
  text.to_s
    .downcase
    .unicode_normalize(:nfkd)
    .encode("ASCII", replace: "")
    .gsub(/[^a-z0-9]+/, "-")
    .gsub(/\A-+|-+\z/, "")
end

def parse_guest_names(guest)
  value = clean_text(guest)
  return [value] if value.empty?
  return [value] if value.start_with?("Various")

  value
    .split(/\s+\+\s+|\s+and\s+/i)
    .map { |name| clean_text(name) }
    .reject(&:empty?)
    .uniq
end

def count_values(values)
  counts = {}
  values.each do |value|
    counts[value] ||= 0
    counts[value] += 1
  end
  counts
end

def source_filename(meta, folder_slug)
  date = clean_text(meta["publish_date"])
  title = sanitize_filename(meta["title"])
  base = "#{date} - #{title}"
  path = File.join(SOURCES_DIR, "#{base}.md")
  return path unless File.exist?(path)

  existing = File.read(path)
  return path if existing.include?("raw/inbox/#{folder_slug}/transcript.md")

  File.join(SOURCES_DIR, "#{base} (#{folder_slug}).md")
end

def build_source_note(meta, folder_slug, entity_links)
  title = clean_text(meta["title"])
  guest = clean_text(meta["guest"])
  keywords = Array(meta["keywords"]).map { |item| clean_text(item) }.reject(&:empty?)
  description = clean_text(meta["description"])
  publish_date = clean_text(meta["publish_date"])
  channel = clean_text(meta["channel"])
  video_id = clean_text(meta["video_id"])
  youtube_url = clean_text(meta["youtube_url"])
  duration = clean_text(meta["duration"])
  duration_seconds = meta["duration_seconds"]
  view_count = meta["view_count"]

  summary = if description.empty?
    topics = keywords.first(4)
    if topics.empty?
      "Episode of Lenny's Podcast featuring #{guest}."
    else
      "Episode of Lenny's Podcast featuring #{guest}, covering #{topics.join(', ')}."
    end
  else
    description
  end

  lines = []
  lines << "---"
  lines << "type: source"
  lines << "title: \"#{escape_yaml(title)}\""
  lines << "status: active"
  lines << "created: #{TODAY}"
  lines << "updated: #{TODAY}"
  lines << "tags:"
  lines << "  - source"
  lines << "  - podcast"
  keywords.first(5).each { |keyword| lines << "  - #{keyword}" }
  lines << "guest: \"#{escape_yaml(guest)}\""
  lines << "channel: \"#{escape_yaml(channel)}\"" unless channel.empty?
  lines << "video_id: #{video_id}" unless video_id.empty?
  lines << "youtube_url: #{youtube_url}" unless youtube_url.empty?
  lines << "publish_date: #{publish_date}" unless publish_date.empty?
  lines << "duration: \"#{escape_yaml(duration)}\"" unless duration.empty?
  lines << "duration_seconds: #{duration_seconds}" unless duration_seconds.nil?
  lines << "view_count: #{view_count}" unless view_count.nil?
  lines << "source_files:"
  lines << "  - raw/inbox/#{folder_slug}/transcript.md"
  lines << "source_count: 1"
  lines << "---"
  lines << ""
  lines << "# #{title}"
  lines << ""
  lines << "## Summary"
  lines << ""
  lines << summary
  lines << ""
  lines << "## Metadata"
  lines << ""
  lines << "- Guest: #{guest}"
  lines << "- Publish date: #{publish_date}" unless publish_date.empty?
  lines << "- Duration: #{duration}" unless duration.empty?
  lines << "- Channel: #{channel}" unless channel.empty?
  lines << "- Video: #{youtube_url}" unless youtube_url.empty?
  lines << ""
  lines << "## Themes"
  lines << ""
  if keywords.empty?
    lines << "- None extracted from source metadata."
  else
    keywords.each { |keyword| lines << "- #{keyword}" }
  end
  lines << ""
  lines << "## Description"
  lines << ""
  lines << (description.empty? ? "No description captured in source metadata." : description)
  lines << ""
  lines << "## Connections"
  lines << ""
  if entity_links.empty?
    lines << "- No guest entity links yet."
  else
    entity_links.each { |link| lines << "- #{link}" }
  end
  lines << ""
  lines << "## Open Questions"
  lines << ""
  lines << "- Which ideas from this episode deserve their own concept pages?"
  lines << "- What should be compared against other episodes in the catalog?"
  lines << ""
  lines.join("\n") + "\n"
end

def build_entity_note(name, episodes)
  keywords = count_values(episodes.flat_map { |episode| episode[:keywords] })
    .sort_by { |keyword, count| [-count, keyword] }
    .first(8)
  latest = episodes.max_by { |episode| episode[:publish_date].to_s }
  topic_text = keywords.map(&:first)

  lines = []
  lines << "---"
  lines << "type: entity"
  lines << "title: \"#{escape_yaml(name)}\""
  lines << "status: active"
  lines << "created: #{TODAY}"
  lines << "updated: #{TODAY}"
  lines << "tags:"
  lines << "  - entity"
  lines << "  - podcast-guest"
  lines << "source_count: #{episodes.length}"
  lines << "---"
  lines << ""
  lines << "# #{name}"
  lines << ""
  lines << "## Summary"
  lines << ""
  if topic_text.empty?
    lines << "#{name} appears in #{episodes.length} episode#{episodes.length == 1 ? '' : 's'} of Lenny's Podcast."
  else
    lines << "#{name} appears in #{episodes.length} episode#{episodes.length == 1 ? '' : 's'} of Lenny's Podcast. Recurring metadata themes include #{topic_text.first(5).join(', ')}."
  end
  lines << ""
  lines << "## Episode Count"
  lines << ""
  lines << "- Total episodes: #{episodes.length}"
  if latest
    lines << "- Latest appearance: #{latest[:publish_date]}"
  end
  lines << ""
  lines << "## Recurring Themes"
  lines << ""
  if keywords.empty?
    lines << "- None extracted from source metadata."
  else
    keywords.each { |keyword, count| lines << "- #{keyword} (#{count})" }
  end
  lines << ""
  lines << "## Episodes"
  lines << ""
  episodes.sort_by { |episode| episode[:publish_date].to_s }.reverse_each do |episode|
    lines << "- [[#{episode[:source_link]}]]"
  end
  lines << ""
  lines << "## Open Questions"
  lines << ""
  lines << "- Which ideas from these episodes should become dedicated concept pages?"
  lines << "- What distinguishes this guest's advice from similar guests in the catalog?"
  lines << ""
  lines.join("\n") + "\n"
end

def write_dashboard(path, title, body_lines)
  content = []
  content << "---"
  content << "type: dashboard"
  content << "title: \"#{escape_yaml(title)}\""
  content << "status: active"
  content << "created: #{TODAY}"
  content << "updated: #{TODAY}"
  content << "tags:"
  content << "  - dashboard"
  content << "---"
  content << ""
  content.concat(body_lines)
  content << ""
  File.write(path, content.join("\n"))
end

episodes = []
guest_map = Hash.new { |hash, key| hash[key] = [] }

Dir.glob(RAW_GLOB).sort.each do |path|
  folder_slug = File.basename(File.dirname(path))
  meta = read_frontmatter(path)
  title = clean_text(meta["title"])
  next if title.empty?

  guest_names = parse_guest_names(meta["guest"])
  source_path = source_filename(meta, folder_slug)
  source_link = source_path.sub("#{ROOT}/", "").sub(%r{\A#{Regexp.escape(ROOT)}/}, "").sub(%r{\A#{Regexp.escape(ROOT)}}, "").sub(%r{\A/Users/[^/]+/source/wiki/}, "")
  source_note_name = File.basename(source_path, ".md")
  entity_links = guest_names.map { |name| "[[wiki/entities/#{name}]]" }

  File.write(source_path, build_source_note(meta, folder_slug, entity_links))

  episode = {
    source_link: "wiki/sources/#{source_note_name}",
    title: title,
    guest: clean_text(meta["guest"]),
    guest_names: guest_names,
    publish_date: clean_text(meta["publish_date"]),
    folder_slug: folder_slug,
    keywords: Array(meta["keywords"]).map { |item| clean_text(item) }.reject(&:empty?),
    view_count: meta["view_count"].to_i
  }
  episodes << episode
  guest_names.each { |name| guest_map[name] << episode }
end

guest_map.each do |name, guest_episodes|
  File.write(File.join(ENTITIES_DIR, "#{name}.md"), build_entity_note(name, guest_episodes))
end

episodes_dashboard = []
episodes_dashboard << "# Episodes Dashboard"
episodes_dashboard << ""
episodes_dashboard << "This dashboard lists all ingested Lenny's Podcast episodes in the vault."
episodes_dashboard << ""
episodes_dashboard << "## Episodes"
episodes_dashboard << ""
episodes.sort_by { |episode| [episode[:publish_date].to_s, episode[:title]] }.reverse_each do |episode|
  episodes_dashboard << "- [[#{episode[:source_link]}]] | #{episode[:guest]} | #{episode[:publish_date]}"
end
write_dashboard(File.join(DASHBOARDS_DIR, "Episodes Dashboard.md"), "Episodes Dashboard", episodes_dashboard)

guests_dashboard = []
guests_dashboard << "# Guests Dashboard"
guests_dashboard << ""
guests_dashboard << "This dashboard lists all guest entity pages and their current episode counts."
guests_dashboard << ""
guests_dashboard << "## Guests"
guests_dashboard << ""
guest_map.keys.sort.each do |name|
  guests_dashboard << "- [[wiki/entities/#{name}]] | episodes: #{guest_map[name].length}"
end
write_dashboard(File.join(DASHBOARDS_DIR, "Guests Dashboard.md"), "Guests Dashboard", guests_dashboard)

keyword_counts = count_values(episodes.flat_map { |episode| episode[:keywords] })
  .sort_by { |keyword, count| [-count, keyword] }
topics_dashboard = []
topics_dashboard << "# Topics Dashboard"
topics_dashboard << ""
topics_dashboard << "This dashboard summarizes the most common metadata keywords across ingested podcast episodes."
topics_dashboard << ""
topics_dashboard << "## Top Keywords"
topics_dashboard << ""
keyword_counts.each do |keyword, count|
  topics_dashboard << "- #{keyword} (#{count})"
end
write_dashboard(File.join(DASHBOARDS_DIR, "Podcast Topics Dashboard.md"), "Podcast Topics Dashboard", topics_dashboard)

log_entry = []
log_entry << ""
log_entry << "## [#{TODAY}] ingest | Batch podcast transcript ingest"
log_entry << ""
log_entry << "- Generated or refreshed #{episodes.length} source notes from guest-organized transcript folders."
log_entry << "- Generated or refreshed #{guest_map.length} guest entity pages."
log_entry << "- Generated episode, guest, and topic dashboards for large-scale navigation."
File.open(LOG_PATH, "a") { |file| file.puts(log_entry.join("\n")) }

puts "Episodes: #{episodes.length}"
puts "Guests: #{guest_map.length}"
