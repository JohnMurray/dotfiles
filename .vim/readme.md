# .vim/

Here in lie all the vim configs and what not. Here's a list of the plugins that
I'm currently using. Each plugin also has a hidden `.up` file that contains commands
for how to update the plugin. To run the update (from the project root), run

```bash
rake update_vim_addons
```

## package manager

All of my bundles are managed via Pathogen (update command in `.pathogen.up`)

## bundles
+ `airline` (like powerline for vim)
+ `ctrlp` (fuzzy file search)
+ `json`
+ `markdown`
+ `nerdtree` (file explorer)
+ `ruby`
+ `rust`
+ `scala`
+ `vim-go`
+ `supertab` (tab completion)
