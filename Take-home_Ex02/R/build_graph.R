library(dplyr)
library(tidygraph)
library(igraph)

# Just use all nodes and edges without filtering
# Let's first make sure basic graph creation works
g <- graph_from_data_frame(
  d = edges %>% select(source, target),
  directed = TRUE,
  vertices = nodes %>% select(id)
)

# Convert to tidygraph
g <- as_tbl_graph(g) %>%
  to_undirected() %>%
  activate(nodes) %>%
  mutate(
    pagerank = centrality_pagerank(),
    degree = centrality_degree(),
    community = as.character(group_louvain())
  )

# Join back node attributes
node_attrs <- nodes %>%
  mutate(name_str = as.character(id))

g <- g %>%
  activate(nodes) %>%
  left_join(node_attrs, by = c("name" = "name_str"))