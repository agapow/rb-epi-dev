
def wrap_text(txt, col=60)
  txt.gsub(/(.{1,#{col}})( +|$)\n?|(.{#{col}})/,
    "\\1\\3\n")
end

