config {
format = "compact"
plugin_dir = "~/.tflint.d/plugins"
module = false
}
plugin "terraform" {
enabled = true
preset = "recommended"
}