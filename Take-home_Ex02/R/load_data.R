library(jsonlite)
library(tibble)

# 先检查多个可能的路径
possible_paths <- c(
  "data/MC1/MC1_graph.json",
  "../data/MC1/MC1_graph.json",
  "../../data/MC1/MC1_graph.json"
)

# 找到存在的路径
graph_path <- possible_paths[file.exists(possible_paths)][1]

if(is.na(graph_path)) {
  stop("Cannot find MC1_graph.json file")
}

mc1_raw <- read_json(graph_path, simplifyVector = TRUE)
nodes <- as_tibble(mc1_raw$nodes)
edges <- as_tibble(mc1_raw$links)